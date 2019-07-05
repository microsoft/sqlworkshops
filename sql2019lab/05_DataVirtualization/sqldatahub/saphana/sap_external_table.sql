USE [WideWorldImporters]
GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'S0me!nfo'
GO
/*  specify credentials to external data source
*  IDENTITY: user name for external source.  
*  SECRET: password for external source.
*/
-- Need to change this a different user than SYSTEM
DROP DATABASE SCOPED CREDENTIAL SAPHANACredentials
GO
CREATE DATABASE SCOPED CREDENTIAL SAPHANACredentials   
WITH IDENTITY = 'bwsaphana', Secret = 'Cprsql2019'
GO
/*  LOCATION: Location string should be of format '<vendor>://<server>[:<port>]'.
*  PUSHDOWN: specify whether computation should be pushed down to the source. ON by default.
*  CREDENTIAL: the database scoped credential, created above.
*/  
DROP EXTERNAL DATA SOURCE SAPHANAServer
GO
CREATE EXTERNAL DATA SOURCE SAPHANAServer
WITH ( 
LOCATION = 'odbc://bwsaphana',
CONNECTION_OPTIONS = 'Driver={HDBODBC};ServerNode=bwsaphana:39041',
PUSHDOWN = ON,
CREDENTIAL = SAPHANACredentials
)
GO
DROP SCHEMA saphana
go
CREATE SCHEMA saphana
GO
/*  LOCATION: oracle table/view in 'database_name.schema_name.object_name' format
*  DATA_SOURCE: the external data source, created above.
*/
DROP EXTERNAL TABLE saphana.customers
GO
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
CREATE STATISTICS customerstats ON saphana.customrs ([CustomerName]) WITH FULLSCAN
GO
-- Let's scan the table to make sure it works
SELECT * FROM saphana.customers
GO
-- Union with our current customers
--
SELECT CustomerID, CustomerName, AccountOpenedDate, CustomerWebSite
FROM saphana.customers
UNION
SELECT CustomerID, CustomerName, AccountOpenedDate, WebsiteURL
FROM Sales.Customers
GO