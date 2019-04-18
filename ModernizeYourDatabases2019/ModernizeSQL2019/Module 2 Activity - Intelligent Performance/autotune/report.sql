use WideWorldImporters
go
declare @packagetypeid int = 7;
exec dbo.report @packagetypeid
go