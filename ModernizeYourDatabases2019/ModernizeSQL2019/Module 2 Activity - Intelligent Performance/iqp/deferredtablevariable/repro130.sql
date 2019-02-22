USE master
GO
ALTER DATABASE wideworldimporters SET compatibility_level = 130
go
USE WideWorldImporters
go
EXEC defercompile
go