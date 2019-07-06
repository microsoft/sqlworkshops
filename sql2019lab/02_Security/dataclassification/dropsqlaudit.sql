-- Step 1: Disable the audits and drop them
USE WideWorldImporters
GO
IF EXISTS (SELECT * FROM sys.database_audit_specifications WHERE name = 'People_Audit')
BEGIN
	ALTER DATABASE AUDIT SPECIFICATION People_Audit 
	WITH (STATE = OFF)
	DROP DATABASE AUDIT SPECIFICATION People_Audit
END
GO
USE master
GO
IF EXISTS (SELECT * FROM sys.server_audits WHERE name = 'GDPR_Audit')
BEGIN
	ALTER SERVER AUDIT GDPR_Audit
	WITH (STATE = OFF)
	DROP SERVER AUDIT GDPR_Audit
END
GO

-- Step 2: Remove the .audit files from default or your path
-- del C:\program files\microsoft sql server\mssql15.mssqlserver\mssql\data\GDPR*.audit