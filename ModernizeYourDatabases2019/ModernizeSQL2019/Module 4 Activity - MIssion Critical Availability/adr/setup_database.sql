USE master
GO
DROP DATABASE IF EXISTS gocowboys
GO
CREATE DATABASE gocowboys
ON PRIMARY
(NAME = N'gocowboys_primary', FILENAME = 'c:\data\gocowboys.mdf', SIZE = 10Gb , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB)
LOG ON 
(NAME = N'gocowboys_Log', FILENAME = 'c:\data\gocowboys_log.ldf', SIZE = 10Gb , MAXSIZE = UNLIMITED , FILEGROWTH = 65536KB)
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
	INSERT INTO howboutthemcowboys VALUES (@x, 'All players are great')
	SET @x = @x + 1
END
COMMIT TRAN
GO
SET NOCOUNT OFF
GO
USE master
GO