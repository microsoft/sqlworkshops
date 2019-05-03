USE master
GO
CREATE DATABASE testag
GO
USE MASTER
GO
BACKUP DATABASE [testag] 
TO DISK = N'/var/opt/mssql/data/testag.bak'
GO
ALTER AVAILABILITY GROUP [ag1] ADD DATABASE [testag]
GO
