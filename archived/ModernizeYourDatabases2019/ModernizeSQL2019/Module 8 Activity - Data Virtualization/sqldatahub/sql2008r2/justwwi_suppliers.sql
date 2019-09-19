USE [JustWorldImporters]
GO
-- Create a partition function
--
CREATE PARTITION FUNCTION [PF_Supplier_Names](nvarchar(100))
AS RANGE RIGHT FOR VALUES (N'Brooks Brothers', N'Old Suppliers -1', N'Old Suppliers -250000', 
N'Old Suppliers -500000', N'Old Suppliers -750000')
GO
-- Create the partition scheme
--
CREATE PARTITION SCHEME [PS_Supplier_Names] 
AS PARTITION [PF_Supplier_Names] 
TO ([PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY])
GO
-- Create the table
--
DROP TABLE [Suppliers]
GO
CREATE TABLE [Suppliers](
	[SupplierID] [int] NOT NULL,
	[SupplierName] [nvarchar](100) NOT NULL,
	[SupplierCategoryID] [int] NOT NULL,
	[PrimaryContactPersonID] [int] NOT NULL,
	[AlternateContactPersonID] [int] NOT NULL,
	[DeliveryMethodID] [int] NULL,
	[DeliveryCityID] [int] NOT NULL,
	[PostalCityID] [int] NOT NULL,
	[SupplierReference] [nvarchar](20) NULL,
	[BankAccountName] [nvarchar](50) NULL,
	[BankAccountBranch] [nvarchar](50) NULL,
	[BankAccountCode] [nvarchar](20) NULL,
	[BankAccountNumber] [nvarchar](20) NULL,
	[BankInternationalCode] [nvarchar](20) NULL,
	[PaymentDays] [int] NOT NULL,
--	[InternalComments] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](20) NOT NULL,
	[FaxNumber] [nvarchar](20) NOT NULL,
	[WebsiteURL] [nvarchar](256) NOT NULL,
	[DeliveryAddressLine1] [nvarchar](60) NOT NULL,
	[DeliveryAddressLine2] [nvarchar](60) NULL,
	[DeliveryPostalCode] [nvarchar](10) NOT NULL,
--  [DeliveryLocation] [geography] NULL,
	[PostalAddressLine1] [nvarchar](60) NOT NULL,
	[PostalAddressLine2] [nvarchar](60) NULL,
	[PostalPostalCode] [nvarchar](10) NOT NULL,
	[LastEditedBy] [int] NOT NULL
 CONSTRAINT [PK_Purchasing_Suppliers] PRIMARY KEY CLUSTERED 
(
	[SupplierName] ASC
) ON [PS_Supplier_names]([SupplierName]),
-- CONSTRAINT [UQ_Purchasing_Suppliers_ID] UNIQUE NONCLUSTERED 
--(
--	[SupplierID] ASC
--)
)
-- Insert some data
--
TRUNCATE TABLE [Suppliers]
GO
INSERT INTO [Suppliers]
VALUES (-1, 'Brooks Brothers', 4, -1, -2, 1, 24161, 24161, 'First US Clothing', 'Bank of New York Mellon', 'New York', NULL, '123456789', NULL, 30, '2121111111', '2121112222', 'brooksbrothers.com', '1 Broadway', NULL, '10004', '1 Broadway', NULL, '10004', 1)
GO

-- Let's go insert 1M fake suppliers
--
SET NOCOUNT ON
GO
BEGIN TRAN
GO
DECLARE @x int
DECLARE @y nvarchar(100)
SET @x = -2
WHILE @x > -1000001
BEGIN
	SET @y = 'Old Supplier'+CAST(@X as nvarchar(10))
	INSERT INTO Suppliers VALUES (@x, @Y, 4, -1, -2, 1, 24161, 24161, 'Unknown', 'Unknown', 'Unknown', NULL, '123456789', NULL, 0, '2121111111', '2121112222', 'Unknown', 'Unknown', NULL, '00000', 'Unknown', NULL, '00000', 1)
	SET @x = @x - 1
END
GO
COMMIT TRAN
GO
SET NOCOUNT OFF
GO