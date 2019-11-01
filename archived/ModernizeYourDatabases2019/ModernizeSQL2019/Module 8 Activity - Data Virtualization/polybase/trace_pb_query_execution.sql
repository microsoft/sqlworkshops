-- Find out queries against external tables
--
SELECT er.execution_id, t.*, er.*
FROM sys.dm_exec_distributed_requests er
CROSS APPLY sys.dm_exec_sql_text(er.sql_handle) AS t
ORDER BY end_time DESC
go

-- Find your execution_id and use this for the next query
--
SELECT execution_id, step_index, operation_type, distribution_type, location_type, status, total_elapsed_time, command
FROM sys.dm_exec_distributed_request_steps
WHERE execution_id = 'QID1285'
GO

-- Get more details on each step
--
SELECT execution_id, compute_node_id, spid, step_index, distribution_id, status, total_elapsed_time, row_count
FROM sys.dm_exec_distributed_sql_requests
WHERE execution_id = 'QID1285'
GO

-- Get more details from the compute nodes
--
SELECT * 
FROM sys.dm_exec_dms_workers 
WHERE execution_id = 'QID1285'
ORDER BY step_index, dms_step_index, distribution_id
go

-- Look more at external operations
--
SELECT * 
FROM sys.dm_exec_external_work
WHERE execution_id = 'QID1285'
GO

