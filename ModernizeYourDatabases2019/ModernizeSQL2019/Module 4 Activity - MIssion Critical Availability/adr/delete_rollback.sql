-- Make sure ADR is OFF
--
USE master
GO
ALTER DATABASE gocowboys SET ACCELERATED_DATABASE_RECOVERY = OFF
GO
-- Try to delete a bunch of rows
-- Should take about 30 secs
--
USE gocowboys
GO
BEGIN TRAN
DELETE from howboutthemcowboys
GO

-- What is the log space usage
SELECT * FROM sys.dm_db_log_space_usage
go

-- Does checkpoint truncate the log?
-- 
CHECKPOINT
GO
SELECT * FROM sys.dm_db_log_space_usage
go

-- Try to roll it back and measure the time
ROLLBACK TRAN
GO

-- What is the log space usage
SELECT * FROM sys.dm_db_log_space_usage
go

-- Does checkpoint truncate the log?
-- 
CHECKPOINT
GO
SELECT * FROM sys.dm_db_log_space_usage
go

-- Now try it with ADR
--
USE master
GO
ALTER DATABASE gocowboys SET ACCELERATED_DATABASE_RECOVERY = ON
GO

-- Try to delete a bunch of rows and roll it back
--
USE gocowboys
GO
BEGIN TRAN
DELETE from howboutthemcowboys
GO

-- What is the log space usage
SELECT * FROM sys.dm_db_log_space_usage
go

-- Try to roll it back and measure the time
-- 0 secs!
ROLLBACK TRAN
GO

-- What is the log space usage
SELECT * FROM sys.dm_db_log_space_usage
go

-- Clear ADR
--
USE master
GO
ALTER DATABASE gocowboys SET ACCELERATED_DATABASE_RECOVERY = OFF
GO