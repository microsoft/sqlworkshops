SELECT * FROM sys.dm_exec_compute_nodes
GO

SELECT * FROM sys.dm_exec_compute_node_status
GO

-- Run this query and use the Actual Execution Plan option
-- Examine the properties of the Remote Query operator
USE WideWorldImporters
GO
SELECT * FROM azuresqldb.ModernStockItems WHERE StockItemID = 100000
GO

-- Find out queries against external tables
-- Find the execution_id for this query
-- SELECT * FROM azuresqldb.ModernStockItems WHERE StockItemID = 100000  
SELECT er.execution_id, t.*, er.*
FROM sys.dm_exec_distributed_requests er
CROSS APPLY sys.dm_exec_sql_text(er.sql_handle) AS t
ORDER BY end_time DESC
go

-- Find your execution_id and use this for the next query
-- Sub in your execution_id from the previous step
-- Look at the command for operation_type = StreamingReturnOperation
--
SELECT execution_id, step_index, operation_type, distribution_type, location_type, status, total_elapsed_time, command
FROM sys.dm_exec_distributed_request_steps
WHERE execution_id = 'QID545'
GO

-- Get more details from the compute nodes
-- Note the source_info for type = EXTERNAL_READER and DIRECT_READER
SELECT * 
FROM sys.dm_exec_dms_workers 
WHERE execution_id = 'QID545'
ORDER BY step_index, dms_step_index, distribution_id
go

-- Look more at external operations
--
SELECT * 
FROM sys.dm_exec_external_work
WHERE execution_id = 'QID545'
GO
