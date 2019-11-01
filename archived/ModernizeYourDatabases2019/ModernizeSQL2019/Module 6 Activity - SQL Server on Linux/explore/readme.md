# Explore SQL Server on Linux

In this exercise you will learn how to explore SQL Server on Linux after you have deployed by learning

- Explore the SQL Server installation
- Common Linux commands
- How to connect to SQL Server
- How to restore a backup and run queries
- How to configure SQL Server

## Requirements

Many of these requirements are met if you follow the **deploy** exercises in this Module.

- SQL Server deployed on Linux
- SQL Server command line tools deployed for Linux
- SQL Server Managed Studio installed on a Windows client that can connect to your Linux Server or VM.
- Azure Data Studio deployed on Windows, Linux, or macOS on a client that can connect to your Linux Server of VM. You can read more about how to install Azure Data Studio at https://docs.microsoft.com/en-us/sql/azure-data-studio/download?view=sql-server-2017.

**Tip**: For many of my demos, I setup a resource group in Azure and put all of my VMs that I use for connectivity in the same resource group. This puts them all in the same virtual network. Now I can put the private IP addresses of all my VMs in the /etc/hosts file on either Windows or Linux and use those names to connect between VMs.

## Explore the SQL Server installation

In this exercise, you will explore the SQL Server installation post deployment.

1. Run the following command to see the state of SQL Server

    `sudo systemctl status mssql-server`

    Using sudo allows you to see the tail of the SQL Server ERRORLOG file.

2. Run the following commands to stop, start, and restart SQL Server.

    `sudo systemctl stop mssql-server`
    
    `sudo systemctl status mssql-server`
    
    `sudo systemctl start mssql-server`
    
    `sudo systemctl status mssql-server`
    
    `sudo systemctl restart mssql-server`
    
    `sudo systemctl status mssql-server`

    Note that there are no return values when starting, stopping, or restarting. You must run systemctl status to check on the status of SQL Server. With each start of SQL Server, you should see different PID values (for new processes).

3. Let's see where everything is installed. Run the following command to see where the binaries are installed

    `sudo ls -l /opt/mssql/bin`

    This directory contains the sqlservr executable, mssql-conf script, and other files to support crash dumps. There is no method today to change the location of these files.

4. Run these commands to see where the default directories for databases and ERRORLOG log (and other log files) are stored

    `sudo ls -l /var/opt/mssql/data`

    `sudo ls -l /var/opt/mssql/log`

    Note from the results that the owner of these files is mssql and mssql. This is a group and non-interactive user called mssql which is the context under which sqlservr executes. Any time sqlservr needs to read or write a file, that file or directory must have mssql:mssql permissions. There is no method to change this today. You can change the default locations of database files, backups, transaction log files, and the ERRORLOG directory using the mssql-conf script.

5. Let's dump out the current ERRORLOG file using a command on Linux called **cat** (and another variation using **more** so you can page the results)

    `sudo cat /var/opt/mssql/log/errorlog`

    `sudo more /var/opt/mssql/log/errorlog`

## Common Linux commands

Now that you have deployed SQL Server on Linux here are a few common commands you may need for Linux while working with SQL Server.

1. Find out information about the computer running Linux by running the following command

    `sudo dmidecode -t 1`

2. Find out information about the Linux distribution by running the following command

    `cat /etc/*-release`

3. Find out information about memory configured on the Linux Server by running the following command

    `cat /proc/meminfo`

    The **MemTotal** is the total amount of physical memory on the Linux Server

    The /proc directory is known as the *proc filesystem* and there is other interesting information exposed in files in this directory.

4. Find out about the number of cores, sockets, NUMA nodes, and chip architecture by running the following command

    `lscpu`

5. The **ps** command is used to view all processes on the Linux Server. Use this command to scroll through all processes including parent/child process relationships

    `ps axjf | more`

6. Run the following command to see a list of disks and mounted file systems on these disks including disk sizes

    `df -H`

    The disk starting with /dev are the true disks for the server.

