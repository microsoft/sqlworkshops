-- Step 1: Create a master key to encrypt the database scoped credentials if they don't exist
USE [WideWorldImporters]
GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'S0me!nfo'
GO

-- Step 2: Create the database scoped credentials with the SQL 2008 R2 login and password
CREATE DATABASE SCOPED CREDENTIAL SqlServerCredentials   
WITH IDENTITY = '<login>', Secret = '<password>'
GO

-- Step 3: Create a data source for the name of the SQL Server 2008 R2 server
CREATE EXTERNAL DATA SOURCE SQLServerInstance
WITH ( 
LOCATION = 'sqlserver://<sql server name>',
PUSHDOWN = ON,
CREDENTIAL = SQLServerCredentials,
CONNECTION_OPTIONS = 'UseDefaultEncryptionOptions=false' -- This is a workaround for a bug in SQL 2019 CTP 2.3 under investigation.
)
GO

-- Step 4: Create the schema to hold the external table
CREATE SCHEMA sqlserver
GO

-- Step 5: Create the external table to match the SQL Server 2008 R2 table
-- For LOCATION, put in the fully qualified table name.
CREATE EXTERNAL TABLE sqlserver.suppliers
(
	[SupplierID] [int] NOT NULL,
	[SupplierName] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[SupplierCategoryID] [int] NOT NULL,
	[PrimaryContactPersonID] [int] NOT NULL,
	[AlternateContactPersonID] [int] NOT NULL,
	[DeliveryMethodID] [int] NULL,
	[DeliveryCityID] [int] NOT NULL,
	[PostalCityID] [int] NOT NULL,
	[SupplierReference] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BankAccountName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BankAccountBranch] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BankAccountCode] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BankAccountNumber] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BankInternationalCode] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PaymentDays] [int] NOT NULL,
	[PhoneNumber] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FaxNumber] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[WebsiteURL] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[DeliveryAddressLine1] [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[DeliveryAddressLine2] [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DeliveryPostalCode] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PostalAddressLine1] [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PostalAddressLine2] [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PostalPostalCode] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[LastEditedBy] [int] NOT NULL
)
 WITH (
 LOCATION='JustWorldImporters.dbo.Suppliers',
 DATA_SOURCE=SqlServerInstance
)
GO

-- Step 6: Create local statistics
CREATE STATISTICS SupplierNameStatistics ON sqlserver.suppliers ([SupplierName]) WITH FULLSCAN
GO

-- Step 7: Scan the table to make sure it works
SELECT * FROM sqlserver.suppliers
GO

-- Step 8: Find a specific supplier
SELECT * FROM sqlserver.suppliers where SupplierName = 'Brooks Brothers'
GO

-- Step 9: Find all former clothing suppliers and their city
SELECT s.SupplierName, s.SupplierReference, c.cityname
FROM sqlserver.suppliers s
JOIN [Purchasing].[SupplierCategories] sc
on s.SupplierCategoryID = sc.SupplierCategoryID
and sc.SupplierCategoryName = 'Clothing Supplier'
JOIN [Application].[Cities] c
ON s.DeliveryCityID = c.CityID
GO