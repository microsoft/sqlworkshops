/* R Services for SQL Server Lab.sql
Author: Buck Woody, Microsoft
Last Updated: 01/16/2017

1. Using SQL Server Data from R with an ODBC-Like call
https://msdn.microsoft.com/en-us/library/mt629161.aspx 
 

2. Using SQL Server Data with R in SQL Server

Prepare your system: 

Ensure the AdventureWorks 2012 OLTP database is installed: 	https://msftdbprodsamples.codeplex.com/releases/view/55330 

Download the Data File, put it here:
	C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA 

Now "attach" that database file in SQL Server. Ask the instructor if you have not done this before.
*/

/* Check to see if R is Installed and available */
EXEC sp_execute_external_script  
@language =N'R',  
-- SQL Part    
@input_data_1 =N'SELECT 1 as Installed'  ,
-- R Part
@script=N'OutputDataSet<-InputDataSet'
-- Return R Results to SQL
WITH RESULT SETS 
(([Installed] int not null));  
GO

-- If 0 or error, install R, then enable
USE [master]
GO
EXEC sp_configure 'external scripts enabled', 1;
RECONFIGURE WITH OVERRIDE;
GO
-- NOTE: LaunchPad Windows Service must be running

/* Simple Example using internal R Data
https://msdn.microsoft.com/en-us/library/mt591996.aspx 
 */
EXEC sp_execute_external_script
  @language = N'R'
, @input_data_1 = N'SELECT 1 as Col'
, @script = N'OutputDataSet <- subset(iris, select=-Species);'
WITH RESULT SETS 
	(("Sepal.Length" float not null
	, "Sepal.Width" float not null
	, "Petal.Length" float not null
	, "Petal.Width" float not null));
-- SELECT INTO here
GO

/* Now let's use T-SQL to explore data */
USE AdventureWorks2012;
GO

EXEC sp_help 'Sales.SalesOrderDetail'
EXEC sp_help 'Sales.SalesOrderHeader'
EXEC sp_help 'Person.Address'
EXEC sp_help 'Person.StateProvince'
EXEC sp_help ' Production.Product'

-- Get the Data for where goods are shipped to
SELECT 
  PP.Name
, SOD.LineTotal
, PA.City
, PSP.Name
FROM Sales.SalesOrderDetail SOD
 -- Get header information
 INNER JOIN Sales.SalesOrderHeader AS SOH ON SOD.SalesOrderID = SOH.SalesOrderID
	-- Get City
	INNER JOIN Person.Address AS PA on SOH.ShipToAddressID = PA.AddressID
		-- Get State
		INNER JOIN Person.StateProvince AS PSP ON PA.StateProvinceID = PSP.StateProvinceID
			-- Get Product Name
			INNER JOIN Production.Product AS PP ON SOD.ProductID = PP.ProductID

-- Get Amounts
SELECT 
  SUM(SOD.LineTotal)
FROM Sales.SalesOrderDetail SOD
 -- Get header
 INNER JOIN Sales.SalesOrderHeader AS SOH ON SOD.SalesOrderID = SOH.SalesOrderID
	-- Get City
	INNER JOIN Person.Address AS PA on SOH.ShipToAddressID = PA.AddressID
		-- Get State
		INNER JOIN Person.StateProvince AS PSP ON PA.StateProvinceID = PSP.StateProvinceID
			-- Get Product Name
			INNER JOIN Production.Product AS PP ON SOD.ProductID = PP.ProductID
WHERE PSP.Name = 'Florida';
GO

/* 
Now - is the purchase level statistically different? This is harder to do in T-SQL:
	(mean of the first set - mean of the second set)/square root((square(standard deviation of the first set/total number of values in the first set)) + (square(standard deviation of the second set/total number of values in the second set))) 
	http://www.thinkcalculator.com/statistics/t-test-formula.jpg
*/

-- But VERY easy to do in R:
EXEC sp_execute_external_script
-- R Language
  @language = N'R'

-- SQL Statement
, @input_data_1 = N'SELECT 
 PSP.Name, SOD.LineTotal
FROM Sales.SalesOrderDetail SOD
-- Get header
INNER JOIN Sales.SalesOrderHeader AS SOH ON SOD.SalesOrderID = SOH.SalesOrderID
       -- Get City
       INNER JOIN Person.Address AS PA on SOH.ShipToAddressID = PA.AddressID
              -- Get State
              INNER JOIN Person.StateProvince AS PSP ON PA.StateProvinceID = PSP.StateProvinceID
                     -- Get Product Name
                     INNER JOIN Production.Product AS PP ON SOD.ProductID = PP.ProductID
