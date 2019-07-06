-- Step 1: Scan the table and see if the sensitivity columns were audited
USE WideWorldImporters
GO
SELECT * FROM [Application].[People]
GO

-- Step 2: Check the audit
-- The audit may now show up EXACTLY right after the query but within a few seconds.
SELECT event_time, session_id, server_principal_name,
database_name, object_name, 
cast(data_sensitivity_information as XML) as data_sensitivity_information, 
client_ip, application_name
FROM sys.fn_get_audit_file ('C:\program files\microsoft sql server\mssql15.mssqlserver\mssql\data\*.sqlaudit',default,default)
GO

-- Step 3: What if I access just one of the columns directly?
SELECT FullName FROM [Application].[People]
GO

-- Step 4: Check the audit
-- The audit may now show up EXACTLY right after the query but within a few seconds.
SELECT event_time, session_id, server_principal_name,
database_name, object_name, 
cast(data_sensitivity_information as XML) as data_sensitivity_information, 
client_ip, application_name
FROM sys.fn_get_audit_file ('C:\program files\microsoft sql server\mssql15.mssqlserver\mssql\data\*.sqlaudit',default,default)
GO

-- Step 5: What if I reference a classified column in the WHERE clause only?
SELECT PreferredName FROM [Application].[People]
WHERE EmailAddress LIKE '%microsoft%'
GO
-- Step 6: Check the audit
-- The audit may now show up EXACTLY right after the query but within a few seconds.
SELECT event_time, session_id, server_principal_name,
database_name, object_name, 
cast(data_sensitivity_information as XML) as data_sensitivity_information, 
client_ip, application_name
FROM sys.fn_get_audit_file ('C:\program files\microsoft sql server\mssql15.mssqlserver\mssql\data\*.sqlaudit',default,default)
GO