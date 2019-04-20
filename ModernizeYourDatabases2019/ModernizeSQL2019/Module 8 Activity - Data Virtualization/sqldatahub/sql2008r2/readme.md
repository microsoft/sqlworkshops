# SQL Server 2019 Polybase example connecting to SQL Server 2008R2

This demo shows you how to setup a SQL Server 2008R2 external data source and table with examples of how to query the data source and join data to local SQL Server 2019 data. The demo assumes you have installed a SQL Server 2019 Polybase scale out group as documented in the **fundamentals** folder of this overall demo.

## Requirements

Install SQL Server 2008R2. For my environment, I installed SQL Server 2008R2 on Windows Server 2008R2 using Azure with the gallery template provided on Azure. I put this VM in the same resource group of my SQL Server 2019 Windows Server head node so I would be on the same virtual network. I then added the IP address of my SQL Server 2008R2 server in the /etc/hosts file of my SQL Server 2019 head node (bwpolybase) with the convenient name of bwsql2008r2. I also created a new user called sqluser (password is in the scripts to create the external data source), created a database (defaults) called JustWorldImporters, and made sqluser a dbo of that database.

## Demo Steps

1. Connecting to the bwsql2008r2 server, I ran the script **justwwi_suppliers.sql** to create the table and insert some data. Notice in this script I used partitions so that when scanning the remote table from Polybase, each compute node will query a specific set of partitions.

2. On my SQL Server 2019 head node (bwpolybase), I used the **sql2008r2_external_table.sql** script to create the database scoped credential, externaL data source, external table, and sample SELECT statements to query the external table and join it with local SQL Server 2019 tables in the WideWorldImporters database.

**BONUS**: Connect to your SQL Server 2008R2 instance and run SQL Profiler. Include the Hostname column in the trace. Notice when you scan the entire remote table all 3 nodes query individual partitions.