WHERE PSP.Name = ''Florida'' OR PSP.Name = ''Georgia'''

-- A single test (t.test) funtion gets us the answer:
, @script = N'
a <- subset(InputDataSet, Name == "Florida")
b <- a$LineTotal
c <- subset(InputDataSet, Name == "Georgia")
d <- c$LineTotal
print(t.test(b,d))'

/*
Package considerations: 
*/

-- This is your true R path for SQL Server
EXEC sp_execute_external_script  @language =N'R'
,  
	@script=N'OutputDataSet <- data.frame(path = .libPaths())',    
	@input_data_1 =N'select 1 as ReturnVal'  
WITH RESULT SETS (([path] varchar(250) not null));  
GO

-- This is your true user for SQL Server R Services
EXEC sp_execute_external_script  @language =N'R'
,  
	@script=N'OutputDataSet <- data.frame(fieldname = names(Sys.info()), value = Sys.info())',    
	@input_data_1 =N'select 1 as ReturnVal'  
WITH RESULT SETS (([fieldname] varchar(250) , [value] varchar(250)));  
GO

/* Performance Tuning */
-- Examine SQL Server Satellite processes in Extended Events: 
SELECT o.name
, o.description  
FROM sys.dm_xe_objects o  
	INNER JOIN sys.dm_xe_packages p  
		ON o.package_guid = p.guid  
WHERE o.object_type = 'event'  
	AND p.name = 'SQLSatellite'  
ORDER BY o.name;   
GO

-- Check the DMV's you have for performance:
SELECT * 
FROM sys.dm_os_performance_counters 
WHERE object_name LIKE '%External%'; 
GO

-- Control performance using Resource Governor - let's look at the usage first: 
SELECT * FROM 
sys.resource_governor_resource_pools 
WHERE name = 'default' 

SELECT * 
FROM sys.resource_governor_external_resource_pools 
WHERE name = 'default'  

-- Now we'll balance the memory for internal/external pools
ALTER RESOURCE POOL "default" 
WITH (max_memory_percent = 60);  
GO

ALTER EXTERNAL RESOURCE POOL "default" 
WITH (max_memory_percent = 40);  
GO

ALTER RESOURCE GOVERNOR reconfigure;  
GO

-- This affects all connections - better to create a classifier function:
-- https://msdn.microsoft.com/en-us/library/mt703706.aspx 

/* Security 
Check the User Account Pool by looking in Windows for the MSSQLSERVER0n accounts, also SQLRUserGroup in Windows. Follow along with the instructor. 
These are used for impersonation in R
TDE Not supported at this time for R data
More on security configuration: https://msdn.microsoft.com/en-us/library/mt590869.aspx 
*/


/* Package Management */

-- This one is installed
EXEC sp_execute_external_script  @language =N'R'
,  
	@script=N'OutputDataSet <- data.frame(path = require(dplyr))',    
	@input_data_1 =N'select 1 as ReturnVal'  
WITH RESULT SETS (([path] varchar(250) not null));  
GO

-- This one is not
EXEC sp_execute_external_script  @language =N'R'
,  
	@script=N'OutputDataSet <- data.frame(path = require(lubridate))',    
	@input_data_1 =N'select 1 as ReturnVal'  
WITH RESULT SETS (([path] varchar(250) not null));  
GO

-- Packages must use the R environment from here: C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\R_SERVICES\bin> 

/* 
# An example of this in R:
Sys.getenv()
installed.packages

# Install a package
install.packages("xgboost")

library(xgboost) 

data(agaricus.train, package='xgboost')
data(agaricus.test, package='xgboost')
train <- agaricus.train
test <- agaricus.test
bst <- xgboost(data = train$data, label = train$label, max.depth = 2, eta = 1, nthread = 2, nround = 2, objective = "binary:logistic")
#[0]	train-error:0.046522
#[1]	train-error:0.022263
pred <- predict(bst, test$data)
pred

https://msdn.microsoft.com/en-us/library/mt591989.aspx 

*/

/* And now to create a predictive model in SQL Server and R using Machine Learning:
ML Lab Setup: 
Next, Copy the file telcoedw.bak from the \Resources directory to the following directory of a default SQL Server 2016 Instance: 
C:\Program Files\Microsoft SQL Server\MSSQL13\MSSQL\Backup
Restore that database - directions below

Tables: 
edw_cdr - Base Call Detail Records (CDR)

edw_cdr_train - Training data
edw_cdr_test - Test data

cdr_rx_models - Contains the serialized R models that are used for predicting customer churn
edw_cdr_test_pred - Predicted results

Stored Procedures:
[dbo].[generate_cdr_rx_BTrees] - Generates a model using B-Trees
[dbo].[generate_cdr_rx_DForest] - Generates a model using a Decision Forest
[dbo].[generate_cdr_xgboost] - Generates a model using a Boosted Decision Forest

[dbo].[predict_cdr_churn_rx_forest] - Fills a table with the results of a prediction using a Decision Forest
[dbo].[predict_cdr_churn_rx_boost] - Fills a table with the results of a prediction using a Boosted Decision Forest
[dbo].[predict_cdr_churn_xgboost] - Fills a table with the results of a prediction usinga Gradient Boosting framework

[dbo].[model_evaluate] - Evaluate a prediction model
[dbo].[model_roccurve] - Creates an ROC of the prediction model

[dbo].[heatmap] - Creates a graphic object of a heatmap of the prediction model
[dbo].[histogram] - Creates a graphic object of a heatmap of the prediction model
[dbo].[importance] - Creates a graphic object of a heatmap of the prediction model
[dbo].[pareto] - Creates a graphic object of a Pareto map of the prediction model
*/

USE [master]
RESTORE DATABASE [telcoedw] 
FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Backup\telcoedw.bak' WITH  FILE = 1
,  MOVE N'telcoedw2' TO N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\telcoedw.mdf'
,  MOVE N'telcoedw2_log' TO N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\telcoedw_log.ldf'
,  NOUNLOAD,  REPLACE,  STATS = 5
GO

USE [telcoedw] 
GO

-- Examine the data - can you explore further? What else can you learn?
SELECT * 
FROM edw_cdr;
GO

/* Step 1 - Train the customer churn model
-- EXEC sp_helptext 'generate_cdr_rx_DForest';
This creates a binary representation of the model */
EXEC generate_cdr_rx_DForest;
GO

/* Show the serialized model */
SELECT * 
FROM cdr_rx_models;
GO

/* Step 2 - Score the model- In this step, you will invoke the stored procedure predict_cdr_churn_forst
The stored procedure uses the rxPredict function to predict the customers that are likely to churn
Results are returned as an output dataset */
DROP TABLE IF EXISTS edw_cdr_test_pred;
GO

CREATE TABLE edw_cdr_test_pred(
customerid int,
churn varchar(255),
probability float,
prediction float
);
GO

-- EXEC sp_helptext 'predict_cdr_churn_rx_forest';
INSERT INTO edw_cdr_test_pred
EXEC predict_cdr_churn_rx_forest 'rxDForest';
GO

SELECT * 
FROM edw_cdr_test_pred; 
GO

/* Step 3 - Evaluate the model
This uses test data to evaluate the performance of the model. 
Want to know more? 
http://docs.statwing.com/the-confusion-matrix-and-the-precision-recall-tradeoff/ 
https://en.wikipedia.org/wiki/F1_score 
*/
-- EXEC sp_helptext 'model_evaluate';
EXEC model_evaluate;
GO

/* Step 4 - Repeat Step 2-3 to invoke and evaluate Boosted Decision Tree model */
TRUNCATE TABLE edw_cdr_test_pred;
GO

-- EXEC sp_helptext 'predict_cdr_churn_rx_boost';
insert into edw_cdr_test_pred
exec [dbo].[predict_cdr_churn_rx_boost] 'rxBTrees';
GO

SELECT * 
FROM edw_cdr_test_pred
ORDER BY prediction DESC;
GO

EXEC model_evaluate;
GO

/* Step 5 - Repeat Step 2-3 to invoke and evaluate Xgboost model */
TRUNCATE TABLE edw_cdr_test_pred;
GO

-- EXEC sp_helptext 'predict_cdr_churn_xgboost';
insert into edw_cdr_test_pred
exec predict_cdr_churn_xgboost 'rxBTrees';
go

select * 
from edw_cdr_test_pred; 
GO

exec model_evaluate;
GO

/* 
If you would like to try an ODBC call to a Database, open an R client (not SQL Server) and run this code - change the names and passwords. 
In an R Client, try the following code:

library(RevoScaleR)  
  
# Define the connection string  
# This walkthrough requires SQL authentication  
connStr <- "Driver=SQL Server;Server=<SQL_instance_name>;Database=<database_name>;Uid=<user_name>;Pwd=<user password>"  
  
# Set ComputeContext.   
sqlShareDir <- paste("C:\\AllShare\\",Sys.getenv("USERNAME"),sep="")  
sqlWait <- TRUE  
sqlConsoleOutput <- FALSE  
cc <- RxInSqlServer(connectionString = connStr, shareDir = sqlShareDir,   
                    wait = sqlWait, consoleOutput = sqlConsoleOutput)  
rxSetComputeContext(cc)  
  
#Define a DataSource   
sampleDataQuery <- "select top 1000 tipped, fare_amount, passenger_count,trip_time_in_secs,trip_distance,   
    pickup_datetime, dropoff_datetime, pickup_longitude, pickup_latitude, dropoff_longitude,    
    dropoff_latitude from nyctaxi_sample"  
  
inDataSource <- RxSqlServerData(sqlQuery = sampleDataQuery, connectionString = connStr,   
                                colClasses = c(pickup_longitude = "numeric", pickup_latitude = "numeric",   
                                               dropoff_longitude = "numeric", dropoff_latitude = "numeric"),  
                                rowsPerRead=500)  

# Inspect the data
rxGetVarInfo(data = inDataSource)   

# Summarize fare_amount based on passenger_count
start.time <- proc.time()  
rxSummary(~fare_amount:F(passenger_count), data = inDataSource)  
used.time <- proc.time() - start.time  
print(paste("It takes CPU Time=", round(used.time[1]+used.time[2],2)," seconds, Elapsed Time=", round(used.time[3],2), " seconds to summarize the inDataSource.", sep="")) 
*/