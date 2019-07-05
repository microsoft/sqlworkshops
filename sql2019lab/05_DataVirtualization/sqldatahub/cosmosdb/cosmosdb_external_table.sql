USE [WideWorldImporters]
GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'S0me!nfo'
GO
/*  specify credentials to external data source
*  IDENTITY: user name for external source.  
*  SECRET: password for external source.
*/
DROP DATABASE SCOPED CREDENTIAL CosmosDBCredentials
GO
-- You can get the IDENTITY (user) and secret (password) from the Connection String option in the
-- Azure portal
CREATE DATABASE SCOPED CREDENTIAL CosmosDBCredentials   
WITH IDENTITY = 'wwi', Secret = 'hSoxMUeEgNjeeWh4FTz5jmGRlSN4Ko6HoYqiJsbleFzewe86EEXJrvwkAqBgitypJdjUbeJqnTVNBO6NUa0DZQ=='
GO
DROP EXTERNAL DATA SOURCE CosmosDB
GO
-- The LOCATION is built from <HOST>:<PORT> from the Connection String in the Azure Portal
CREATE EXTERNAL DATA SOURCE CosmosDB
WITH ( 
LOCATION = 'mongodb://wwi.documents.azure.com:10255',
PUSHDOWN = ON,
CREDENTIAL = CosmosDBCredentials
)
GO
DROP SCHEMA cosmosdb
go
CREATE SCHEMA cosmosdb
GO
/*  LOCATION: sql server table/view in 'database_name.schema_name.object_name' format
*  DATA_SOURCE: the external data source, created above.
*/
DROP EXTERNAL TABLE cosmosdb.Orders
GO
CREATE EXTERNAL TABLE cosmosdb.Orders
(
	[_id] NVARCHAR(100) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[id] NVARCHAR(100) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[OrderID] int NOT NULL,
	[SalesPersonPersonID] int NOT NULL,
	[CustomerName] NVARCHAR(100) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[CustomerContact] NVARCHAR(100) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[OrderDate] NVARCHAR(100) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[CustomerPO] NVARCHAR(100) COLLATE Latin1_General_100_CI_AS NULL,
	[ExpectedDeliverDate] NVARCHAR(100) COLLATE Latin1_General_100_CI_AS NOT NULL
)
 WITH (
 LOCATION='WideWorldImporters.Orders',
 DATA_SOURCE=CosmosDB
)
GO
CREATE STATISTICS CosmosDBOrderSalesPersonStats ON cosmosdb.Orders ([SalesPersonPersonID]) WITH FULLSCAN
GO

-- Scan the external table just to make sure it works
--
SELECT * FROM cosmosdb.Orders
GO
-- Filter on a specific SalesPersonPersonID
--
SELECT * FROM cosmosdb.Orders WHERE SalesPersonPersonID = 2
GO
-- Find out the name of the salesperson and which customer they worked with
-- to test out the new mobile app experience.
SELECT FullName, o.CustomerName, o.CustomerContact, o.OrderDate
FROM cosmosdb.Orders o
JOIN [Application].[People] p
ON o.SalesPersonPersonID = p.PersonID
GO
