# SQL Server Polybase demo with SAP HANA using the odbc connector

This is a demo to show how to connect to a SAP HANA database using the odbc connector shipped with SQL Server 2019.

## Requirements

### SAP HANA Server Setup

You can use an existing SAP HANA system. For purposes of this demo I created an SAP HANA server using the SAP HANA Express Edition template from Azure which you can read more at https://azuremarketplace.microsoft.com/ja-/marketplace/apps/sap.hanaexpress?tab=Overview. This is a SUSE Linux VM with SAP HANA installed. I created this VM in the resource group of the polybase head node so I would be on the same virtual net. I also took the private IP address of the SAP VM and put this in c:\windows\system32\drivers\etc\hosts as bwsaphana so I could just refer to that hostname on my polybase head node.

- Go through the steps to get the SAP HANA server running on Azure with this guide https://developers.sap.com/tutorials/hxe-ms-azure-marketplace-getting-started.html 

- After following these steps, I disconnected by current ssh session and started a new one but this time logged in with hxeadm. The docs say the default password is HXEHana1. I was prompted to change my password. Note that the instance "number" is 90 using this Azure template.

- The client command line tool **hdbsql** is installed already through this process. So to create a database, a user, and a table with data, use the next set of scripts

- Execute **createdb.sh** to create a database. This will connect as the SYSTEM user and create a database called VANDELAY.

- Execute **createuser.sh** which will create a new user, bwsaphana, in the VANDELAY database and grant permissions.

- Execute **createtab.sh** which will create a new table, Customers, in the VANDELAY database connected as the bwsaphana user. I found out that the default schema for this table is called BWSAPHANA after querying the tables view. That is important as we will need it for the external table script.

- Execute **insertdata.sh** which will insert a row into the Customers table. I used a CustomerID of 100000 because this is far bigger than what the WideWorldImporters database would have in its Sales.Customer table set of ID values.

### Install the SAP HANA ODBC Driver

In order to use the general odbc connector built into SQL Server 2019 you must install the driver to connect to your ODBC data source. Since I am going to show you how to connect to SAP HANA, I found the official 64bit ODBC Driver for SAP HANA called HDBODBC. In order to support a scale out group you need to install this on each of the Polybase nodes. For purposes of this demo, I will only install this on the head node, bwpolybase.

I found the driver to download from https://developers.sap.com/trials-downloads.html

and found these docs on how to setup the driver on Windows

https://help.sap.com/viewer/e9146b36040844d0b1f309bc8c1ba6ab/2.5.0.0/en-US/321ff67a31f54654af30dad9f82347dc.html

**Note: You must install the driver on all nodes for the Polybase scale out group and configure them all with the same server and port. If you don't install this on the compute nodes you may get intermittent errors when querying the external table because Polybase may redirect your query through a compute node where the driver doesn't exist.**

The experience was interesting and here our some tips:

- Run the installer from a powershell or cmd window as Administrator
- Depending on what version of Windows Server, you may get an error on the VC++ runtime install like "Program terminated with exit code 1638". This driver depends on installing the VC++ runtime for VS 2015. I had a the VS 2017 runtime so it failed. The solution is to first uninstall the VS 2017 VC++ runtime, install the ODBC driver, and the reinstall the VS 2017 VC++ runtime.
- You want your System DSN to use the right port for SAP HANA. The port is based on the instance number and tenant (database) of the SAP HANA Server. The port will always be 3XXYY where XX = instance number and YY = number for the database. The instance number was 90 from the default Azure template install for me. But what about the VANDELAY database? Turns out there is a view called sys_databases.m_services in the SYSTEMDB database which tells you the SQL port for each database. When I ran a query against this view logged in as SYSTEM I found out the port for VANDELAY was 39041. So I used this port in the DSN configuration. 
- Since bwsaphana is im my hosts file to point to the private IP of the SAP VM, I can use that as the host server name.

### Polybase Setup

- If you have not done so already install and enable Polybase. You can use a single instance or scale out group. You do NOT need to choose the Java option when using this data source.
- Enable Polybase using the following T-SQL statement:

    exec sp_configure @configname = 'polybase enabled', @configvalue = 1;
RECONFIGURE [ WITH OVERRIDE ]  ;

## Demo Steps

All the instructions are in the **sap_external_table.sql** script to create the credential, data source, external table, and query against the remote table.

Take note of the syntax for the external data source. Note these strings are required even though the DSN has port specifics


```sql
CREATE EXTERNAL DATA SOURCE SAPHANAServer
WITH ( 
LOCATION = 'odbc://<data source>',
CONNECTION_OPTIONS = 'Driver={HDBODBC};ServerNode=<server>:<port>',
PUSHDOWN = ON,
CREDENTIAL = SAPHANACredentials
)
GO
```