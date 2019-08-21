![](https://github.com/microsoft/sqlworkshops/blob/master/graphics/microsoftlogo.png?raw=true)

# Lab: Database Discovery and Assessment for Migrating to Azure

#### <i>A Microsoft Lab from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=true"> <h2>Migrating Databases to the Microsoft Azure Platform </h2>

In this hands-on lab, you will implement a proof-of-concept (PoC) for migrating an on-premises SQL Server 2008 R2 database into Azure SQL Database Managed Instance (SQL MI) or Azure SQL Database. You will start your process by performing assessments to reveal any feature parity and compatibility issues between the on-premises SQL Server 2008 R2 database and the managed database offerings in Azure. 

At the end of this lab, you will be better able to implement a cloud migration solution for business-critical applications and databases.  

> **Note**:  
> These labs were modified from an existing day-long, hands-on-labs workshop to fit into this workshop. If you'd like to access the extended version of these labs refer to [MCW: Migrating SQL databases to Azure](https://github.com/microsoft/MCW-Migrating-SQL-databases-to-Azure).

In this Lab, you'll learn how to assess your on-premises estate (via Tailspin Toys) with tools like [Azure Migrate](https://docs.microsoft.com/en-us/azure/migrate/migrate-services-overview) and [Data Migration Assistant](https://docs.microsoft.com/en-us/sql/dma/dma-overview?view=sql-server-2017). The activities in this Lab include:  

&ensp;&ensp;&ensp;[Activity 1](#Activity-1): **Prepare:** Set up Azure Migrate  
&ensp;&ensp;&ensp;[Activity 2](#Activity-2): **Prepare**: Restore TailspinToys on the SQLServer2008 VM  
&ensp;&ensp;&ensp;[Activity 3](#Activity-3): **Assess:** Perform assessment for migration to Azure SQL Database  
&ensp;&ensp;&ensp;[Activity 4](#Activity-4): **Assess:** Perform assessment for migration to Azure SQL Database Managed Instance  


(<a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/00-Pre-Requisites.md" target="_blank">Make sure you check out the <b>Prerequisites</b> for this lab before you start</a>. You'll need all of the items loaded there before you can proceed. You can try this lab on your own or led by an instructor.)

<p style="border-bottom: 1px solid lightgrey;"></p>

### Lab Scenario: Tailspin Toys Gaming

[Tailspin Toys](http://tailspintoys.azurewebsites.net/?slug=model) is the developer of several products, including popular online video games, and has requested your help in determining where and how they should land their data in Azure. This is a decision that all businesses moving to the cloud have to make, and the result will depend on their unique business requirements. Microsoft has recently introduced Azure SQL, which brings all the SQL Server products in Azure under one suite. If you're already familiar with [Azure SQL Database](https://azure.microsoft.com/en-us/services/sql-database/), this slight shift means that Azure SQL also includes [Azure SQL VMs](https://azure.microsoft.com/en-us/services/virtual-machines/sql-server/), which Microsoft is continuously investing in and enhancing the benefits associated with it.  

<p style="border-bottom: 1px solid lightgrey;"></p>

## Solution architecture

Below is a diagram of the solution architecture you will build in this lab. Please study this carefully, so you understand the whole of the solution as you are working on the various components.

![This solution diagram includes a virtual network containing SQL MI in a isolated subnet, along with a JumpBox VM and Database Migration Service in a management subnet. The MI Subnet displays both the primary managed instance, along with a read-only replica, which is accessed by reports from the web app. The web app connects to SQL MI via a subnet gateway and point-to-site VPN. The web app is published to App Services using Visual Studio 2019. An online data migration is conducted from the on-premises SQL Server to SQL MI using the Azure Database Migration Service, which reads backup files from an SMB network share.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/preferred-solution-architecture.png?raw=true "Preferred Solution diagram")

Throughout the solution, you will use [Azure Migrate](https://docs.microsoft.com/en-us/azure/migrate/migrate-services-overview) as the central hub to track the discovery, assessment, and migration of Tailspin Toys. The solution begins with using the [Microsoft Data Migration Assistant](https://docs.microsoft.com/en-us/sql/dma/dma-overview?view=sql-server-2017) to perform assessments of feature parity and compatibility of the on-premises SQL Server 2008 R2 database against both Azure SQL Database (Azure SQL DB) and Azure SQL Database Managed Instance (SQL MI), with the goal of migrating the `TailspinToys` database into an Azure PaaS offering with minimal or no changes. After completing the assessments and reviewing the findings, the SQL Server 2008 R2 database is migrated into SQL MI using the Azure Database Migration Service's online data migration option. This allows the database to be migrated with little to no downtime, by using a backup and transaction logs stored in an SMB network share.  

They'll also leverage their existing licenses to get [Azure Hybrid Benefits](https://azure.microsoft.com/en-us/pricing/hybrid-benefit/), and they'll prepay for [reserved capacity](https://azure.microsoft.com/en-us/blog/announcing-general-availability-of-azure-sql-database-reserved-capacity/
). This will help them save money from the start.  

The web app is deployed to an Azure App Service Web App using Visual Studio 2019. Once the database has been migrated and cutover, the `TailspinToysWeb` application is configured to talk to the SQL MI VNet through a virtual network gateway using [point-to-site VPN](https://docs.microsoft.com/en-us/azure/vpn-gateway/point-to-site-about), and its connection strings are updated to point to the new SQL MI database.  

>**Note**: Due to time constraints, the lab will deal with switching the app running on a Jumpbox VM locally from leveraging data in SQL Server 2008 to SQL MI (but not the deployment to Azure or integrating the App Service with the Virtual Network). In the [extended version of these labs](https://github.com/microsoft/MCW-Migrating-SQL-databases-to-Azure/blob/master/Hands-on%20lab/HOL%20step-by-step%20-%20Migrating%20SQL%20databases%20to%20Azure.md#exercise-3-update-the-web-application-to-use-the-new-sql-mi-database), or if you have time at the end of the lab, you can do that.  

Once in SQL MI, several features of Azure SQL Database are examined. [Advanced Data Security (ADS)](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-advanced-data-security?view=sql-server-2017) is enabled and [Data Discovery and Classification](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-data-discovery-and-classification?view=sql-server-2017) is used to better understand the data and potential compliance issues with data in the database. The ADS [Vulnerability Assessment](https://docs.microsoft.com/en-us/azure/sql-database/sql-vulnerability-assessment?view=sql-server-2017) is used to identify potential security vulnerabilities and issues in the database, and those finding are used to mitigate one finding by enabling [Transparent Data Encryption](https://docs.microsoft.com/en-us/azure/sql-database/transparent-data-encryption-azure-sql?view=sql-server-2017) in the database. [Dynamic Data Masking (DDM)](https://docs.microsoft.com/en-us/sql/relational-databases/security/dynamic-data-masking?view=sql-server-2017) is used to prevent sensitive data from appearing when querying the database. Finally, [Read Scale-out](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-read-scale-out) is used to point reports on the Tailspin Toys web app to a read-only secondary, allowing reporting, particularly for the Leaderboard statistics page, to occur without impacting the performance of the primary database.  

> **Note:**  
> If you are attending this lab as part of a day-long workshop and were provided an environment, all of the activities below should be skipped. You can review or try them out at a later time.  

<h2><p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><a name="Activity-1">Activity 1: Set up Azure Migrate</h2></p></a>

> **Note:**  
> If you are attending this lab as part of a day-long workshop, you should skip this activity, it was demoed earlier. If you have time at the end of the day, feel free to return to it.  

In this activity, you'll set up Azure Migrate, and explore some of the new integrations between Microsoft's Data Migration Assistant (DMA) and Azure Database Migration Services (DMS).  

<h3><p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true">Steps</h3></p>

1. Log in to the Azure portal (with the account you're using for this workshop), and search for **Azure Migrate**:  
    ![Search for Azure Migrate.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/azure-migrate-search.png?raw=true "Search in Azure portal")  
2. As you can see, Azure Migrate can be used to migrate more than just databases. For now, select **Assess and migrate databases**:  
    ![Azure Migrate home.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/azure-migrate-home.png?raw=true "Azure Migrate")  
3. Select **Add tool(s)** under the *Assessment tools* section.  
![Azure Migrate home.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/azure-migrate-add-tool.png?raw=true "Azure Migrate")  
4. In *Migrate project* area select the subscription and resource group you're using for the workshops. Then, supply a Migration project name of **MigrateTailspinToys** and region. Then select **Next**.
    ![Azure Migrate project.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/azure-migrate-add-project.png?raw=true "Azure Migrate")  
    > **Note**:  
    > for region, select the one closest to you. The geography specified for the project is only used to store the metadata gathered from on-premises VMs. You can select any target region for the actual migration.
5. For assessment tools, select **Azure Migrate: Database Assessment**, then select **Add tool**.  
6. For migration tools, select **Azure Migrate: Database Migration**, and then select **Add tool**. Azure Migrate is now set up for you to use. In the next activity, you'll use some of the tools you added to assess and migrate Tailspin Toys to Azure.  

<p><h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><a name="Activity-2">Activity 2: Restore TailspinToys on the SQLServer2008 VM</h2></p></a>

> **Note:**  
> If you are attending this lab as part of a day-long workshop, you should skip this activity, it was demoed earlier. If you have time at the end of the day, feel free to return to it.  

<!--TODO: Can we make it so this part is done on each VM for each user ahead of the labs?-->

Before you begin the assessments, you need to restore a copy of the `TailspinToys` database in your SQL Server 2008 R2 instance. In this task, you will create an RDP connection to the SqlServer2008 VM and then restore the `TailspinToys` database onto the SQL Server 2008 R2 instance using a backup provided by Tailspin Toys.

<h3><p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true">Steps</h3></p>


1. In the [Azure portal](https://portal.azure.com), navigate to your **SqlServer2008** VM by selecting **Resource groups** from the left-hand navigation menu, selecting the **hands-on-lab-SUFFIX** resource group, and selecting the **SqlServer2008** VM from the list of resources. On the SqlServer2008 Virtual Machine's *Overview* blade, select **Connect** on the top menu.

    ![The SqlServer2008 VM blade is displayed, with the **Connect** button highlighted in the top menu.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/connect-sqlserver2008.png?raw=true "Connect to SqlServer2008 VM")

2. On the *Connect to virtual machine* blade, select **Download RDP File**, then open the downloaded RDP file.

3. Select **Connect** on the *Remote Desktop Connection* dialog.

    ![In the Remote Desktop Connection Dialog Box, the Connect button is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/remote-desktop-connection-sql-2008.png?raw=true "Remote Desktop Connection dialog")

4. Enter the following credentials when prompted, and then select **OK**:

    - *Username*: **sqlmiuser**
    > Note: Password should be consistent among all labs, ask your instructor for the password in an in-person Lab.

    ![The credentials specified above are entered into the Enter your credentials dialog.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/rdc-credentials-sql-2008.png?raw=true "Enter your credentials")

5. Select **Yes** to connect, if prompted that the identity of the remote computer cannot be verified.

    ![In the Remote Desktop Connection dialog box, a warning states that the identity of the remote computer cannot be verified, and asks if you want to continue anyway. At the bottom, the Yes button is circled.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/remote-desktop-connection-identity-verification-sqlserver2008.png?raw=true "Remote Desktop Connection dialog")

6. Once logged into the SqlServer2008 VM, download a [backup of the TailspinToys database](https://raw.githubusercontent.com/microsoft/Migrating-SQL-databases-to-Azure/master/Hands-on%20lab/lab-files/Database/TailspinToys.bak), and save it to the `C:\` drive of the VM.

7. Next, open *Microsoft SQL Server Management Studio 17* by entering **sql server** into the search bar in the Windows Start menu.

    ![SQL Server is entered into the Windows Start menu search box, and Microsoft SQL Server Management Studio 17 is highlighted in the search results.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/start-menu-ssms-17.png?raw=true "Windows start menu search")

8. In the SSMS *Connect to Server* dialog, enter **SQLSERVER2008** into the *Server name* box, ensure **Windows Authentication** is selected, and then select **Connect**.

    ![The SQL Server Connect to Search dialog is displayed, with SQLSERVER2008 entered into the Server name and Windows Authentication selected.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/sql-server-connect-to-server.png?raw=true "Connect to Server")

9. Once connected, right-click *Databases* under *SQLSERVER2008* in the *Object Explorer*, and then select **Restore Database** from the context menu.

    ![In the SSMS Object Explorer, the context menu for Databases is displayed and Restore Database is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-databases-restore.png?raw=true "SSMS Object Explorer")

10. You will now restore the `TailspinToys` database using the downloaded `TailspinToys.bak` file. On the *General* page of the *Restore Database* dialog, select **Device** under *Source*, and then select the **Browse (...)** button to the right of the *Device* box.

    ![Under Source in the Restore Database dialog, Device is selected and highlighted, and the Browse button is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-restore-database-source.png?raw=true "Restore Database source")

11. In the *Select backup devices* dialog that appears, select **Add**.

    ![In the Select backup devices dialog, the Add button is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-restore-database-select-devices.png?raw=true "Select backup devices")

12. In the *Locate Backup File* dialog, browse to the location you saved the downloaded `TailspinToys.bak` file, **select that file**, and then select **OK**.

    ![In the Location Backup File dialog, the TailspinToys.bak file is selected and highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-restore-database-locate-backup-file.png?raw=true "Locate Backup File")

13. Select **OK** on the *Select backup devices* dialog. This will return you to the *Restore Database* dialog. The dialog will now contain the information required to restore the `TailspinToys` database.

    ![The completed Restore Database dialog is displayed, with the TailSpinToys database specified as the target.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-restore-database.png?raw=true "Restore Database")

14. Select **OK** to start the restore.

15. Select **OK** in the dialog when the database restore is complete.

    ![A dialog is displayed with a message that the database TailspinToys was restored successfully.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-restore-database-success.png?raw=true "Restored successfully")

16. Next, you will execute a script in SSMS, which will reset the `sa` password, enable mixed mode authentication, enable Service broker, create the `WorkshopUser` account, and change the database recovery model to FULL. 

    To create the script, open a new query window in SSMS by selecting **New Query** in the *SSMS toolbar*.

    ![The New Query button is highlighted in the SSMS toolbar.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-new-query.png?raw=true "SSMS Toolbar")

17. Copy and paste the SQL script below into the new query window (replacing `<YourPasswordHere>` with the same password as the SQL Server 2008 VM):

    ```sql
    USE master;
    GO

    -- SET the sa password
    ALTER LOGIN [sa] WITH PASSWORD=N'<YourPasswordHere>';
    GO

    -- Enable Service Broker on the database
    ALTER DATABASE TailspinToys SET ENABLE_BROKER WITH ROLLBACK immediate;
    GO

    -- Enable Mixed Mode Authentication
    EXEC xp_instance_regwrite N'HKEY_LOCAL_MACHINE',
    N'Software\Microsoft\MSSQLServer\MSSQLServer', N'LoginMode', REG_DWORD, 2;
    GO

    -- Create a login and user named WorkshopUser
    CREATE LOGIN WorkshopUser WITH PASSWORD = N'<YourPasswordHere>';
    GO

    EXEC sp_addsrvrolemember
        @loginame = N'WorkshopUser',
        @rolename = N'sysadmin';
    GO

    USE TailspinToys;
    GO

    IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'WorkshopUser')
    BEGIN
        CREATE USER [WorkshopUser] FOR LOGIN [WorkshopUser]
        EXEC sp_addrolemember N'db_datareader', N'WorkshopUser'
    END;
    GO

    -- Update the recovery model of the database to FULL
    ALTER DATABASE TailspinToys SET RECOVERY FULL;
    GO
    ```

18. To run the script, select **Execute** from the *SSMS toolbar*.

    ![The Execute button is highlighted in the SSMS toolbar.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-execute.png?raw=true "SSMS Toolbar")

19. For Mixed Mode Authentication and the new `sa` password to take effect, you must restart the *SQL Server (MSSQLSERVER) Service* on the SqlServer2008 VM. To do this, you can use SSMS. Right-click the *SQLSERVER2008* instance in the *SSMS Object Explorer*, and then select **Restart** from the context menu.

    ![In the *SSMS Object Explorer*, the context menu for the *SQLSERVER2008* instance is displayed, and Restart is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-object-explorer-restart-sqlserver2008.png?raw=true "Object Explorer")

20. When prompted about restarting the *MSSQLSERVER* service, select **Yes**. The service will take a few seconds to restart.

    ![The Yes button is highlighted on the dialog asking if you are sure you want to restart the MSSQLSERVER service.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-restart-service.png?raw=true "Restart MSSQLSERVER service")


<h2><p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><a name="Activity-3">Activity 3: Perform assessment for migration to Azure SQL Database</h2></p></a>

> **Note:**  
> If you are attending this lab as part of a day-long workshop and were provided an environment to use, you should skip this activity, it was demoed earlier. If you have time at the end of the day, feel free to return to it.

In this task, you will use the *Microsoft Data Migration Assistant* (DMA) to perform an assessment of the `TailspinToys` database against Azure SQL Database (Azure SQL DB). The assessment will provide a report about any feature parity and compatibility issues between the on-premises database and the Azure SQL DB service.  

> **Note:**  
> Tailspin Toys Gaming has already tentatively decided that they want to move to Managed Instance. However, this is a good exercise if they didn't know that Service Broker wasn't supported by Azure SQL DB and wanted to move to Azure SQL DB.    

<h3><p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true">Steps</h3></p>


1. On the SqlServer2008 VM, launch DMA from the *Windows Start menu* by typing **data migration** into the *search bar*, and then selecting **Microsoft Data Migration Assistant** in the search results.

    ![In the Windows Start menu, "data migration" is entered into the search bar, and Microsoft Data Migration Assistant is highlighted in the Windows start menu search results.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/windows-start-menu-dma.png?raw=true "Data Migration Assistant")

2. In the *DMA dialog*, select **+** from the left-hand menu to create a new project.

    ![The new project icon is highlighted in DMA.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dma-new.png?raw=true "New DMA project")

3. In the *New project* pane, set the following:

    - *Project type*: Select **Assessment**
    - *Project name*: Enter **ToAzureSqlDb**
    - *Source server type*: Select **SQL Server**
    - *Target server type*: Select **Azure SQL Database**

    ![New project settings for doing an assessment of a migration from SQL Server to Azure SQL Database.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dma-new-project-to-azure-sql-db.png?raw=true "New project settings")

> **Note:**  
> There's also an option to select "Migration" within DMA. You could use this option if you have restrictions around pushing versus pulling the data to Azure. Using DMA to migrate would be pushing data from the SQL Server 2008 VM into Azure. In this lab, we'll instead pull data from the SQL Server 2008 VM. You can learn more about migrating to Azure using DMA [here](https://docs.microsoft.com/en-us/sql/dma/dma-migrateonpremsqltosqldb?view=sql-server-2017).
4. Select **Create**

5. On the *Options* screen, ensure **Check database compatibility** and **Check feature parity** are both checked, and then select **Next**:

    ![Check database compatibility and check feature parity are checked on the Options screen.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dma-options.png?raw=true "DMA options")

6. On the *Sources* screen, enter the following into the *Connect to a server* dialog that appears on the right-hand side:

    - *Server name*: Enter **SQLSERVER2008**
    - *Authentication type*: Select **SQL Server Authentication**
    - *Username*: Enter **WorkshopUser**
    - *Password*: Enter your password  
    - *Encrypt connection*: Check this box
    - *Trust server certificate*: Check this box

    > **Note:**  
    > Password should be consistent among all labs, ask your instructor if you don't know what your password is.  

    ![In the Connect to a server dialog, the values specified above are entered into the appropriate fields.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dma-connect-to-a-server.png?raw=true "Connect to a server")

7. Select **Connect**

8. On the *Add sources* dialog that appears next, check the box for **TailspinToys** and select **Add**:

    ![The TailspinToys box is checked on the Add sources dialog](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dma-add-sources.png?raw=true "Add sources")

9. Select **Start Assessment**:

    ![Start assessment](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dma-start-assessment-to-azure-sql-db.png?raw=true "Start assessment")

10. Review the assessment of ability to migrate to Azure SQL DB.

    ![For a target platform of Azure SQL DB, feature parity shows two features which are not supported in Azure SQL DB. The Service broker feature is selected on the left and on the right Service Broker feature is not supported in Azure SQL Database is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dma-service-broker.png?raw=true "Database feature parity")

    > The DMA assessment for a migrating the `TailspinToys` database to a target platform of Azure SQL DB shows two features in use which are not supported. These features, cross-database references and Service Broker, will prevent TailspinToys from being able to migrate to the Azure SQL DB PaaS offering without first making changes to their database.

11. In the bottom right (see above), select **Upload to Azure Migrate**. You'll be prompted to sign in (use the credentials you're using for this workshop). Then, select the subscription and **Azure Migrate Project** created earlier. This process will upload the summarized report to the Azure Migrate service. If you have multiple servers and/or databases, you'll be provided with a consolidated view of all the databases you scan and upload in the Azure Migrate portal. Select **Upload**:  

    ![Start assessment](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dma-upload-azure-migrate.png?raw=true "Start assessment")

12. When it completes, you'll see the following message:  
    ![Start assessment](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dma-assessment-uploaded.png?raw=true "Start assessment")  


<h2><p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><a name="Activity-4">Activity 4: Perform assessment for migration to Azure SQL Database Managed Instance</h2></p></a>

> **Note**:  
> If you are attending this lab as part of a day-long workshop, you should skip this activity, it was demoed earlier. If you have time at the end of the day, feel free to return to it.


With one PaaS offering ruled out due to feature parity, you will now perform a second assessment. In this task, you will use DMA to perform an assessment of the `TailspinToys` database against Azure SQL Database Managed Instance (SQL MI). The assessment will provide a report about any feature parity and compatibility issues between the on-premises database and the SQL MI service.


<h3><p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true">Steps</h3></p>


1. To get started, select **+** on the left-hand menu in DMA to create another new project:.

    ![The new project icon is highlighted in DMA.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dma-new.png?raw=true "New DMA project")

2. In the *New project* pane, set the following:

    - *Project type*: Select **Assessment**
    - *Project name*: Enter **ToSqlMi**
    - *Source server type*: Select **SQL Server**
    - *Target server type*: Select **Azure SQL Database Managed Instance**

    ![New project settings for doing an assessment of a migration from SQL Server to Azure SQL Database Managed Instance.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dma-new-project-to-sql-mi.png?raw=true "New project settings")

3. Select **Create**

4. On the *Options* screen, ensure **Check database compatibility** and **Check feature parity** are both checked, and then select **Next**:

    ![Check database compatibility and check feature parity are checked on the Options screen.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dma-options.png?raw=true "DMA options")

5. On the *Sources* screen, enter the following into the *Connect to a server* dialog that appears on the right-hand side:

    - *Server name*: Enter **SQLSERVER2008**
    - *Authentication type*: Select **SQL Server Authentication**
    - *Username*: Enter **WorkshopUser**
    - *Password*: Enter your password
    - *Encrypt connection*: Check this box
    - *Trust server certificate*: Check this box

    > Note: Password should be consistent among all labs, ask your instructor if you don't know what your password is.

    ![In the Connect to a server dialog, the values specified above are entered into the appropriate fields.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dma-connect-to-a-server.png?raw=true "Connect to a server")

6. Select **Connect**

7. On the *Add sources* dialog that appears next, check the box for *TailspinToys* and select **Add**:

    ![The TailspinToys box is checked on the Add sources dialog.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dma-add-sources.png?raw=true "Add sources")

8. Select **Start Assessment**:

    ![Start assessment](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dma-start-assessment-to-sql-mi.png?raw=true "Start assessment")


9. Review the assessment of ability to migrate to Azure SQL Database Managed Instance, then upload to Azure Migrate, as in the previous activity:

    ![For a target platform of Azure SQL Database Managed Instance, feature parity with PowerShell job step is listed.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dma-to-sql-mi.png?raw=true "Database feature parity")

>**Note**:  
>The assessment report for migrating the `TailspinToys` database to a target platform of SQL MI shows feature parity only with a PowerShell job step. In SQL MI, SQL Server Agent is always running, and T-SQL and SSIS job steps are supported. However, PowerShell job steps are not yet supported. This serves as a warning, but it will not impact the migration of the `TailspinToys` database to SQL MI. Since SQL Server Agent Jobs are not supported in Azure SQL Database at all and TailspinToys doesn't leverage SQL Server Agent jobs, this is not mentioned in the assessment to move to Azure SQL Database. You can [review the full configuration of Azure SQL MI here](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-managed-instance-transact-sql-information#configuration).

10. The database, including the cross-database references and Service broker features, can be migrated as is, providing the opportunity for TailspinToys to have a fully managed PaaS database running in Azure. Previously, their options for migrating a database using features, such as Service Broker, incompatible with Azure SQL Database, were to deploy the database to a virtual machine running in Azure (IaaS) or modify their database and applications to not use the unsupported features. The introduction of Azure SQL MI, however, provides the ability to migrate databases into a managed Azure SQL database service with near 100% compatibility, including the features that prevented them from using Azure SQL Database.  
> **Note:**  
> For more information, check out the [feature comparison list](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-features) for SQL Server vs. Azure SQL Database vs. Azure SQL MI, and the [known T-SQL differences between Azure SQL MI and SQL Server](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-managed-instance-transact-sql-information).

11. Open the Azure portal, and navigate back to Azure Migrate. Select **Databases**. You should now see the results from the DMA scans. This will bring all of the databases and servers you scan and upload using DMA together, and provide a consolidated view.

    ![Azure Migrate consolidated view](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/azure-migrate-databases.png?raw=true "Azure Migrate")
  

12. You can click into **Assessed databases > TailspinToys** to see additional details and recommendations:  
    ![Azure Migrate Tailspin Toys details](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/azure-migrate-tailspin.png?raw=true "Azure Migrate")  

> **Note**:  
> If you are attending this lab as part of a day-long workshop, you have finished the activities for Module 4. [Return to it here](https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/04-SQLServerOnTheMicrosoftAzurePlatform.md#activity-4-perform-assessment-for-migration-to-azure-sql-database-managed-instance), review, and refer to instructor guidance.  

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/owl.png?raw=true"><h2>For Further Study</h2></p>
<ul>
    <li><a href="https://datamigration.microsoft.com/
    " target="_blank">Azure Database Migration Guide</a> contains lots of resources that will help in guiding and supporting database migrations to Azure.</li>
    <li><a href="https://docs.microsoft.com/en-us/azure/migrate/migrate-services-overview
    " target="_blank">Azure Migrate Documentation</a> contains more information, guidance, and pointers on how to migrate your entire on-premises estate to Azure.</li>
    <li><a href="https://docs.microsoft.com/en-us/sql/dma/dma-overview?view=sql-server-2017
    " target="_blank">Data Migration Assistant Documentation</a> contains more information and best practices around the DMA tool explored in this module.</li>
    <li><a href="https://azure.microsoft.com/mediahandler/files/resourcefiles/choosing-your-database-migration-path-to-azure/Choosing_your_database_migration_path_to_Azure.pdf
    " target="_blank">Choosing your database migration path to Azure</a> is a white paper created by Microsoft for deeper understanding of how to modernize and migrate on-premises SQL Server to Azure.</li>
</ul>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/geopin.png?raw=true"><b >Next Steps</b></p>

You can use this assessment to determine to move the database to Azure SQL Managed Instance. If you would like to complete a lab on that topic, navigate to <a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/Lab-MigratingToAzureSQLManagedInstance.md" target="_blank"><i> Lab - Migrating to Azure SQL Managed Instance</i></a>.