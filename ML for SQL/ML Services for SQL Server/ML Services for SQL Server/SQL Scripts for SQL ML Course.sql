/* Course Setup and Configuration */

EXEC sp_configure 'external scripts enabled', 1; 

RECONFIGURE WITH OVERRIDE 

-- Restart Instance

/* The dataset used in this course is hosted in a SQL Server table.The table contains rental data from previous years. 
The backup (.bak) file is in the  ./data  directory called TutorialDB.bak, and save it on a location that SQL Server 
can access, for example in the folder where SQL Server is installed. 
Example path: C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Backup */

USE master;
GO
RESTORE DATABASE TutorialDB
   FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\TutorialDB.bak'
   WITH
				MOVE 'TutorialDB' TO 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\TutorialDB.mdf'
				,MOVE 'TutorialDB_log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\TutorialDB.ldf';
GO

USE tutorialdb;
SELECT * FROM [dbo].[rental_data];
GO

/* Operationalize the Model into SQL Server */
USE TutorialDB;
DROP TABLE IF EXISTS rental_rx_models;
GO
CREATE TABLE rental_rx_models (
				model_name VARCHAR(30) NOT NULL DEFAULT('default model') PRIMARY KEY,
				model VARBINARY(MAX) NOT NULL
);
GO

-- This Stored Procedure that trains and generates an R model using the rental_data and a decision tree algorithm
DROP PROCEDURE IF EXISTS generate_rental_rx_model;
go
CREATE PROCEDURE generate_rental_rx_model (@trained_model varbinary(max) OUTPUT)
AS
BEGIN
	EXECUTE sp_execute_external_script
	  @language = N'R'
	, @script = N'
		require("RevoScaleR");

			rental_train_data$Holiday = factor(rental_train_data$Holiday);
			rental_train_data$Snow = factor(rental_train_data$Snow);
			rental_train_data$WeekDay = factor(rental_train_data$WeekDay);

		#Create a dtree model and train it using the training data set
		model_dtree <- rxDTree(RentalCount ~ Month + Day + WeekDay + Snow + Holiday, data = rental_train_data);
		#Before saving the model to the DB table, we need to serialize it
		trained_model <- as.raw(serialize(model_dtree, connection=NULL));'

	, @input_data_1 = N'select "RentalCount", "Year", "Month", "Day", "WeekDay", "Snow", "Holiday" from dbo.rental_data where Year < 2015'
	, @input_data_1_name = N'rental_train_data'
	, @params = N'@trained_model varbinary(max) OUTPUT'
	, @trained_model = @trained_model OUTPUT;
END;
GO

-- Save the binary Model to table 
TRUNCATE TABLE rental_rx_models;

DECLARE @model VARBINARY(MAX);
EXEC generate_rental_rx_model @model OUTPUT;

INSERT INTO rental_rx_models (model_name, model) VALUES('rxDTree', @model);

SELECT * FROM rental_rx_models;

-- Stored procedure that takes model name and new data as input parameters and predicts the rental count for the new data
DROP PROCEDURE IF EXISTS predict_rentalcount_new;
GO
CREATE PROCEDURE predict_rentalcount_new (@model VARCHAR(100),@q NVARCHAR(MAX))
AS
BEGIN
	DECLARE @rx_model VARBINARY(MAX) = (SELECT model FROM rental_rx_models WHERE model_name = @model);
	EXECUTE sp_execute_external_script 
		@language = N'R'
		, @script = N'
			require("RevoScaleR");

			#The InputDataSet contains the new data passed to this stored proc. We will use this data to predict.
			rentals = InputDataSet;
			
		#Convert types to factors
			rentals$Holiday = factor(rentals$Holiday);
			rentals$Snow = factor(rentals$Snow);
			rentals$WeekDay = factor(rentals$WeekDay);

			#Before using the model to predict, we need to unserialize it
			rental_model = unserialize(rx_model);

			#Call prediction function
			rental_predictions = rxPredict(rental_model, rentals);'
				, @input_data_1 = @q
		, @output_data_1_name = N'rental_predictions'
				, @params = N'@rx_model varbinary(max)'
				, @rx_model = @rx_model
				WITH RESULT SETS (("RentalCount_Predicted" FLOAT));
   
END;
GO

-- Execute the predict_rentals stored proc and pass the model name and a query string with a set of features we want to use to predict the rental count
EXEC dbo.predict_rentalcount_new @model = 'rxDTree',
	   @q ='SELECT CONVERT(INT, 3) AS Month, CONVERT(INT, 24) AS Day, CONVERT(INT, 4) AS WeekDay, CONVERT(INT, 1) AS Snow, CONVERT(INT, 1) AS Holiday';
GO
