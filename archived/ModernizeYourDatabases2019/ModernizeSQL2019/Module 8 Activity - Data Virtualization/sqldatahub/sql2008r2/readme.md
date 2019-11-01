# SQL Server 2019 Polybase example with SQL Server 2008R2

This demo shows you how to setup a SQL Server 2008R2 external data source and table with examples of how to query the data source and join data to local SQL Server 2019 data.

## Requirements

- Install SQL Server 2008R2. For my environment, I installed SQL Server 2008R2 on Windows Server 2008R2 using Azure with the gallery template provided on Azure. I put this VM in the same resource group of my SQL Server 2019 Windows Server head node so I would be on the same virtual network. I then added the IP address of my SQL Server 2008R2 server in the /etc/hosts file of my SQL Server 2019 head node (bwpolybase) with the convenient name of bwsql2008r2. I recommend you create a login and give them access to the database you create. You will need that information for the database scoped credentials.

- If you have not done so already install and enable Polybase. You can use a single instance or scale out group. The scripts in this example use partitions so if you want to see scaling based on these paritions you need to configure a Polybase scale out group. You do NOT need to choose the Java option when using this data source.
- Enable Polybase using the following T-SQL statement:

    exec sp_configure @configname = 'polybase enabled', @configvalue = 1;
RECONFIGURE [ WITH OVERRIDE ]  ;

## Demo Steps

- Connecting to the bwsql2008r2 server, I ran the script **justwwi_suppliers.sql** to create the table and insert some data. Notice in this script I used partitions so that when scanning the remote table from Polybase, each compute node will query a specific set of partitions.

- Follow the steps in **sql2008r2_external_table.sql** to create all the objects for the external table and query the external table.