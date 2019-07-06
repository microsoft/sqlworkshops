-- Database created in Azure is called wwiazure
-- This is not managed instance so you can't execute a USE database
-- Create a new database called wwiazure (server tier doesn't matter for this demo)
--
-- This table is supposed to mimic the [Warehouse].[StockItems] table in the WWI database
-- in SQL Server. I need to use Latin1_General_100_CI_AS collation for the columns because that
-- is how WWI was created so if I want to UNION data together with WWI I must use that collation
DROP TABLE IF EXISTS [ModernStockItems]
GO
CREATE TABLE [ModernStockItems](
	[StockItemID] [int] NOT NULL,
	[StockItemName] [nvarchar](100) COLLATE Latin1_General_100_CI_AS NOT NULL,
	[SupplierID] [int] NOT NULL,
	[ColorID] [int] NULL,
	[UnitPackageID] [int] NOT NULL,
	[OuterPackageID] [int] NOT NULL,
	[Brand] [nvarchar](50) COLLATE Latin1_General_100_CI_AS NULL,
	[Size] [nvarchar](20) COLLATE Latin1_General_100_CI_AS NULL,
	[LeadTimeDays] [int] NOT NULL,
	[QuantityPerOuter] [int] NOT NULL,
	[IsChillerStock] [bit] NOT NULL,
	[Barcode] [nvarchar](50) COLLATE Latin1_General_100_CI_AS NULL,
	[TaxRate] [decimal](18, 3) NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
	[RecommendedRetailPrice] [decimal](18, 2) NULL,
	[TypicalWeightPerUnit] [decimal](18, 3) NOT NULL,
	--[MarketingComments] [nvarchar](max) NULL, -- Not allowed for an external table
	--[InternalComments] [nvarchar](max) NULL, -- Not allowed for an external table
	--[Photo] [varbinary](max) NULL, -- Not allowed for an external table
	--[CustomFields] [nvarchar](max) NULL, -- Not allowed for an external table
	--[Tags]  AS (json_query([CustomFields],N'$.Tags')), -- Not allowed for an external table
	--[SearchDetails]  AS (concat([StockItemName],N' ',[MarketingComments])), -- Not allowed for an external table
	[LastEditedBy] [int] NOT NULL,
CONSTRAINT [PK_Warehouse_StockItems] PRIMARY KEY CLUSTERED 
(
	[StockItemID] ASC
)
)
GO
-- Now insert some data. We don't coordinate with unique keys in WWI on SQL Server
-- so pick numbers way larger than exist in the current StockItems in WWI which is only 227
INSERT INTO ModernStockItems VALUES
(100000,
'Dallas Cowboys Jersey',
5,
4, -- Blue
4, -- Box
4, -- Bob
'Under Armour',
'L',
30,
1,
0,
'123456789',
2.0,
50,
75,
2.0,
1
)
GO