7. To see basic performance information by process run the following command

    `top`

    **top** will sort the results with the process using the most CPU at the top which since nothing else is running is sqlservr

    The **KiB Mem** values show physical total, free, and used memory.  
    The **RES** column is the amount of physical memory used by a process like sqlservr.  

    **top** is interactive so type in "q" to quit the program 

8. **iotop** is a utility to monitor I/O statistics per process. However, it is not installed by default. Run the following command to first install iotop

    `sudo yum install -y iotop`

    Now run the following command to execute iotop

    `sudo iotop`

    This shows the overall I/O on the system plus I/O per process. Type in "q" to exit the program. Run this version of the command to only view I/O for processes actually using I/O. This program is interactive and refreshes itself every few seconds

    `sudo iotop -o`

    There are many other options with iotop. Execute the command `man iotop` to experiment with all iotop options.

9. **htop** is an interactive program to see process utilization information across processors and processes. However, it is not installed by default so run the following commands first to install htop.

    `sudo wget dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm`

    `sudo rpm -ihv epel-release-7-11.noarch.rpm`

    `sudo yum install -y htop`

    Now run the interactive htop command to observe its display

    `htop`

    Type "q" to exit the tool

10. You will likely need a good editor while using Linux. While the editor vi is installed by default, I recommend you use the **nano** editor. It may be already installed but if not run the following command to install it

    `sudo yum install -y nano`

    Let's use nano to create a shell script to run on Linux

    `nano dumperrorlog.sh`

    nano is a full screen editor. Type in the following in the editor window

    `sudo cat /var/opt/mssql/log/errorlog`

    Type Ctrl+X to exit. You will get prompted to save the file

    Run the following command to make the script executable

    `chmod u+x dumperrorlog.sh`

    Now execute the script

    `./dumperrorlog.sh`

## How to connect to SQL Server

Here are a few examples of how to do basic connectivity to SQL Server on Linux. These exercises assume you have installed the command line tools for Linux, mssql-cli, and have a machine or VM running Windows that can connect to the Linux server or VM.

1. Run a quick test to connect with sqlcmd by executing the following

    `sqlcmd -Usa -Slocalhost`

    Put in your sa password. At the sqlcmd prompt, run the following T-SQL statement

    ```sql
    SELECT @@VERSION
    GO
    ```
    Type in "exit" to quit sqlcmd

    Note: You can connect with any sqlcmd tool from Windows, Linux, or macOS in the same was provided you have connectivity to your Linux Server or VM. The -S<server> parameter would be the hostname or IP address of the Linux Server or VM.

2. Now test mssql-cli like we did for sqlcmd by running the following command

    `mssql-cli -Usa -Slocalhost`

    You should get a new prompt like sqlcmd. At this prompt type in the following T-SQL command and hit Enter

    ```sql
    SELECT @@VERSION
    ```

    Notice as you started typing you see Intellisense functionality kick-in which is one of the differences from sqlcmd.

    If you are not put back into the mssql-cli prompt, type "q" to get back to the prompt.

    mssql-cli does not recognize the "GO" keyword as sqlcmd does. Use a ";" to separate batches. You can also hit F3 to type statements in multiple lines but they will all be in one batch.

    Type in "exit" to quit mssql-cli

     Note: You can connect with any mssql-cli tool from Windows, Linux, or macOS in the same was provided you have connectivity to your Linux Server or VM. The -S<server> parameter would be the hostname or IP address of the Linux Server or VM.

3. Connect with SQL Server Management Studio (SSMS) using SQL Authentication with the sa account and the server name or IP address:port for your Linux Server. Notice how SSMS works "as is" against the Linux Server and looks almost like a SQL Server on Windows deployment.

    Use Object Explorer and the Query Editor just like you would a normal SQL Server instance. Go through some of the steps in the SSMS tutorial in our documentation at <https://docs.microsoft.com/sql/ssms/tutorials/tutorial-sql-server-management-studio>

