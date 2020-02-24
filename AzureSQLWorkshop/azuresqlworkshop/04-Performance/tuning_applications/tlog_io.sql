SELECT io_stall_write_ms/num_of_writes as avg_tlog_io_write_ms, * 
FROM sys.dm_io_virtual_file_stats
(db_id('Adventureworks<ID>'), 2);
GO