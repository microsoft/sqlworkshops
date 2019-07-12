-- Step 1: Change WideWorldImporters to dbcompat = 150
-- TODO: Remove this when bug in SSMS fixed
ALTER DATABASE WideWorldImporters SET COMPATIBILITY_LEVEL = 150
GO

-- Step 2: In case you have run these demos before drop existing classifications
USE WideWorldImporters
GO
IF EXISTS (SELECT * FROM sys.sensitivity_classifications sc WHERE object_id('[Application].[PaymentMethods]') = sc.major_id)
	DROP SENSITIVITY CLASSIFICATION FROM [Application].[PaymentMethods].[PaymentMethodName]
GO
IF EXISTS (SELECT * FROM sys.sensitivity_classifications sc WHERE object_id('[Application].[People]') = sc.major_id)
	DROP SENSITIVITY CLASSIFICATION FROM [Application].[People].[FullName]
	DROP SENSITIVITY CLASSIFICATION FROM [Application].[People].[EmailAddress]
GO
