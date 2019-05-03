SELECT session_id, login_time, host_name, program_name, reads, writes, cpu_time
FROM sys.dm_exec_sessions WHERE is_user_process = 1
GO
SELECT dr.session_id, dr.start_time, dr.status, dr.command
FROM sys.dm_exec_requests dr
JOIN sys.dm_exec_sessions de
ON dr.session_id = de.session_id
AND de.is_user_process = 1
GO
SELECT cpu_count, committed_kb from sys.dm_os_sys_info
GO
