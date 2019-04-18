-- Let's cause rollback with server startup
-- First CHECKPOINT the database
USE gocowboys
GO
CHECKPOINT
GO

USE master
GO
-- SHUTDOWN WITH NO WAIT
SHUTDOWN WITH NOWAIT
GO
