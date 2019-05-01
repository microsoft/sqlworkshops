/* 
Note: To be run in conjunction with SQL server 2019 big data clusters course only.

Show Instance Version */
SELECT @@VERSION; 
GO

/* General Configuration */
USE master;  
GO  
EXEC sp_configure;
GO

/* Databases on this Instance */
SELECT db.name AS 'Database Name'
, Physical_Name AS 'Location on Disk'
, Cast(Cast(Round(cast(mf.size as decimal) * 8.0/1024000.0,2) as decimal(18,2)) as nvarchar) 'Size (GB)'
FROM sys.master_files mf
INNER JOIN 
    sys.databases db ON db.database_id = mf.database_id
WHERE mf.type_desc = 'ROWS';
GO

SELECT * from sys.master_files
