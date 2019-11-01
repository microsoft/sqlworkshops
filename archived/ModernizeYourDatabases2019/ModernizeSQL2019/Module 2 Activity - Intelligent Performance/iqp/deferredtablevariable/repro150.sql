USE master
GO
ALTER DATABASE wideworldimporters SET compatibility_level = 150
go
USE WideWorldImporters
go
EXEC defercompile
go