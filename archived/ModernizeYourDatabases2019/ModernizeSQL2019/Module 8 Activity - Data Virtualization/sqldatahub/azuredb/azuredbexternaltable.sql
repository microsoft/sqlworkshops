-- Step 1: Create a master key to encrypt the database credential
USE [WideWorldImporters]
GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'S0me!nfo'
GO

-- Step 2: Create a database credential that stores the login and password to the Azure SQL Server Database
-- IDENTITY = login
-- SECRET = password
CREATE DATABASE SCOPED CREDENTIAL AzureSQLDatabaseCredentials   
WITH IDENTITY = '<login>', SECRET = '<password>'
GO

-- Step 3: Create an external data source
-- sqlserver is a keyword meaning the data source is a SQL Server, Azure SQL Database, or Azure SQL Data Warehouse
-- The name after :// is the Azure SQL Server Database server. Your SQL Server must be on the same vnet as the Azure SQL Server Database or must pass through its firewall rules
CREATE EXTERNAL DATA SOURCE AzureSQLDatabase
WITH ( 
LOCATION = 'sqlserver://<azure sql database server URI>',
PUSHDOWN = ON,
CREDENTIAL = AzureSQLDatabaseCredentials
)
GO

-- Step 4: Create a schema in the WideWorldImporters for the external table
CREATE SCHEMA azuresqldb
GO

-- Step 5: Create the EXTERNAL TABLE
-- Each column must match the column in the remote table
-- Notice the character columns use a collation that is compatible with the target table
-- The WITH clause includes the name of the remote [database].[schema].[table] and the external database source
CREATE EXTERNAL TABLE azuresqldb.ModernStockItems
(
	[StockItemID] [int] NOT NULL,
	[StockItemName] [nvarchar](100) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[SupplierID] [int] NOT NULL,
	[ColorID] [int] NULL,
	[UnitPackageID] [int] NOT NULL,
	[OuterPackageID] [int] NOT NULL,
	[Brand] [nvarchar](50) COLLATE Latin1_General_100_CI_AS NULL,
	[Size] [nvarchar](20) COLLATE Latin1_General_100_CI_AS NULL,
	[LeadTimeDays] [int] NOT NULL,
	[QuantityPerOuter] [int] NOT NULL,
	[IsChillerStock] [bit] NOT NULL,
	[Barcode] [nvarchar](50) COLLATE Latin1_General_100_CI_AS NULL,
	[TaxRate] [decimal](18, 3) NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
	[RecommendedRetailPrice] [decimal](18, 2) NULL,
	[TypicalWeightPerUnit] [decimal](18, 3) NOT NULL,
	[LastEditedBy] [int] NOT NULL
)
 WITH (
 LOCATION='wwiazure.dbo.ModernStockItems',
 DATA_SOURCE=AzureSQLDatabase
)
GO

-- Step 6: Create local statistics on columns you will use for filters
CREATE STATISTICS ModernStockItemsStats ON azuresqldb.ModernStockItems ([StockItemID]) WITH FULLSCAN
GO

-- Step 7: Just try to scan the remote table
SELECT * FROM azuresqldb.ModernStockItems
GO

-- Step 8: Try to find just a specific StockItemID
SELECT * FROM azuresqldb.ModernStockItems WHERE StockItemID = 100000
GO

-- Step 9: Use a UNION to find all stockitems for a specific supplier both locally and in the Azure table
SELECT msi.StockItemName, msi.Brand, c.ColorName
FROM azuresqldb.ModernStockItems msi
JOIN [Purchasing].[Suppliers] s
ON msi.SupplierID = s.SupplierID
and s.SupplierName = 'Graphic Design Institute'
JOIN [Warehouse].[Colors] c
ON msi.ColorID = c.ColorID
UNION
SELECT si.StockItemName, si.Brand, c.ColorName
FROM [Warehouse].[StockItems] si
JOIN [Purchasing].[Suppliers] s
ON si.SupplierID = s.SupplierID
and s.SupplierName = 'Graphic Design Institute'
JOIN [Warehouse].[Colors] c
ON si.ColorID = c.ColorID
GO