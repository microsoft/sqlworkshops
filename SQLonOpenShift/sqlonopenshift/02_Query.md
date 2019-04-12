![](../graphics/microsoftlogo.png)

# Workshop: SQL Server on OpenShift

#### <i>A Microsoft workshop from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/textbubble.png"> <h2>Connect and Query SQL Server</h2>

You'll cover the following topics in this Module:

<dl>

<dt><a href="#2-0">2.0 Connect to SQL Server</a></dt>
<dt><a href="#2-1">2.1 Restore a Database Backup</a></dt>
<dt><a href="#2-2">2.2 Execute SQL Server Queries</a></dt>
  
</dl>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="2-0">2.0 Connect to SQL Server</a></h2>

SQL Server provides several tools to connect and execute queries. Applications can use a variety of languages including C++, .Net, node.js, and Java. To see examples of how to write applications to connect to SQL Server, visit https://aka.ms/sqldev.

The simplest method to connect to SQL Server deployed on OpenShift is to use the command line toold **sqlcmd**, which is natively built for Windows, Linux, and MacOS systems. The Prerequisites for this workshop provided instructions for how to install the SQL Command Line tools including sqlcmd. In some deliveries of this workshop, sqlcmd may already be installed.

To connect to SQL Server, you need first know:

- The name of the server or IP address hosting SQL Server
- The port number (if SQL was configured to not use the default port of 1433)
- A login name
- A password

In order to complete the Activities of this Module, you must first complete the Activity in **Module 1 Deploy SQL Server on OpenShift**. In Module 1, you deployed a pod with a SQL Server Container. The Activities in this module will help you determine the above information on how to connect to your SQL Server deployment.

Proceed to the Activity to learn the fundamentals of connecting to SQL Server deployed on OpenShift.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b><a name="aks">Activity: Connect to SQL Server</a></b></p>

Follow these steps to connect to SQL Server deployed on OpenShift:

1. The most fundamental method to connect to SQL Server is to use sqlcmd and execute the T-SQL query SELECT @@version to determine the version of SQL Server installed. Think of this as the *Hello World* test of SQL Server. Execute the following commands from your shell prompt or use the script **step1_test_sql.sh** found in the **02_query** folder:

    `SERVERIP=$(oc get service | grep mssql-service | awk {'print $4'})`<br>
    `PORT=31433`<br>
    `sqlcmd -Usa -PSql2019isfast -S$SERVERIP,$PORT -Q"SELECT @@version"`

    In this example, the IP address and the port of the Load Balancer service is used to connect to SQL Server as the IP address of the pod may change if OpenShift has to restart or move the pod.

    The output of this command will look something like this should the connection and query be successful

    <pre>--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Microsoft SQL Server 2019 (CTP2.4) - 15.0.1400.75 (X64)
        Mar 16 2019 11:53:26
        Copyright (C) 2019 Microsoft Corporation
        Developer Edition (64-bit) on Linux (Red Hat Enterprise Linux Server 7.6 (Maipo)) X64                       
    (1 rows affected)</pre>

Proceed to the next activity to work with database with SQL Server.

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="2-1">2.1 Restore a Database Backup</a></h2>

SQL Server is all about data so one of the first things any user wants to do is create a database, populate some data into it, and run queries. For the purposes of this workshop, a simpler method to get going quickly is to restore a backup of an existing database and run queries. For this workshop, you will use the sample database provided by Microsoft called **WideWorldImporters**.

Proceed to the Activity to learn how to restore a database backup to SQL Server deployed on OpenShift.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b><a name="aks">Activity: Restore a SQL Database Backup</a></b></p>

Follow these steps to restore a database bnackup to SQL Server deployed on OpenShift:

1. If your workshop does not already include a copy of the backup of the WideWorldImporters database, execute the script **getwwi.sh** to download the backup.

2. In Module 1, you deployed SQL Server on OpenShift which is running in a container. So to restore a backup of WideWorldImporters, you must copy the backup you downloaded into the filesystem of the container. In this step, you will copy the backup into the container folder /var/opt/mssql. The SQL Server database engine by default has permissions to read backup files in this folder to restore the database. Execute the following command to copy the database backup file into the container or execute the script **step2_copy_backup_into_container.sh**

    `POD=$(oc get pods | grep mssql-deployment | awk {'print $1'})`<br>
    `oc cp ./WideWorldImporters-Full.bak $POD:/var/opt/mssql/WideWorldImporters-Full.bak`

    Depending on the speed of the connectivity of your computer, the process to copy the file into the container could take several minutes.

    When this command completes, there is no output. You placed back a the shell prompt

3. Now you will use the T-SQL **RESTORE DATABASE** command to restore the database backup. Execute the following commands using the sqlcmd tool or execute the script **step3_restore_backup.sh**:

    `SERVERIP=$(oc get service | grep mssql-service | awk {'print $4'})`<br>
    `PORT=31433`<br>
    `sqlcmd -Usa -PSql2019isfast -S$SERVERIP,$PORT -irestorewwi.sql`

    In this example, you used a T-SQL script to execute the RESTORE DATABASE command. You can examine the contents of the restorewwi.sql T-SQL script to see the example syntax using `cat restorewwi.sql` from the shell.

    The WideWorldImporters backup you downladed was created on SQL Server 2016 on Windows. SQL Server 2019 will automatically detect the older verison and upgrade the database. This is why the RESTORE command can take a few minutes to execute. When the command completes the output to the shell prompt will scroll across several lines but end with something like the following:

    <pre>...
    ...
    Database 'WideWorldImporters' running the upgrade step from version 895 to version 896<br>
    Database 'WideWorldImporters' running the upgrade step from version 896 to version 897<br>
    RESTORE DATABASE successfully processed 58455 pages in 30.797 seconds (14.828 MB/sec).</pre>

    Notice the end of the restore command displays how many database pages were restored (SQL Server stores data in 8K pages) and the duration  it took to restore the database. The database has been restored, brought online, and is available to run queries.


<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="2-2">2.2 Execute SQL Server Queries</a></h2>

xxxxxxxxxx
xxxxxxxx

Proceed to the Activity to learn how to run queries against a SQL Server deployed on OpenShift.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b><a name="aks">Activity: Execute SQL Server Queries</a></b></p>

Follow these steps to execute example queries against a SQL Server deployed on OpenShift:

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="../graphics/owl.png"><b>For Further Study</b></p>

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/geopin.png"><b >Next Steps</b></p>

Next, Continue to <a href="03_Performance.md" target="_blank"><i>SQL Server Performance</i></a>.
