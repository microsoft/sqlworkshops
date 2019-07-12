# SQL Server 2019 Polybase Fundamentals

This folder contains demo scripts to show the basic funcionality of Polybase by examining the configuration of nodes through DMV, creating an external table over HDFS, and monitoring execution details through DMVs.

## Requirements - Install and Configure Polybase

These demos require that you install SQL Server 2019 on Windows Server and configure a head node and at least one compute node (i.e. a scale out group). This demo currently requires SQL Server 2019 CTP 2.3 or higher.

I used the installation instructions in the documentation from:

https://docs.microsoft.com/en-us/sql/relational-databases/polybase/polybase-installation?view=sql-server-ver15

and this to setup the scale out group

https://docs.microsoft.com/en-us/sql/relational-databases/polybase/configure-scale-out-groups-windows?view=sql-server-ver15

For my demos, I used the following deployment to setup a head node and 2 compute nodes using Azure (Note: I used the same resource group for all of these servers so they were part of the same virtual network)

1 Windows Server 2019 Server which I configured using Server Manager as a domain controller (with a domain name of bobsql.com)

1 Windows Server 2019 Server (bwpolybase) which I joined to the bobsql.com domain. I installed SQL Server 2019 and chose the Polybase feature (including Java which required me to stop the install and install JRE 8 from the web). I chose the option for a Scale out group which required me to use the domain admin from bobsql.com during the install option for services.

2 other Windows Server 2019 Servers (bwpolybase2 and bwpolybase3)) with the same process to join the domain bobsql.com and install SQL server 2019 with Polybase.

I had to enable Polybase on all 3 SQL Servers per the documentation using sp_configure 'polybase enabled' 1 and this required a restart of SQL SErver. You must first do this step before setting up the scale out group.

I also first ensured that the Windows Firewall was configured for SQL Server and Polybase to open up firewall ports. Rules are already installed you just have to make sure they are enabled

- SQL Server PolyBase - Database Engine - <SQLServerInstanceName> (TCP-In)
- SQL Server PolyBase - PolyBase Services - <SQLServerInstanceName> (TCP-In)
- SQL Server PolyBase - SQL Browser - (UDP-In)

I then used the sp_polybase_join_group procedure per the documentation on bwpolybase2 and bwpolybase3 to join the scale out group. This required restarting the Polybase services on each machine.

## Demo Steps

### Check the Polybase configuration

1. Run the T-SQL commands in the script **polybase_status.sql** to see configuration of the scale out group and details of the head and compute nodes

2. Use SSMS to browse tables in the DWConfiguration, DWDiagnostics, and DWQueue databases which are installed on all nodes.

### Create an external table and track query and polybase execution

1. Download and restore the WideWorldImporters backup from https://github.com/Microsoft/sql-server-samples/tree/master/samples/databases/wide-world-importers

2. For my demo, I simply setup an Azure storage container using the instructions as found at https://docs.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-portal (note I did not create a blob just the storage account and container which in my case I named **wwi**).

3. Run all the T-SQL commands in **hdfs_external_table.sql**. You will need to edit the appropriate details to point to your Azure storage container including the credential and location for the data source

4. The the T-SQL commands in **trace_pb_query_execution.sql** to trace the execution of a query in Polybase.