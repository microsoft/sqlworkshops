# SQL Server 2019 Polybase example with Azure SQL Database

This demo shows you how to setup an Azure SQL Database external data source and table with examples of how to query the data source and join data to local SQL Server 2019 data.

## Requirements

- Create a new database in Azure. For purposes of this demo it doesn't matter whether the database is a Managed Instance or any tier of Azure DB. For purposes of this demo I called my database **wwiazure**. To make connectivity easier, I created a new virtual network for my Azure SQL Server and included the polybase head node server, bwpolybase, in the same virtual network as Azure SQL Server. You can read more about how to do this at https://docs.microsoft.com/en-us/azure/sql-database/sql-database-vnet-service-endpoint-rule-overview

- Connecting to the azure SQL Server hosting your database, I ran the script **createazuredbtable.sql** to create the table and insert some data. Notice the COLLATE clauses I needed to use to match what WWI uses from the example database. The table created for this demo mimics the **Warehouse.StockItem** table in the WideWorldImporters database.

If you have not installed and enabled Polybase, you should

- Install SQL Server 2019 Polybase. You can use a single instance or scale out group.
- You do NOT need to choose to install the Java option.
- Enable Polybase using the following T-SQL statement:

    exec sp_configure @configname = 'polybase enabled', @configvalue = 1;
RECONFIGURE [ WITH OVERRIDE ]  ;

## Demo Steps

Follow the steps in **azuredbexternaltable.ipynb** or **azuredbexternaltable.sql** to create and use an external table to Azure SQL Database.