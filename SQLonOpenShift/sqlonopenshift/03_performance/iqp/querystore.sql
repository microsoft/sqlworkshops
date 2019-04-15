USE WideWorldImporters
GO
SELECT qsp.query_id, qsp.plan_id, compatibility_level, 
AVG(qsrs.avg_duration)/1000 as avg_duration_ms, 
AVG(qsrs.avg_logical_io_reads) as avg_logical_io,
CAST (qsp.query_plan as XML)
FROM sys.query_store_plan qsp
INNER JOIN sys.query_store_runtime_stats qsrs
ON qsp.plan_id = qsrs.plan_id
INNER JOIN sys.query_store_runtime_stats_interval qsrsi
ON qsrs.runtime_stats_interval_id = qsrsi.runtime_stats_interval_id
AND qsrsi.start_time between DATEADD(HOUR, -1, GETDATE()) and GETDATE()
GROUP BY qsp.query_id, qsp.plan_id, qsrs.avg_duration, qsp.compatibility_level, qsp.query_plan
ORDER BY qsp.query_id, qsrs.avg_duration DESC
GO