use WideWorldImporters
go
select * from Sales.InvoiceLines
go

alter database wideworldimporters set compatibility_level = 150

alter database wideworldimporters set compatibility_level = 130

create or alter proc defercompile
as
begin
declare @ilines table
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

insert into @ilines select * from sales.InvoiceLines

select i.CustomerID, sum(il.LineProfit)
from Sales.Invoices i
inner join @ilines il
on i.InvoiceID = il.InvoiceID
group by i.CustomerID

end
go

exec defercompile
