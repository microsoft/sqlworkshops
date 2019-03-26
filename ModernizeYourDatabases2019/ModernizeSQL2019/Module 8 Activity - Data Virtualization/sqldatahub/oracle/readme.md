# SQL Server 2019 Polybase example connecting to Oracle

This demo shows you how to setup a Oracle external data source and table with examples of how to query the data source and join data to local SQL Server 2019 data. The demo assumes you have installed a SQL Server 2019 Polybase scale out group as documented in the **fundamentals** folder of this overall demo.

## Requirements - Installing and setting up Oracle

SQL Server external tables should work with most current Oracle versions (11g+) so for this demo you can choose any Oracle installation or platform you like. For my demo, I used Oracle Express 11g using docker containers on Red Hat Enterpise Linux in an Azure Virtual Machine. The following are the steps and scripts I used to install and Oracle instance using a docker container and create a table to be used for the demo. I created my RHEL VM in Azure in the same resource group (bwsql2019demos) as the polybase head node running SQL Server 2019 on Windows Server. I then on this head node server added an entry in the /etc/hosts file for the RHEL Azure VM private IP address with a name of bworacle so I can use this name when creating an external data source.

1. Install Docker CE for CentOS using these instructions at https://docs.docker.com/install/linux/docker-ce/centos/

2. Used these instructions to pull a docker container image for Oracle at https://github.com/wnameless/docker-oracle-xe-11g. This site has instructions for running the container, instance ID, and password for SYSTEM.

3. Installed OCI client and SQLPlus RPM packages from http://yum.oracle.com/repo/OracleLinux/OL7/oracle/instantclient/x86_64/index.htm

4. I had to configure SQLPLUS (sqlplus64 is actually the program to use) by setting the following environment variables:
- ORACLE_SID=xe
- LD_LIBRARY_PATH=/usr/lib/oracle/18.3/client64/lib 
- ORACLE_HOME=/usr/lib/oracle/18.3/client64

5. I was then able to connect to ORACLE XE on this machine using syntax like

sqlplus64 system/oracle@localhost:49161/xe 

49161 is the port number from running the docker image for XE 
oracle is the password for SYSTEM

I've included a script called **oraconnect.sh** as an example.

6. I wanted a user other than SYSTEM so used the script **createuser.sql** to create a new user called g1.

7. Using this new login, I ran the script **createtab.sql** to create a new table with the instance. You can run this script using sqlplus64 like the following:

sqlplus64 gl/glpwd@localhost:49161/xe @createtab.sql

8. I then executed the **insertdata.sql** script finding a valid CustomerTransactionID from the Sales.CustomerTransactions table in the WideWorldImporters database. This ID becomes the arref fields in the accounts receivable table.

## Demo Steps

1. With everything in hand on my Oracle server, I now can use the oracle_external_table.sql script to create the data source and external table.

Note the syntax for the LOCATION string for the external table which I was required to use UPPERCASE even though I didn't create these objects in uppercase using sqlplus64.

LOCATION='[XE].[GL].[ACCOUNTSRECEIVABLE]'

This script also includes examples to query the table and join together with the [Sales].[CustomerTransactions] table.
