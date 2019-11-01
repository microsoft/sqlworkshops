# Deploy SQL Server on Linux

This demo is used to show the basic steps to deploy SQL Server on Linux using RedHat Enterprise Linux. While this exercise shows you how to deploy SQL Server on RedHat, Ubuntu and SUSE are also supported. See our installation gudiance for SQL Server 2017 https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup?view=sql-server-2017 and SQL Server 2019 https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup?view=sql-server-2017#sqlvnext for more information on how to install SQL Server on those Linux distributions.

## Requirements

- A RedHat Linux installation. This can be either in a VM or bare metal machine. Look at the the Prerequisites in our documentation page at https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-red-hat?view=sql-server-2017#prerequisites
- Ensure your machine or VM meets the Systems requirements at https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup?view=sql-server-2017#system.
- Use either a built-in ssh from your client (Ex. Linux, macOS, or bash shell for Windows at https://docs.microsoft.com/en-us/windows/wsl/install-win10). As a windows usser, I like to use Mobaxterm (https://mobaxterm.mobatek.net/).
- You also need to establish connectivity with your Linux server or VM by having the IP address available and port 22 for ssh open for connectivity.

## How to deploy SQL Server on Linux

Run all of the following commands from your ssh session with the bash shell. This lab assumes your Linux Server is connected to the internet. You can do an offline installation of SQL Server on Linux. See the documentation at <https://docs.microsoft.com/sql/linux/sql-server-linux-setup#offline>

For this exercise we will be using SQL Server 2019 Preview but you can also do the same set of instructions for SQL Server 2017 as documented at https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-red-hat?view=sql-server-2017.

1. Copy the repository configuration file using the following command

   `sudo curl -o /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/7/mssql-server-preview.repo`

    The repository configuration file is a text file that contains the location of the SQL Server package for RHEL. This repo file will point to the latest preview build of SQL Server 2019 on Linux. See our documentation for how to use a repository file for other branches <https://docs.microsoft.com/sql/linux/sql-server-linux-change-repo>

    With a good internet connection this should take a few seconds.

2. Use the yum package manager to kick off the installation with the following command (-y means don't prompt)

    `sudo yum install -y mssql-server`

    This involves download an ~220Mb file and performing the first phase of install. With a good internet connection this should only take a few minutes.

3. Now you must complete the installation by executing a bash shell script we install called **mssql-conf** (which uses a series of python scripts). We will also use mssql-conf later to perform a configuration task for SQL Server. Execute the following command

    `sudo /opt/mssql/bin/mssql-conf setup`

    Go through the prompts to pick Edition (choose Developer or Enterprise Core for these labs), accept the EULA, and put in the sa password (must meet strong password requirements like SQL Server on Windows). Remember the sa password as you will use it often in the labs.

4. Open up the firewall on Linux for the SQL Server port by running the following two commands. This is required if you plan to connect to SQL Server on a remote client.

    `sudo firewall-cmd --zone=public --add-port=1433/tcp --permanent`

    `sudo firewall-cmd --reload`

    Believe it or not, that's it! You have now installed SQL Server on Linux which includes the core database engine and SQL Server Agent

5. Install the command line tools as documented at https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-red-hat?view=sql-server-2017#tools

6. Install the mssql-cli tool as documented at https://github.com/dbcli/mssql-cli/blob/master/doc/installation/linux.md#red-hat-enterprise-linux-rhel-7. This is a new command line tool which you will use in other exercises.