4. Go through the the quickstart tutorial for connecting to SQL Server from Azure Data Studio with the SQL Server on Linux deployment at https://docs.microsoft.com/en-us/sql/azure-data-studio/quickstart-sql-server?view=sql-server-2017.

## How to restore a backup and run queries

In this exercise, you will learn how to restore a backup of a database to SQL Server on Linux, and run queries against the database.

Now you will learn the great compatibility story of SQL Server on Linux by restoring a backup from SQL Server on Windows to SQL Server on Linux. And you will interact with this database using sqlcmd and mssql-cli. This section of the lab assumes your Linux Server is connected to the internet. If you are not connected to the internet, you can download the database to restore from <https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Full.bak> and then copy it to your Linux Server (MobaXterm drag and drop is really nice for this)

1. From your Linux ssh session, run the following command from the bash shell

     `wget https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Full.bak`

    Depending on your network speed this should take no more than a few minutes

2. Copy and restore the WideWorldImporters database. Copy the **cpwwi.sh**, **restorewwi.sh**, and **restorewwi_linux.sql** files from the downloaded zip of the gitHub repo into your home directory on Linux. MobaXterm provides drag and drop capabilities to do this. Copy these files and drop them into the "explorer" pane in MobaXterm on the left hand side from your ssh session.

    Note: You can skip this step if you have already cloned the git repo in the prelab. If you have done this, the scripts in this lab are in the **sqllinuxlab** subdirectory. You can copy them into your home directory or edit them to ensure you have the right path for the WideWorldImporters backup file.

3. Run the following commands from the bash shell to make the scripts executable (supply the root password if prompted)

    `sudo chmod u+x cpwwi.sh`

    `sudo chmod u+x restorewwi.sh`

4. Copy the backup file to the SQL Server directory so it can access the file and change permissions on the backup file by executing the following command in the bash shell

    `./cpwwi.sh`

5. Now restore the database by executing the following command from the bash shell

    `./restorewwi.sh`

6. Connect with sa to run a query against this database. Run sqlcmd first to connect. Type in the sa password when prompted

    `sqlcmd -Usa -Slocalhost`

7. From the sqlcmd prompt run these commands

    ```sql
    USE WideWorldImporters
    GO
    SELECT * FROM [Sales].[Customers]
    GO
    ```

    Type in "exit" to quit sqlcmd

9. Now run the same set of commands using mssql-cli. Connect to SQL Server with mssql-cli. Type in the sa password when prompted

    `mssql-cli -Usa -Slocalhost`

10. Run the following T-SQL commands from the msql-cli prompt (BONUS: Use Intellisense to complete these queries)

    `USE WideWorldImporters;SELECT * FROM Sales.Customers;`

    See how mssql-cli by default will present rows in a vertical record format. Hit Enter or Space to keep paging as many rows as you like.

    Type in "q" at any time to get back to the prompt and "exit" to quit mssql-cli

## How to configure SQL Server

In this exercise, you will learn how to configure SQL Server on Linux with the mssql-conf tool.

There may be situations where you need to enable a traceflag as global and at SQL Server startup time. For Windows, this is done through the SQL Server Configuration Manager. For SQL Server on Linux, you will use the mssql-conf script. A list of all documented traceflags can be found at <https://docs.microsoft.com/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql>.

Let's say you wanted to enable trace flag 1222 for deadlock details to be reported in the ERRORLOG.

1. Run the following command from an ssh session with the bash shell

    `sudo /opt/mssql/bin/mssql-conf traceflag 1222 on`

2. Per these instructions, restart SQL Server with the following command:

    `sudo systemctl restart mssql-server`

    Note: If this is successful, the command just returns to the shell prompt

3. Verify the trace flag was properly set by looking at the ERRORLOG with the following command

    `sudo more /var/opt/mssql/log/errorlog`

4. Use sqlcmd or mssql-cli to verify this trace flag is set by running the following T-SQL statement

    ```sql
    DBCC TRACESTATUS(-1)
    ```