--alter database wideworldimporters set compatibility_level = 150
--go
use wideworldimporters
go
select si.CustomerID, sil.LineProfit
from Sales.Invoices si
join Sales.InvoiceLines sil
on si.InvoiceID = si.InvoiceID
option (maxdop 1)
go