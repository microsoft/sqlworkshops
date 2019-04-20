# SQL Server 2019 Polybase example connecting to Azure SQL Database

This demo shows you how to setup an Azure SQL Database external data source and table with examples of how to query the data source and join data to local SQL Server 2019 data. The demo assumes you have installed a SQL Server 2019 Polybase scale out group as documented in the **fundamentals** folder of this overall demo.

## Requirements

1. Create a new database in Azure. For purposes of this demo it doesn't matter whether the database is a Managed Instance or any tier of Azure DB. For purposes of this demo I called my database **wwiazure**. To make connectivity easier, I created a new virtual network for my Azure SQL Server and included the polybase head node server, bwpolybase, in the same virtual network as Azure SQL Server. You can read more about how to do this at https://docs.microsoft.com/en-us/azure/sql-database/sql-database-vnet-service-endpoint-rule-overview

2. Connecting to the azure SQL Server hosting your database, I ran the script **createazuredbtable.sql** to create the table and insert some data. Notice the COLLATE clauses I needed to use to match what WWI uses from the example database. The table created for this demo mimics the **Warehouse.StockItem** table in the WideWorldImporters database.

## Demo Steps

1. On my SQL Server 2019 head node (bwpolybase), I used the **azuredb_external_table.sql** script to create the database scoped credential, externaL data source, external table, and sample SELECT statements to query the external table and join it with local SQL Server 2019 tables in the WideWorldImporters database. Take note of the COLLATE required to match WWI and the syntax for the external data source to point to the azure SQL Server.