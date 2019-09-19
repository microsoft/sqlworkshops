-- Step 1: Create a master key to encrypt the database scoped credentials if they don't exist
USE [WideWorldImporters]
GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'S0me!nfo'
GO

-- Step 2: Create the database scoped credentials with the SAP HANA login and password
CREATE DATABASE SCOPED CREDENTIAL SAPHANACredentials   
WITH IDENTITY = '<login>', Secret = '<password>'
GO

-- Step 3: Create a data source for the name of the server hosting SAP HANA and port
-- LOCATION indicates what ODBC data source to used that you configured for the SAP driver
-- CONNECTION_OPTIONS is connectiong string details to feed the driver.
CREATE EXTERNAL DATA SOURCE SAPHANAServer
WITH ( 
LOCATION = 'odbc://<datasource>',
CONNECTION_OPTIONS = 'Driver={HDBODBC};ServerNode=<server>:<port>',
PUSHDOWN = ON,
CREDENTIAL = SAPHANACredentials
)
GO

-- Step 4: Create the schema to hold the external table
CREATE SCHEMA saphana
GO

-- Step 5: Create the external table to match the SAP HANA table.
-- The LOCATION is the <schema>.<table>
CREATE EXTERNAL TABLE saphana.customers
(
CustomerID int,
CustomerName nvarchar(100) COLLATE Latin1_General_100_CI_AS,
AccountOpenedDate date,
CustomerWebSite nvarchar(256) COLLATE Latin1_General_100_CI_AS
)
 WITH (
 LOCATION='[BWSAPHANA].[CUSTOMERS]',
 DATA_SOURCE=SAPHANAServer
)
GO

-- Step 6: Create local statistics
CREATE STATISTICS customerstats ON saphana.customers ([CustomerName]) WITH FULLSCAN
GO

-- Step 7: Let's scan the table to make sure it works
SELECT * FROM saphana.customers
GO

-- Step 8: Union with our current customers
SELECT CustomerID, CustomerName, AccountOpenedDate, CustomerWebSite
FROM saphana.customers
UNION
SELECT CustomerID, CustomerName, AccountOpenedDate, WebsiteURL
FROM Sales.Customers
GO