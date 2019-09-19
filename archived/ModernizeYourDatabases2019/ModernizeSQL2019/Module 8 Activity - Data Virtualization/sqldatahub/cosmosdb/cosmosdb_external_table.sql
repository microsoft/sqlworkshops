-- Step 1: Create a master key to encrypt the database scoped credentials if they don't exist
USE [WideWorldImporters]
GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'S0me!nfo'
GO

-- Step 2: Create the database scoped credentials with the Azure CosmosDB user and password
-- You can get the IDENTITY (user) and secret (Primary Password) from the Connection String option in the Azure portal
CREATE DATABASE SCOPED CREDENTIAL CosmosDBCredentials   
WITH IDENTITY = '<user>', Secret = '<password>'
GO

-- Step 3: Create a data source for the Azure CosmoDB sderver using the host URI and port
-- The LOCATION is built from <HOST>:<PORT> from the Connection String in the Azure Portal
CREATE EXTERNAL DATA SOURCE CosmosDB
WITH ( 
LOCATION = 'mongodb://<host>:<port>',
PUSHDOWN = ON,
CREDENTIAL = CosmosDBCredentials
)
GO

-- Step 4: Create the schema to hold the external table
CREATE SCHEMA cosmosdb
GO

-- Step 5: Create the external table to match the Azure CosmosDB document
-- The LOCATION is the CosmosDB database and collection you can find using the Data Explorer tool in the Azure Portal
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

-- Step 6: Create local statistics
CREATE STATISTICS CosmosDBOrderSalesPersonStats ON cosmosdb.Orders ([SalesPersonPersonID]) WITH FULLSCAN
GO

-- Step 7: Scan the table to make sure it works
SELECT * FROM cosmosdb.Orders
GO

-- Step 8: Filter on a specific SalesPersonPersonID
SELECT * FROM cosmosdb.Orders WHERE SalesPersonPersonID = 2
GO

-- Step 9: Find out the name of the salesperson and which customer they worked with to test out the new mobile app experience.
SELECT FullName, o.CustomerName, o.CustomerContact, o.OrderDate
FROM cosmosdb.Orders o
JOIN [Application].[People] p
ON o.SalesPersonPersonID = p.PersonID
GO
