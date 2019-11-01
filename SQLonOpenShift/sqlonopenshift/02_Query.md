![](../graphics/microsoftlogo.png)

# Workshop: SQL Server 2019 on OpenShift (CTP 2.5)

#### <i>A Microsoft workshop from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/textbubble.png"> <h2>Connect and Query SQL Server</h2>

You'll cover the following topics in this Module:

<dl>

<dt><a href="#2-0">2.0 Connect to SQL Server</a></dt>
<dt><a href="#2-1">2.1 Restore a Database Backup</a></dt>
<dt><a href="#2-2">2.2 Execute SQL Server Queries</a></dt>
  
</dl>

>**NOTE**: *If at anytime during the Activities of this Module you need to "start over" you can go back to the first Activity in 2.0 and run through all the steps again. If you need to redeploy the SQL Server container and pod, go back to the Activity in Module 1, run the **cleanup.sh** script and follow all steps in the Module.*

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="2-0">2.0 Connect to SQL Server</a></h2>

SQL Server provides several tools to connect and execute queries. Applications can use a variety of languages including C++, .Net, node.js, and Java. To see examples of how to write applications to connect to SQL Server, visit https://aka.ms/sqldev.

The simplest method to connect to SQL Server deployed on OpenShift is to use the command line tool **sqlcmd**, which available on Windows, Linux, and MacOS Operating Systems. The *Prerequisites* for this workshop provides instructions for installing the SQL Command Line tools including **sqlcmd**. In some deliveries of this workshop, **sqlcmd** may already be installed.

To connect to SQL Server, you need:

- The name of the server or IP address hosting SQL Server
- The port number (if SQL was configured to not use the default port of 1433)
- The login name
- The password for the login

In order to complete the Activities of this Module, you must first complete the Activity in **Module 1 Deploy SQL Server on OpenShift**. In Module 1, you deployed a pod with a SQL Server Container. The Activities in this module will help you determine the above information on how to connect to your SQL Server deployment.

Proceed to the next Activity to learn the fundamentals of connecting to SQL Server deployed on OpenShift.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b><a name="aks">Activity: Connect to SQL Server</a></b></p>

Follow these steps to connect to SQL Server deployed on OpenShift:

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Change directories for the scripts for this module</p>

Run the following command from the shell:

`cd ~/sqlworkshops/SQLonOpenShift/sqlonopenshift/02_query`

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Ensure your scripts are executable</p>

Run the following command (depending on your Linux shell and client you may need to preface this with `sudo`):

`chmod u+x *.sh`

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Run a query</p>

The most fundamental method to connect to SQL Server is to use **sqlcmd** and execute the T-SQL query `SELECT @@version` to determine the version of SQL Server installed. (Think of this as the *Hello World* test of SQL Server.)

Execute the following commands from your shell prompt or use the script **step1_test_sql.sh**:
<br>

`SERVERIP=$(oc get service | grep mssql-service | awk {'print $4'})`<br>
`PORT=31433`<br>
`sqlcmd -Usa -PSql2019isfast -S$SERVERIP,$PORT -Q"SELECT @@version"`<br>

In this example, the IP address and the port of the Load Balancer service is used to connect to SQL Server, since the IP address of the pod may change if OpenShift has to restart or move the pod. You used the `-Q` parameter of **sqlcmd** which allows you to specify T-SQL statements directly from the command line.

The output of this command will look similar to the following:

<pre>
Microsoft SQL Server 2019 (CTP2.2) - 15.0.1200.24 (X64)
Dec 5 2018 16:51:26
Copyright (C) 2019 Microsoft Corporation
Developer Edition (64-bit) on Linux (Red Hat Enterprise Linux Server 7.6 (Maipo)) X64                       
(1 rows affected)
</pre>

(Your version information may be different depending on the version of SQL Server installation)

Next, proceed to the next activity to work with databases with SQL Server by restoring a backup.

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="2-1">2.1 Restore a Database Backup</a></h2>

SQL Server is all about data, so one of the first things any user wants to do is create a database, populate some data into it, and run queries. For the purposes of this workshop, a simpler method to get started is to restore a backup of an existing database and run queries. For this workshop, you will use the sample database provided by Microsoft called **WideWorldImporters**.

Proceed to the next Activity to learn how to restore a database backup to SQL Server deployed on OpenShift.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b><a name="aks">Activity: Restore a SQL Database Backup</a></b></p>

