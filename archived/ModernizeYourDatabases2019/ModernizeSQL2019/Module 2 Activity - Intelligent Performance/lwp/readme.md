# SQL Server Demo Lightweight Query Profiling

This is a demo to show the feature of Lightweight Query Profiling which is on by default in SQL Server 2019

## Requirements

- Install SQL Server 2019 CTP 2.0 or higher
- Restore the WideWorldImporters backup from https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Full.bak
- Install SQL Server Management Studio 18.0 or higher

## Demo Steps

1. Open up SSMS and Activity Monitor
2. Run the script **mysmartquery.cmd**
3. Choose the process for this query in Activity Monitor in the Process section and right-click. Choose Show Live Execution Plan
4. You should see a live view of the plan in execution at the operator level. Note the query has a syntax bug which causes the crazy behavior.
5. Load **dm_exec_query_profiles.sql** and fill in the correct session_id. Note you can see the same info through a DMV.