# Automatic Tuning with SQL Server

This is a repro package to demonstrate the Automatic Tuning (Auto Plan Correction) in SQL Server 2017. This feature is using telemtry from the Query Store feature we launched with Azure SQL Database and SQL Server 2016 to provide built-in intelligence.

## Requirements

This repro assumes the following:

- SQL Server 2017 installed (pick at minimum Database Engine) on Windows. This feature requires Developer or Enterprise Edition.
- You have installed SQL Server Management Studio or SQL Operations Studio (https://docs.microsoft.com/en-us/sql/sql-operations-studio/download)
- You have downloaded the RML Utilities from https://www.microsoft.com/en-us/download/details.aspx?id=4511.
- These demos use a named instance called SQL2017. You will need to edit the .cmd scripts which connect to SQL Server to change to a default instance or whatever named instance you have installed.

- Install ostress from the package RML_Setup_AMD64.msi. Add C:\Program Files\Microsoft Corporation\RMLUtils to your path.

- Restore the WideWorldImporters database backup to your SQL Server 2017 instance. The WideWorldImporters-Full.bak is provided along with a **restorewwi.sql** script to restore the database. This script assumes the backup is in the C:\sql_sample_databases directory and that all database files will be placed in c:\temp. Change the location for the backup and your files as needed.

## Demo Steps

1. Run **repro_setup.cmd** to customize the WideWorldImporters database for the demo. You will only need to run this one time after restoring the backup.

2. Setup Performance Monitor on Windows to track SQL Statistics/Batch Requests/sec

3. Run **initalize.cmd**to setup the repro for default of recommendations. If you restart the demo from the beginning, you can run this again to "reset" the demo.

4. Run **report.cmd** to start the workload. This will pop-up a command window running the workload. Note the chart showing Batch Requests/Sec as your workload throughput

5. Run **regression.cmd** (you may need to run this a few times for timing reasons). Notice the drop in batch requests/sec which shows a performance regression in your workload.

6. Load **recommendations.sql** into SQL Server Management Studio or SQL Operations Studio and review the results. Notice the time difference under the reason column and value of state_transition_reason which should be AutomaticTuningOptionNotEnabled. This means we found a regression but are recommending it only, not automatically fixing it. The script column shows a query that could be used to fix the problem.

7. Stop the **report.cmd** workload by pressing <Ctrl>+<C> in the command window and pressing 'y' to stop. This should close that command window.

8. Now let's see what happens with automatic plan correction. Run **auto_tune.cmd**which sets automatic plan correct ON for WideWorldImporters

9. Repeat steps 4-7 as above. In Performance Monitor you will see the batch requests/sec dip but within a second go right back up. This is because SQL Server detected the regression and automatically reverted to "last known good" or the last known good query plan as found in the Query Store. Note in the output of recommendations.sql the state_transition_reason now says LastGoodPlanForced.