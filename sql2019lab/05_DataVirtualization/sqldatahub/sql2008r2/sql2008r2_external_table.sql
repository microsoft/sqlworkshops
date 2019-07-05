USE [WideWorldImporters]
GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'S0me!nfo'
GO
/*  specify credentials to external data source
*  IDENTITY: user name for external source.  
*  SECRET: password for external source.
*/
DROP DATABASE SCOPED CREDENTIAL SqlServerCredentials
GO
CREATE DATABASE SCOPED CREDENTIAL SqlServerCredentials   
WITH IDENTITY = 'sqluser', Secret = '$cprsqlserver2019'
GO
/*  LOCATION: Location string should be of format '<vendor>://<server>[:<port>]'.
*  PUSHDOWN: specify whether computation should be pushed down to the source. ON by default.
*  CREDENTIAL: the database scoped credential, created above.
*/  
DROP EXTERNAL DATA SOURCE SQLServerInstance
GO
CREATE EXTERNAL DATA SOURCE SQLServerInstance
WITH ( 
LOCATION = 'sqlserver://bwsql2008r2',
PUSHDOWN = ON,
CREDENTIAL = SQLServerCredentials,
CONNECTION_OPTIONS = 'UseDefaultEncryptionOptions=false' -- This is a workaround for a bug in SQL 2019 CTP 2.3 under investigation.
)
GO
DROP SCHEMA sqlserver
go
CREATE SCHEMA sqlserver
GO
/*  LOCATION: sql server table/view in 'database_name.schema_name.object_name' format
*  DATA_SOURCE: the external data source, created above.
*/
DROP EXTERNAL TABLE sqlserver.suppliers
GO
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
CREATE STATISTICS SupplierNameStatistics ON sqlserver.suppliers ([SupplierName]) WITH FULLSCAN
GO
-- Scan the table to make sure it works
--
SELECT * FROM sqlserver.suppliers
GO

-- Find a specific supplier
--
SELECT * FROM sqlserver.suppliers where SupplierName = 'Brooks Brothers'
GO
--
-- Find all former clothing suppliers and their city
SELECT s.SupplierName, s.SupplierReference, c.cityname
FROM sqlserver.suppliers s
JOIN [Purchasing].[SupplierCategories] sc
on s.SupplierCategoryID = sc.SupplierCategoryID
and sc.SupplierCategoryName = 'Clothing Supplier'
JOIN [Application].[Cities] c
ON s.DeliveryCityID = c.CityID
GO