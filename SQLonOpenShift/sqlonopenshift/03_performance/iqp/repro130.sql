USE master
GO
ALTER DATABASE wideworldimporters SET compatibility_level = 130
GO
USE WideWorldImporters
GO
SET NOCOUNT ON
GO
EXEC [Sales].[CustomerProfits]
GO 25
SET NOCOUNT OFF
GO