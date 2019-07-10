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

-- Remove the .audit files from default or your path
-- Remember for Linux installations, the default path is /var/opt/mssql/data.
-- del C:\program files\microsoft sql server\mssql15.mssqlserver\mssql\data\GDPR*.audit

ALTER DATABASE WideWorldImporters SET COMPATIBILITY_LEVEL = 130
GO

USE WideWorldImporters
GO
IF EXISTS (SELECT * FROM sys.sensitivity_classifications sc WHERE object_id('[Application].[PaymentMethods]') = sc.major_id)
	DROP SENSITIVITY CLASSIFICATION FROM [Application].[PaymentMethods].[PaymentMethodName]
GO
IF EXISTS (SELECT * FROM sys.sensitivity_classifications sc WHERE object_id('[Application].[People]') = sc.major_id)
	DROP SENSITIVITY CLASSIFICATION FROM [Application].[People].[FullName]
	DROP SENSITIVITY CLASSIFICATION FROM [Application].[People].[EmailAddress]
GO


