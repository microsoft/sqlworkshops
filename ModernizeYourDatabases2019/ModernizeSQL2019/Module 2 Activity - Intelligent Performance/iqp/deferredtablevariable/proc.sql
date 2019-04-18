USE WideWorldImporters
GO
CREATE or ALTER PROCEDURE defercompile
AS
BEGIN
-- Declare the table variable
DECLARE @ilines TABLE
(	[InvoiceLineID] [int] NOT NULL primary key,
	[InvoiceID] [int] NOT NULL,
	[StockItemID] [int] NOT NULL,
	[Description] [nvarchar](100) NOT NULL,
	[PackageTypeID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[TaxRate] [decimal](18, 3) NOT NULL,
	[TaxAmount] [decimal](18, 2) NOT NULL,
	[LineProfit] [decimal](18, 2) NOT NULL,
	[ExtendedPrice] [decimal](18, 2) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[LastEditedWhen] [datetime2](7) NOT NULL
)

-- Insert all the rows from InvoiceLines into the table variable
INSERT INTO @ilines SELECT * FROM Sales.InvoiceLines

-- Find my total profile by customer
SELECT i.CustomerID, SUM(il.LineProfit)
FROM Sales.Invoices i
INNER JOIN @ilines il
ON i.InvoiceID = il.InvoiceID
GROUP By i.CustomerID

END
GO