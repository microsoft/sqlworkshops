# SQL Server demo for Intelligent Query Processing - Deferred Table Variable Compilation

## Requirements

You must first install the following for this demo

- SQL Server 2019 CTP 2.0 or greater on Windows Server. While you can run the basics of this demo on SQL Server on Linux, the full affect to the demo requires Windows Performance Monitor so I recommend you use SQL Server on Windows Server.
- SQL Server client tools (e.g. sqlcmd)
- SQL Server Management Studio 18.0 (SSMS) installed
- RML Utilities installed (ostress) from https://www.microsoft.com/en-us/download/details.aspx?id=4511
- A copy of the WideWorldImporters backup from https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Full.bak

## Demo Steps 

1. Restore the WWI backup. Use the **restorewwi.sql** as a template.

2. Run **setup_repro.cmd** to install new stored procedure in WideWorldImporters

3. Examine the details of the new procedure from **proc.sql**

4. Run **repro_130.cmd** and observe the total duration time. It should take around 30+ secs

5. Run **repro_150.cm**d and observe the total duration. This is the exact same workload as step 4 except with database compatibility level 150. This sould take around 10secs.

6. Using SSMS, observe the performance of this query and differences in plan and average execution time using Query Store Reports, Top Resource Queries.

7. Optionally use query_plan_diff.sql to observe the differences in Query Store. You need to substitute the proper query_id from the report in SSMS.