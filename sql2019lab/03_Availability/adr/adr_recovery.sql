-- Step 1: Setup the database
USE master
GO
DROP DATABASE IF EXISTS gocowboys
GO
CREATE DATABASE gocowboys
ON PRIMARY
(NAME = N'gocowboys_primary', FILENAME = 'c:\data\gocowboys.mdf', SIZE = 10Gb , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB)
LOG ON 
(NAME = N'gocowboys_Log', FILENAME = 'c:\data\gocowboys_log.ldf', SIZE = 30Gb , MAXSIZE = UNLIMITED , FILEGROWTH = 65536KB)
GO
ALTER DATABASE gocowboys SET RECOVERY SIMPLE
GO

-- Step 2: Create the table
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
WHILE (@x < 1000000)
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

-- Step 3: Delete all the rows in a transaction
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

-- Step 4: Checkpoint the database and kill the server
-- Run the following commands in another session. Then restart SQL Server and examine the ERRORLOG
-- USE gocowboys
-- GO
-- CHECKPOINT
-- GO
-- SHUTDOWN WITH NOWAIT
-- GO

-- Step 5: Create the table again for a second test
USE master
GO
ALTER DATABASE gocowboys SET ACCELERATED_DATABASE_RECOVERY = ON
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
WHILE (@x < 1000000)
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

-- Step 6: Delete all the rows again in a transaction
-- Try to delete a bunch of rows
USE gocowboys
GO
BEGIN TRAN
DELETE from howboutthemcowboys
GO

-- Step 7: Checkpoint the database and kill the server
-- Run the following commands in another session. Then restart SQL Server and examine the ERRORLOG
-- USE gocowboys
-- GO
-- CHECKPOINT
-- GO
-- SHUTDOWN WITH NOWAIT
-- GO
