USE [WideWorldImporters]
GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'S0me!nfo'
GO
/*  specify credentials to external data source
*  IDENTITY: user name for external source.  
*  SECRET: password for external source.
*/
DROP DATABASE SCOPED CREDENTIAL OracleCredentials
GO
CREATE DATABASE SCOPED CREDENTIAL OracleCredentials   
WITH IDENTITY = 'gl', Secret = 'glpwd'
GO
/*  LOCATION: Location string should be of format '<vendor>://<server>[:<port>]'.
*  PUSHDOWN: specify whether computation should be pushed down to the source. ON by default.
*  CREDENTIAL: the database scoped credential, created above.
*/  
DROP EXTERNAL DATA SOURCE OracleServer
GO
CREATE EXTERNAL DATA SOURCE OracleServer
WITH ( 
LOCATION = 'oracle://bworacle:49161',
PUSHDOWN = ON,
CREDENTIAL = OracleCredentials
)
GO
DROP SCHEMA oracle
go
CREATE SCHEMA oracle
GO
/*  LOCATION: oracle table/view in 'database_name.schema_name.object_name' format
*  DATA_SOURCE: the external data source, created above.
*/
DROP EXTERNAL TABLE oracle.accountsreceivable
GO
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
CREATE STATISTICS arrefstats ON oracle.accountsreceivable ([arref]) WITH FULLSCAN
GO
-- Let's scan the table to make sure it works
SELECT * FROM oracle.accountsreceivable
GO

-- Try a simple filter
SELECT * FROM oracle.accountsreceivable
WHERE arref = 336252
GO

-- Join with a local table
--
SELECT ct.*, oa.arid, oa.ardesc
FROM oracle.accountsreceivable oa
JOIN [Sales].[CustomerTransactions] ct
ON oa.arref = ct.CustomerTransactionID
GO