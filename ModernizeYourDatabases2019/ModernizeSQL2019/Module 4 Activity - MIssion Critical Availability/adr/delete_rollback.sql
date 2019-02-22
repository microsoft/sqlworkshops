-- Try to delete a bunch of rows
-- Should take about 30 secs
--
USE gocowboys
GO
BEGIN TRAN
DELETE from howboutthemcowboys
GO
-- Try to roll it back and measure the time
ROLLBACK TRAN
GO

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
-- Try to roll it back and measure the time
-- 0 secs!
ROLLBACK TRAN
GO

-- Clear ADR
--
USE master
GO
ALTER DATABASE gocowboys SET ACCELERATED_DATABASE_RECOVERY = OFF
GO