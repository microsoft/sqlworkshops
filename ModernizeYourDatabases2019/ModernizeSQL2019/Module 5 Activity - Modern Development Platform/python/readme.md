# SQL Server demo using Python and Native Scoring

This demo shows the capability of running Python code in SQL Server 2017 and later and the Native scoring feature.

This demo pulls SQL commands from the main site for a rental prediction tutorial using Python which you can find at https://microsoft.github.io/sql-ml-tutorials/python/rentalprediction/. Use this site for the entire tutorial in case any changes or additions are made there. If you want to use Native Scoring as a feature you do not have to install the Machine Learning Services feature but this demo will require it because we train the model using Python with SQL Server.

## Requirements

- SQL Server 2017 or later for Windows installed (Developer Edition will work just fine). You must choose the Machine Learning Services feature during installation (or add this feature if you have already installed)
- You need to download the TutorialDB database backup from https://sqlchoice.blob.core.windows.net/sqlchoice/static/TutorialDB.bak
- Enable this configuration option and restart SQL Server

EXEC sp_configure 'external scripts enabled', 1;
RECONFIGURE WITH OVERRIDE
GO

**Note:** With SQL Server 2019, python support exists for SQL Server on Linux. A linux version of this same demo can be achieved by installing Machine Learning services for Linux as documented at https://docs.microsoft.com/en-us/machine-learning-server/install/machine-learning-server-linux-install and follow the demo steps below.

## Demo Steps

1. Run **setup.sql** to restore the TutorialDB database backup
2. Run the statements and examine the output from **rental_prediction.sql** to see an example of a machine learning model with Python and SQL Server.
3. Run the statements and examine the output from **native_scoring.sql** to see an example of a machine learning model trained with Python but executed with native scoring in T-SQL.
 


