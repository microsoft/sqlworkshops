# SQL Server 2019 Polybase example with Oracle

This demo shows you how to setup a Oracle external data source and table with examples of how to query the data source and join data to local SQL Server 2019 data.

## Requirements - Installing and setting up Oracle

SQL Server external tables should work with most current Oracle versions (11g+) so for this demo you can choose any Oracle installation or platform you like

- I've included a script called **oraconnect.sh** as an example to connect an Oracle instance.

- I wanted a user other than SYSTEM so used the script **createuser.sql** to create a new user called g1.

- Using this new login, I ran the script **createtab.sql** to create a new table with the instance. You can run this script using sqlplus64 like the following:

    `sqlplus64 gl/glpwd@localhost:<port>/<instance> @createtab.sql`

- I then executed the **insertdata.sql** script finding a valid CustomerTransactionID from the Sales.CustomerTransactions table in the WideWorldImporters database. This ID becomes the arref fields in the accounts receivable table.

- If you have not done so already install and enable Polybase. You can use a single instance or scale out group. The scripts in this example use partitions so if you want to see scaling based on these partitions you need to configure a Polybase scale out group. You do NOT need to choose the Java option when using this data source.
- Enable Polybase using the following T-SQL statement:

    exec sp_configure @configname = 'polybase enabled', @configvalue = 1;
RECONFIGURE [ WITH OVERRIDE ]  ;

## Demo Steps

With everything in hand on my Oracle server, I now can use the **oracle_external_table.sql** script to create the data source and external table.

Note the syntax for the LOCATION string for the external table which I was required to use UPPERCASE even though I didn't create these objects in uppercase using sqlplus64.

`LOCATION='[XE].[GL].[ACCOUNTSRECEIVABLE]'`

This script also includes examples to query the table and join together with the [Sales].[CustomerTransactions] table.