Follow these steps to restore a database backup to SQL Server deployed on OpenShift:

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Locate the Database Backup</p>

If your workshop does not already include a copy of the backup of the WideWorldImporters database (a file called **WideWorldImporters-Full.bak**) execute the script **getwwi.sh** to download the backup. This script assumes connectivity to the internet.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Copy the Database Backup to the SQL Server 2019 Container</p>

In Module 1, you deployed SQL Server on OpenShift which is running in a container. To restore the backup of **WideWorldImporters**, you must copy the backup you downloaded into the filesystem of the container. 

In this step, you will copy the backup into the container running SQL Server 2019, into a folder called `/var/opt/mssql`. The SQL Server database engine by default has permissions to read backup files in this folder to restore the database. 

Execute the following command to copy the database backup file into the container or execute the script **step2_copy_backup_into_container.sh**:

`POD=$(oc get pods | grep mssql-deployment | awk {'print $1'})`<br>
`oc cp ./WideWorldImporters-Full.bak $POD:/var/opt/mssql/WideWorldImporters-Full.bak`<br>

Depending on the speed of the connectivity of your computer, the process to copy the file into the container could take several minutes.

When this command completes, there is no output. You are placed back a the shell prompt.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Restore the Backup to SQL Server 2019</p>

Next you will use the T-SQL **RESTORE DATABASE** command to restore the database backup. 

Execute the following commands using the sqlcmd tool or execute the script **step3_restore_backup.sh**:

`SERVERIP=$(oc get service | grep mssql-service | awk {'print $4'})`<br>
`PORT=31433`<br>
`sqlcmd -Usa -PSql2019isfast -S$SERVERIP,$PORT -irestorewwi.sql`

In this example, you used the `-i` parameter for **sqlcmd** to execute a *script* with the `RESTORE DATABASE` command. You can examine the contents of the **restorewwi.sql** T-SQL script to see the example syntax using `cat restorewwi.sql` from the shell.

The WideWorldImporters backup you downloaded was created on SQL Server 2016 on Windows. One of the great stories for SQL Server is compatibility across operating systems. Database backups are interoperable between SQL Server on Windows and Linux. SQL Server 2019 will automatically detect the older version and upgrade the database. This is why the RESTORE command can take a few minutes to execute. When the command completes the output to the shell prompt will scroll across several lines but end with something similar to the following: 

<pre>
Database 'WideWorldImporters' running the upgrade step from version 895 to version 896<br>Database 'WideWorldImporters' running the upgrade step from version 896 to version 897<br>RESTORE DATABASE successfully processed 58455 pages in 30.797 seconds (14.828 MB/sec).
</pre>

Notice the end of the restore command displays how many database pages were restored (SQL Server stores data in 8K pages) and the duration it took to restore the database. The database has now been restored, brought online, and is available to run queries.

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="2-2">2.2 Execute SQL Server Queries</a></h2>

The T-SQL language allows all types of queries to be executed against your data including basic CRUD operations (Create, Read, Update, and Delete) and a host of other functionality. You can find the complete T-SQL reference at https://docs.microsoft.com/en-us/sql/t-sql/language-reference.

If you are given a database backup to restore, one of the first things you want to do is explore what is in the database. SQL Server provides a rich set of metadata about the database through *catalog views*. This allows you to find out what tables, columns, and other objects exist in a database.

In addition, to find out what data exists within tables in the database, you will use the most often used T-SQL command **SELECT** against tables you have permissions to query.

SQL Server also provides a robust set of *dynamic management views* (DMV) through SELECT statements to query the state of the database engine.

Proceed to the Activity to learn how to run queries against a SQL Server deployed on OpenShift including catalog views, data within the database, and Dynamic Management Views.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b><a name="aks">Activity: Execute SQL Server Queries</a></b></p>

Follow these steps to execute example queries against a SQL Server deployed on OpenShift: 

>**NOTE**: *These steps assume you have followed the previous sections of this module.*

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Explore database tables</p>

Run the following set of commands to find out what user tables are in the WideWorldImporters database backup you restored. You can also use the script **step4_find_tables.sh**:

`SERVERIP=$(oc get service | grep mssql-service | awk {'print $4'})`<br>
`PORT=31433`<br>
`sqlcmd -Usa -PSql2019isfast -S$SERVERIP,$PORT -Q"USE WideWorldImporters;SELECT name, SCHEMA_NAME(schema_id) as schema_name FROM sys.objects WHERE type = 'U' ORDER BY name" -Y30`<br>

