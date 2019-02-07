![](graphics/solutions-microsoft-logo-small.png)

# Secure Machine Learning with SQL Server and Microsoft Azure AI

## 05 Deployment

<p style="border-bottom: 1px solid lightgrey;"></p> 
<dl>
  <dt>Course Outline</dt>
  <dt>1 Overview and Course Setup</dt>
  <dt>2 Business Understanding</dt>
  <dt>3 Data Acquisition and Understanding</dt>
  <dt>4 Modeling</dt>
  <dt>5 Deployment <i>(This section)</i></dt>
        <dd>5.1 Move the R Code to a Stored Procedure</dd>
        <dd>5.2 Call the Stored Procedure</dd>
  <dt>6 Customer Acceptance and Model Retraining</dt>
<dl>
<p style="border-bottom: 1px solid lightgrey;"></p> 

In this phase you'll take the trained model and any other necessary assets and deploy them to a system that will respond to API requests.

Goal for Deployment
- Deploy models with a data pipeline to a production or production-like environment for final user acceptance

How to do it
- Deploy the model and pipeline to a production or production-like environment for application consumption

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>5.1 Move the R Code to a Stored Procedure</b></p>

In this section, you will move the R code we just wrote to SQL Server and deploy your predictive model with the help of SQL Server Machine Learning Services. To deploy a model, you store the model in a hosting environment (like a database) and implement a prediction function that uses the model to predict. That function can be called from applications.

SQL Server ML Services enables you to train and test predictive models using R locally as you did in the last module, or in the context of SQL Server. You can author T-SQL programs that contain embedded R scripts, and the SQL Server database engine takes care of the execution. Because it executes in SQL Server, your models can easily be trained against data stored in the database. To deploy, you store your model in the database and create a stored procedure that predicts using the model. The model is stored as a binary object in SQL Server, so begin by making a SQL Server table to hold the binary object.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity: Create a table for the binary Model</b></p>

- Connect to SQL Server with a SQL query tool, and run the following code:

<pre>
USE TutorialDB;
DROP TABLE IF EXISTS rental_rx_models;
GO
CREATE TABLE rental_rx_models (
                model_name VARCHAR(30) NOT NULL DEFAULT('default model') PRIMARY KEY,
                model VARBINARY(MAX) NOT NULL
);
GO
</pre>

With that table in place, you can now create your Stored Procedure in SQL Server to use the R code you wrote in the previous module and generate the rxDTree model inside the database. The R code will be embedded in the TSQL statement. 

From your SQL query tool, run the following code: 

<pre>

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
</pre>

- Now you can store the trained binary Model to the table you made in the previous steps. From your SQL query tool, run the following code: 

<pre>
-- Save the binary Model to table 
TRUNCATE TABLE rental_rx_models;

DECLARE @model VARBINARY(MAX);
EXEC generate_rental_rx_model @model OUTPUT;

INSERT INTO rental_rx_models (model_name, model) VALUES('rxDTree', @model);

SELECT * FROM rental_rx_models;
</pre>

- Everything is in place. You're ready to create a Stored Procedure that users will call in their applications that will take in data and create a prediction for the ski shop. From your SQL query tool, run the following code: 

<pre>
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
</pre>


<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/thinking.jpg"><b>For Further Study</b></p>
 - Another example of using a Stored Procedure to predict data using R and SQL Server: https://docs.microsoft.com/en-us/sql/advanced-analytics/tutorials/rtsql-create-a-predictive-model-r?view=sql-server-2017
