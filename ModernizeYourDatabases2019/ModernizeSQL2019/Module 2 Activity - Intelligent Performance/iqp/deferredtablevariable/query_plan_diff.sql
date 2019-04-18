USE WideWorldImporters
GO
SELECT qsp.plan_id, qsp.compatibility_level, 
avg(qsrs.avg_duration)/1000 as avg_duration_ms, avg(qsrs.avg_logical_io_reads) as avg_logical_io
FROM sys.query_store_plan qsp
INNER JOIN sys.query_store_runtime_stats qsrs
ON qsp.plan_id = qsrs.plan_id
AND qsp.query_id = 41998 -- Put in your query_id here
GROUP BY qsp.plan_id, qsp.compatibility_level
GO

