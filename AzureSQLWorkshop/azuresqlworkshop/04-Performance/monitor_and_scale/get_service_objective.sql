SELECT�database_name,slo_name,cpu_limit,max_db_memory, max_db_max_size_in_mb,�primary_max_log_rate,primary_group_max_io,�volume_local_iops,volume_pfs_iops
FROM�sys.dm_user_db_resource_governance;
GO
SELECT DATABASEPROPERTYEX('<database name>', 'ServiceObjective');
GO
