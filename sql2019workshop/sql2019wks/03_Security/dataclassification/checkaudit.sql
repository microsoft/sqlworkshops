-- Check the audit
-- The audit may now show up EXACTLY right after the query but within a few seconds.
-- Note: Remember for Linux installations, the default path is /var/opt/mssql/data
SELECT event_time, session_id, server_principal_name,
database_name, object_name, 
cast(data_sensitivity_information as XML) as data_sensitivity_information, 
client_ip, application_name
FROM sys.fn_get_audit_file ('C:\program files\microsoft sql server\mssql15.mssqlserver\mssql\data\*.sqlaudit',default,default)
GO
