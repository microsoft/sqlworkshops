-- Step 1: Create a master key to encrypt the database scoped credentials if they don't exist
USE [WideWorldImporters]
GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'S0me!nfo'
GO

-- Step 2: Create the database scoped credentials with the Oracle login and password
CREATE DATABASE SCOPED CREDENTIAL OracleCredentials   
WITH IDENTITY = '<login>', Secret = '<password>'
GO

-- Step 3: Create a data source for the name of the server hosting the ORACLE instance and listener port
CREATE EXTERNAL DATA SOURCE OracleServer
WITH ( 
LOCATION = 'oracle:/<oracle server>:<listener port>',
PUSHDOWN = ON,
CREDENTIAL = OracleCredentials
)
GO

-- Step 4: Create the schema to hold the external table
CREATE SCHEMA oracle
GO

-- Step 5: Create the external table to match the Oracle table
-- The LOCATION  is <instance>.<schema>.<table>
CREATE EXTERNAL TABLE oracle.accountsreceivable
(
arid int,
ardate date,
ardesc nvarchar(100) COLLATE Latin1_General_100_CI_AS,
arref int,
aramt decimal(10,2)

)
 WITH (
 LOCATION='[XE].[GL].[ACCOUNTSRECEIVABLE]',
 DATA_SOURCE=OracleServer
)
GO

-- Step 6: Create local statistics
CREATE STATISTICS arrefstats ON oracle.accountsreceivable ([arref]) WITH FULLSCAN
GO

-- Step 7: Scan the table to make sure it works
SELECT * FROM oracle.accountsreceivable
GO

-- Step 8: Find a specific accounts reference #
SELECT * FROM oracle.accountsreceivable
WHERE arref = 336252
GO

-- Step 9: Find accts receivable data based on CustomerTransactionID (which matches arref in the AR tables in Oracle)
SELECT ct.*, oa.arid, oa.ardesc
FROM oracle.accountsreceivable oa
JOIN [Sales].[CustomerTransactions] ct
ON oa.arref = ct.CustomerTransactionID
GO