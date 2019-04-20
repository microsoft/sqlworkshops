-- List out the nodes in the scale out group
--
SELECT * FROM sys.dm_exec_compute_nodes
GO
-- Get more details about the status of the nodes
--
SELECT * FROM sys.dm_exec_compute_node_status
GO
-- List out detailed errors from the nodes
--
SELECT * FROM sys.dm_exec_compute_node_errors
GO