use tempdb
go
select object_name(object_id), * from sys.dm_db_xtp_object_stats
go