-- Step 1: In case you have run these demos before drop existing classifications
USE WideWorldImporters
GO
IF EXISTS (SELECT * FROM sys.sensitivity_classifications sc WHERE object_id('[Application].[PaymentMethods]') = sc.major_id)
BEGIN
	DROP SENSITIVITY CLASSIFICATION FROM [Application].[PaymentMethods].[PaymentMethodName]
END
GO
IF EXISTS (SELECT * FROM sys.sensitivity_classifications sc WHERE object_id('[Application].[People]') = sc.major_id)
BEGIN
	DROP SENSITIVITY CLASSIFICATION FROM [Application].[People].[FullName]
	DROP SENSITIVITY CLASSIFICATION FROM [Application].[People].[EmailAddress]
END
GO
