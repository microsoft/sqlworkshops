USE WideWorldImporters
GO
SELECT qsp.query_id, qsp.plan_id, qsp.compatibility_level, AVG(qsrs.avg_duration)/1000 as avg_duration_ms, AVG(qsrs.avg_logical_io_reads) as avg_logical_io,CAST (qsp.query_plan as XML),qsqt.query_sql_text
FROM sys.query_store_plan qsp
INNER JOIN sys.query_store_runtime_stats qsrs
ON qsp.plan_id = qsrs.plan_id
INNER JOIN sys.query_store_runtime_stats_interval qsrsi
ON qsrs.runtime_stats_interval_id = qsrsi.runtime_stats_interval_id
AND qsrsi.start_time between DATEADD(HOUR, -1, GETDATE()) and GETDATE()
INNER JOIN sys.query_store_query qsq
ON qsp.query_id = qsq. query_id
INNER JOIN sys.query_store_query_text qsqt
ON qsq.query_text_id = qsqt.query_text_id
AND query_sql_text LIKE '%Invoices%'
GROUP BY qsp.query_id, qsp.plan_id, qsrs.avg_duration, qsp.compatibility_level, qsp.query_plan, query_sql_text, qsrs.last_execution_time
ORDER BY qsrs.last_execution_time DESC, query_id DESC, qsp.plan_id DESC
GO