When the command completes, the output should scroll across your screen like this:

 <pre>

Changed database context to 'WideWorldImporters'.

name                           schema_name
------------------------------ ------------------------------
BuyingGroups                   Sales
BuyingGroups_Archive           Sales
Cities                         Application
Cities_Archive                 Application
ColdRoomTemperatures           Warehouse
ColdRoomTemperatures_Archive   Warehouse
Colors                         Warehouse
Colors_Archive                 Warehouse
Countries                      Application
Countries_Archive              Application
CustomerCategories             Sales
CustomerCategories_Archive     Sales
Customers                      Sales
Customers_Archive              Sales
CustomerTransactions           Sales
DeliveryMethods                Application
DeliveryMethods_Archive        Application
InvoiceLines                   Sales
Invoices                       Sales
OrderLines                     Sales
Orders                         Sales
PackageTypes                   Warehouse
PackageTypes_Archive           Warehouse
PaymentMethods                 Application
PaymentMethods_Archive         Application
People                         Application
People_Archive                 Application
PurchaseOrderLines             Purchasing
PurchaseOrders                 Purchasing
SpecialDeals                   Sales
StateProvinces                 Application
StateProvinces_Archive         Application
StockGroups                    Warehouse
StockGroups_Archive            Warehouse
StockItemHoldings              Warehouse
StockItems                     Warehouse
StockItems_Archive             Warehouse
StockItemStockGroups           Warehouse
StockItemTransactions          Warehouse
SupplierCategories             Purchasing
SupplierCategories_Archive     Purchasing
Suppliers                      Purchasing
Suppliers_Archive              Purchasing
SupplierTransactions           Purchasing
SystemParameters               Application
TransactionTypes               Application
TransactionTypes_Archive       Application
VehicleTemperatures            Warehouse

(48 rows affected)
</pre>

You can see from the bottom of this output that there are 48 tables in this database. The output includes two columns, one is for the name of the table, and other is for the *schema* of the table. A schema allows you to organize objects in a group for applications, provide isolation of objects at a group (e.g. there can be the same table name in two different schemas), and security permissions at a group level. In order to query data from a table you need to know the name of the schema and have permissions for that schema.

>**NOTE**: *In the above use of **sqlcmd**, the `-Y30` parameter is used to ensure results are displayed as fixed width characters no longer than 30 characters for readability.*

Now run the following commands to query data from the **People** table in the **Application** schema. In this database, the Application schema is used for tables that are used across the application and the People table holds data for any persons used across the Application for the WideWorldImporters company. You can also execute the script **step5_find_people.sh** to run these commands:

`SERVERIP=$(oc get service | grep mssql-service | awk {'print $4'})`<br>
`PORT=31433`<br>
`sqlcmd -Usa -PSql2019isfast -S$SERVERIP,$PORT -Q"USE WideWorldImporters;SELECT TOP 10 FullName, PhoneNumber, EmailAddress FROM [Application].[People] ORDER BY FullName;" -Y30`

Your results should look similar to the following:

<pre>
Changed database context to 'WideWorldImporters'.

FullName                       PhoneNumber          EmailAddress
------------------------------ -------------------- ------------------------------
ahlada Thota                   (215) 555-0100      aahlada@tailspintoys.com
Aakarsha Nookala               (201) 555-0100      akarsha@tailspintoys.com
Aakriti Bhamidipati            (307) 555-0100      aakriti@wingtiptoys.com
Aakriti Byrraju                (216) 555-0100      aakriti@example.com
Aamdaal Kamasamudram           (316) 555-0100      aamdaal@wingtiptoys.com
Abel Pirvu                     (216) 555-0100      abel@wingtiptoys.com
Abel Spirlea                   (218) 555-0100      abel@example.com
Abel Tatarescu                 (217) 555-0100      abel@example.com
Abhaya Rambhatla               (231) 555-0100      abhaya@wingtiptoys.com
Abhoy Prabhupda                (423) 555-0100      abhoy@tailspintoys.com

(10 rows affected)
</pre>

In this example, you used the `TOP 10` option of a `SELECT` statement to only retrieve the first 10 rows in the People table and the `ORDER BY` clause to sort the results by name (default ascending).

