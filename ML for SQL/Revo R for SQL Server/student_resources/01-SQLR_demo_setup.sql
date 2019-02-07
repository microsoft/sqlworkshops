
-- let's enable external scripts so that SQL Server can make calls to the R server
EXEC sp_configure  'external scripts enabled', 1  
Reconfigure  with  override  

-- you need to restart SQL Server at this point then run this to double check
EXEC sp_configure  'external scripts enabled'

-- here's a very basic example we can run to make sure everything worked
EXEC sp_execute_external_script  @language =N'R',  
@script=N'OutputDataSet <- InputDataSet',    
@input_data_1 =N'select 1 as hello'  
with result sets (([hello] int not null));  
GO

-- this could be useful for debugging purposes
EXEC sp_execute_external_script  @language =N'R',  
@script=N'print(.libPaths())
          print(R.version)
          print(Revo.version)'
GO

-- ignore this line unless you are using the Data Science VM 
-- CREATE LOGIN [SERVERNAME\SQLRUserGroup] FROM WINDOWS

-- create credentials for a user to log into R

USE master; 
GO  
CREATE DATABASE RDB;
GO

USE [master]
GO
CREATE LOGIN [ruser] WITH PASSWORD=N'ruser', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

USE RDB
GO
CREATE USER [ruser] FOR LOGIN [ruser]
ALTER ROLE [db_datareader] ADD MEMBER [ruser]
ALTER ROLE [db_datawriter] ADD MEMBER [ruser]
ALTER ROLE [db_ddladmin] ADD MEMBER [ruser]
GO

USE RDB
GO  
GRANT EXECUTE ANY EXTERNAL SCRIPT  TO [ruser] 
GO

use [RDB]
GO
GRANT EXECUTE TO [ruser]
GO

-- we create a table for storing model objects created by R
-- DROP TABLE RDB.dbo.models 
-- GO

CREATE TABLE RDB.dbo.models 
(model varbinary(max))
GO


-- create a stored procedure for storing model objects into a SQL table
-- we will call this stored procedure from the R IDE
use [RDB]
GO
CREATE PROCEDURE [dbo].[PersistModel]
@m nvarchar(max)
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
SET NOCOUNT ON;
insert into models (model) values (convert(varbinary(max),@m,2))
END


-- R and Data Optimization (R Services)
-- https://msdn.microsoft.com/en-us/library/mt723575.aspx

-- SQL Server R Services Performance Tuning
-- https://msdn.microsoft.com/en-us/library/mt723573.aspx

-- Model management with SQL Server R Services
-- https://blogs.technet.microsoft.com/dataplatforminsider/2016/10/17/sql-server-as-a-machine-learning-model-management-system/

-- Displaying R plots in SSRS
-- https://www.mssqltips.com/sqlservertip/4127/sql-server-2016-r-services-display-r-plots-in-reporting-services/
