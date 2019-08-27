-- Step 1: Setup the database
-- Depending on the speed of your server, creating the database and data could take several minutes.
-- Note: *For Linux installations the default path to use is /var/opt/mssql
USE master
GO
DROP DATABASE IF EXISTS gocowboys
GO
CREATE DATABASE gocowboys
ON PRIMARY
(NAME = N'gocowboys_primary', FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\gocowboys.mdf', SIZE = 10Gb , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB)
LOG ON 
(NAME = N'gocowboys_Log', FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\gocowboys_log.ldf', SIZE = 10Gb , MAXSIZE = UNLIMITED , FILEGROWTH = 65536KB)
GO
ALTER DATABASE gocowboys SET RECOVERY SIMPLE
GO
USE gocowboys
GO
DROP TABLE IF EXISTS howboutthemcowboys
GO
CREATE TABLE howboutthemcowboys (playerid int primary key clustered, playername char(7000) not null)
GO
SET NOCOUNT ON
GO
BEGIN TRAN
DECLARE @x int
SET @x = 0
WHILE (@x < 100000)
BEGIN
	INSERT INTO howboutthemcowboys VALUES (@x, 'Jason Whitten returns in 2019')
	SET @x = @x + 1
END
COMMIT TRAN
GO
SET NOCOUNT OFF
GO
USE master
GO

-- Step 2: Delete all the rows in the table
-- Make sure ADR is OFF
USE master
GO
ALTER DATABASE gocowboys SET ACCELERATED_DATABASE_RECOVERY = OFF
GO
-- Try to delete a bunch of rows
USE gocowboys
GO
BEGIN TRAN
DELETE from howboutthemcowboys
GO

-- Step 3: Check how much transaction log is used
SELECT * FROM sys.dm_db_log_space_usage
GO

-- Step 4: Does a CHECKPOINT truncate the log?
CHECKPOINT
GO
SELECT * FROM sys.dm_db_log_space_usage
GO

-- Step 5: How long does it take to rollback the DELETEs
ROLLBACK TRAN
GO

-- Step 6: What is log space usage after the CHECKPOINT
CHECKPOINT
GO
SELECT * FROM sys.dm_db_log_space_usage
GO

-- Step 7: Turn on Accelerated Database Recovery
USE master
GO
ALTER DATABASE gocowboys SET ACCELERATED_DATABASE_RECOVERY = ON
GO

-- Step 8: Delete all the rows again in a transaction
USE gocowboys
GO
BEGIN TRAN
DELETE from howboutthemcowboys
GO

-- Step 9: Check log space usage before and after a CHECKPOINT
SELECT * FROM sys.dm_db_log_space_usage
GO
CHECKPOINT
GO
SELECT * FROM sys.dm_db_log_space_usage
GO

-- Step 10: How fast is a rollback?
ROLLBACK TRAN
GO