These results contain privacy information. You can review a feature of SQL Server called Dynamic Data Masking to mask privacy information from application users. See more at [https://docs.microsoft.com/en-us/sql/relational-databases/security/dynamic-data-masking](https://docs.microsoft.com/en-us/sql/relational-databases/security/dynamic-data-masking).

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Get Server Information Using a Query</p>

You can also run a query to gather dynamic information about the running state of the SQL Server database engine. Run the following commands to see insights into running sessions, queries, and memory consumption. You can also run the script **step6_dmv.sh** to execute these commands.

`SERVERIP=$(oc get service | grep mssql-service | awk {'print $4'})`<br>
`PORT=31433`<br>
`sqlcmd -Usa -PSql2019isfast -S$SERVERIP,$PORT -idmv.sql`<br>

This an example of running a T-SQL script with three *batches*. A batch is a series of T-SQL statements and with a script you can submit several batches from a single file. The contents of **dmv.sql** look like this:


```sql
SELECT session_id, login_time, host_name, program_name, reads, writes, cpu_time
FROM sys.dm_exec_sessions WHERE is_user_process = 1
GO
SELECT dr.session_id, dr.start_time, dr.status, dr.command
FROM sys.dm_exec_requests dr
JOIN sys.dm_exec_sessions de
ON dr.session_id = de.session_id
AND de.is_user_process = 1
GO
SELECT cpu_count, committed_kb from sys.dm_os_sys_info
GO
```

The output should look something similar to this:

<pre>
session_id    login_time                 host_name            program_name    reads    writes    cpu_time
----------    -------------------------  -------------------- -------------   -----    -------   --------
51            2019-04-12 15:04:50.513    mssql-deploymen      SQLServerCEIP    0        0        50
52            2019-04-12 15:08:21.147    troyryanwin10        SQLCMD           0        0        0

(2 rows affected)

session_id start_time                status                         command
---------- ----------------------    ------------------------------ --------------------------------
52         2019-04-12 15:08:21.317   running                        SELECT

(1 rows affected)

cpu_count   committed_kb
----------- --------------------
2           405008
</pre>

The first T-SQL batch provides information about the sessions connected to SQL Server with information about the session. The second T-SQL batch provides information about active queries against SQL Server. The third batch provides information about how many CPUs SQL Server detected and how much memory the database engine has consumed. There are many Dynamic Management Views and more columns available than in the examples you used. You can read about all DMVs at https://docs.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/system-dynamic-management-views.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Optional - More Queries</p>

As an optional exercise, you can connect with the **sqlcmd** program and run ad-hoc queries against SQL Server. You should only run `SELECT` statements to read from SQL Server so you will not have issues with other Modules. 

Run the following commands to get a prompt to interactively use **sqlcmd**:

`SERVERIP=$(oc get service | grep mssql-service | awk {'print $4'})`<br>
`PORT=31433`<br>
`sqlcmd -Usa -PSql2019isfast -S$SERVERIP,$PORT -dWideWorldImporters`<br>

You will be presented with a prompt:

<pre>
1>
</pre>    

You can now run T-SQL statement interactively with **sqlcmd**. By typing in a query and hitting ENTER, you can type in the keyword **GO** and press the ENTER key to execute a query. The command `:help` displays commands specific to the sqlcmd utility. The complete T-SQL reference can be found at https://docs.microsoft.com/en-us/sql/t-sql/language-reference.

Type in the keyword **exit** to leave **sqlcmd**.

You can now proceed to **Next Steps** to learn more about SQL Server Performance.

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="../graphics/owl.png"><b>For Further Study</b></p>

- [The sqlcmd utility](https://docs.microsoft.com/en-us/sql/tools/sqlcmd-utility)
- [Query Data with SQL Server](https://docs.microsoft.com/en-us/sql/lp/sql-server/query-data)
- [Backup and Restore of SQL Server Databases](https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/back-up-and-restore-of-sql-server-databases)
- [SQL Server Catalog Views](https://docs.microsoft.com/en-us/sql/relational-databases/system-catalog-views/catalog-views-transact-sql)
- [SQL Server Dynamic Management Views](https://docs.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/system-dynamic-management-views)
- [The WideWorldImporters sample database](https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-what-is)

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/geopin.png"><b >Next Steps</b></p>

Next, Continue to <a href="03_Performance.md" target="_blank"><i>SQL Server Performance</i></a>.
