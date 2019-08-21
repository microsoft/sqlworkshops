![](https://github.com/microsoft/sqlworkshops/blob/master/graphics/microsoftlogo.png?raw=true)

# Lab: Migrating to Azure SQL Managed Instance

#### <i>A Microsoft Lab from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=true"> <h2> Migrate to Azure SQL Managed Instance</h2>

In this lab you'll migrate a database from SQL Server 2008 to [Azure SQL Database Managed Instance](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-managed-instance).  


(<a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/00-Pre-Requisites.md" target="_blank">Make sure you check out the <b>Prerequisites</b> page before you start</a>. You'll need all of the items loaded there before you can proceed with the workshop.)

In this lab you will use the [Azure Database Migration Service](https://azure.microsoft.com/services/database-migration/) (DMS) to migrate the `TailspinToys` database from an on-premises SQL 2008 R2 database to SQL MI. At the end of the Lab, you'll also explore some of the security and performance features available. 

The activities in this lab include:  
  
[Lab Exercise 1](#LabExercise-1): Migrate the database to SQL Managed instance   
&ensp;&ensp;&ensp;[Activity 1](#Activity-1): Create a SMB network share on the SQLServer2008VM  
&ensp;&ensp;&ensp;[Activity 2](#Activity-2): Change MSSQLSERVER service to run under sqlmiuser account  
&ensp;&ensp;&ensp;[Activity 3](#Activity-3): Create a backup of TailspinToys database  
&ensp;&ensp;&ensp;[Activity 4](#Activity-4): Retrieve SQL MI, SQL Server 2008 VM, and service principal connection information  
&ensp;&ensp;&ensp;[Activity 5](#Activity-5): Create a service principal  
&ensp;&ensp;&ensp;[Activity 6](#Activity-6): Create and run an online data migration project  
&ensp;&ensp;&ensp;[Activity 7](#Activity-7): Perform migration cutover  
&ensp;&ensp;&ensp;[Activity 8](#Activity-8): Verify database and transaction log migration  
&ensp;&ensp;&ensp;[Activity 9](#Activity-9): Update the application  

[Lab Exercise 2](#LabExercise-2): Improve database security with Advanced Data Security   
&ensp;&ensp;&ensp;[Activity 1](#Activity-2-1): Enable Advanced Data Security  
&ensp;&ensp;&ensp;[Activity 2](#Activity-2-2): Configure SQL Data Discover and Classification  
&ensp;&ensp;&ensp;[Activity 3](#Activity-2-3): Review Advanced Data Security Vulnerability Assessment  

[Lab Exercise 3](#LabExercise-3): Use online secondary for read-only queries   
&ensp;&ensp;&ensp;[Activity 1](#Activity-3-1): View Leaderboard report in Tailspin Toys web application  
&ensp;&ensp;&ensp;[Activity 2](#Activity-3-2): Update read only connection string  
&ensp;&ensp;&ensp;[Activity 3](#Activity-3-3): Reload leaderboard report in the Tailspin Toys web application  

[Lab Exercise 4](#LabExercise-4): After the Migration



<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><a name="LabExercise-1">Lab Exercise 1: Migrate the database to SQL Managed instance </h2></a>

In this section, you will use the [Azure Database Migration Service](https://azure.microsoft.com/services/database-migration/) (DMS) to migrate the `TailspinToys` database from the on-premises SQL 2008 R2 database to SQL MI. Tailspin Toys mentioned the importance of their gamer information web application in driving revenue, so for this migration you will target the [Business Critical service tier](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance#managed-instance-service-tiers).  

> The Business Critical service tier is designed for business applications with the highest performance and high-availability (HA) requirements. To learn more, read the [Managed Instance service tiers documentation](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance#managed-instance-service-tiers).

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="Activity-1">Activity 1: Create an SMB network share on the SQLServer2008VM</b></p></a>

In this task, you will create a new [SMB network share](https://docs.microsoft.com/en-us/windows/win32/fileio/microsoft-smb-protocol-authentication) on the SqlServer2008 VM. This will be the folder used by DMS for retrieving backups of the `TailspinToys` database during the database migration process. By creating the share, you're making it possible for services like DMS to access items in the share if you authenticate to it. You can read more about [the SMB protocol here](https://docs.microsoft.com/en-us/windows/win32/fileio/microsoft-smb-protocol-and-cifs-protocol-overview). 

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>


1. In the [Azure portal](https://portal.azure.com), navigate to your *SqlServer2008* VM by selecting **Resource groups** from the *left-hand navigation menu*, selecting the **hands-on-lab-SUFFIX** resource group, and selecting the **SqlServer2008** VM from the list of resources. On the SqlServer2008 Virtual Machine's *Overview* blade, select **Connect** on the top menu:

    ![The SqlServer2008 VM blade is displayed, with the Connect button highlighted in the top menu.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/connect-sqlserver2008.png?raw=true "Connect to SqlServer2008 VM")

2. On the Connect to virtual machine blade, select **Download RDP File**, then open the downloaded RDP file.

3. Select **Connect** on the Remote Desktop Connection dialog:

    ![In the Remote Desktop Connection Dialog Box, the Connect button is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/remote-desktop-connection-sql-2008.png?raw=true "Remote Desktop Connection dialog")

4. Enter the following credentials when prompted, and then select **OK**:

    - *Username*: **sqlmiuser**

    > **Note:**  
    > Password should be consistent among all labs. Your instructor will provide the password for in-class Labs.  

    ![The credentials specified above are entered into the Enter your credentials dialog.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/rdc-credentials-sql-2008.png?raw=true "Enter your credentials")

5.  Select **Yes** to connect, if prompted that the identity of the remote computer cannot be verified:

    ![In the Remote Desktop Connection dialog box, a warning states that the identity of the remote computer cannot be verified, and asks if you want to continue anyway. At the bottom, the Yes button is circled.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/remote-desktop-connection-identity-verification-sqlserver2008.png?raw=true "Remote Desktop Connection dialog")

6. On the SqlServer2008 VM, open *Windows Explorer* by selecting its icon on the Windows Task bar:

    ![The Windows Explorer icon is highlighted in the Windows Task Bar.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/windows-task-bar.png?raw=true "Windows Task Bar")

7. In the *Windows Explorer* window, expand **Computer** in the tree view, select **Windows (C:)**, and then select **New folder** in the top menu:

    ![In Windows Explorer, Windows (C:) is selected under Computer in the left-hand tree view, and New folder is highlighted in the top menu.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/windows-explorer-new-folder.png?raw=true "Windows Explorer")

8. Name the new folder **dms-backups**, then right-click the folder and select **Share with** and **Specific people** in the context menu:

    ![In Windows Explorer, the context menu for the dms-backups folder is displayed, with Share with and Specific people highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/windows-explorer-folder-share-with.png?raw=true "Windows Explorer")

9. In the *File Sharing* dialog, ensure the **sqlmiuser** is listed with a **Read/Write** permission level, and then select **Share**:

    ![In the File Sharing dialog, the sqlmiuser is highlighted and assigned a permission level of Read/Write.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/file-sharing.png?raw=true "File Sharing")

10. In the **Network discovery and file sharing** dialog, select the default value of **No, make the network that I am connected to a private network**:

    ![In the Network discovery and file sharing dialog, No, make the network that I am connected to a private network is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/network-discovery-and-file-sharing.png?raw=true "Network discovery and file sharing")

11. Back on the File Sharing dialog, note the path of the shared folder, `\\SQLSERVER2008\dms-backups`, and select **Done** to complete the sharing process.

    ![The Done button is highlighted on the File Sharing dialog.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/file-sharing-done.png?raw=true "File Sharing")


<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="Activity-2">Activity 2: Change the MSSQLSERVER service to run under sqlmiuser account</b></p></a>

In this task, you will use the SQL Server Configuration Manager to update the service account used by the *SQL Server (MSSQLSERVER)* service to the `sqlmiuser` account. This is done to ensure the SQL Server service has the appropriate permissions to write backups to the shared folder.

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>


1. On your SqlServer2008 VM, select the **Start menu**, enter **sql configuration** into the search bar, and then select **SQL Server Configuration Managed** from the search results:

    ![In the Windows Start menu, "sql configuration" is entered into the search box, and SQL Server Configuration Manager is highlighted in the search results.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/windows-start-sql-configuration-manager.png?raw=true "Windows search")

    > **Note**:  
    > Be sure to choose **SQL Server Configuration Manager**, and not **SQL Server 2017 Configuration Manager**, which will not work for the installed SQL Server 2008 R2 database.  

2. In the *SQL Server Configuration Manager* dialog, select **SQL Server Services** from the tree view on the left, then right-click **SQL Server (MSSQLSERVER)** in the list of services and select **Properties** from the context menu:

    ![SQL Server Services is selected and highlighted in the tree view of SQL Server Configuration Manager. In the Services pane, SQL Server (MSSQLSERVER) is selected and highlighted. Properties is highlighted in the context menu.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/sql-server-configuration-manager-services.png?raw=true "SQL Server Configuration Manager")

3. In the *SQL Server (MSSQLSERVER) Properties* dialog, select **This account** under *Log on as*, and enter the following:

    - *Account name*: **sqlmiuser**
    
    > **Note:**  
    > Password should be consistent among all labs, ask your instructor if you don't know what your password is.

    ![In the SQL Server (MSSQLSERVER) Properties dialog, This account is selected under Log on as and the sqlmiuser account name and password are entered.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/sql-server-service-properties.png?raw=true "SQL Server (MSSQLSERVER) Properties")

4. Select **OK**

5. Select **Yes** in the *Confirm Account Change dialog*:

    ![The Yes button is highlighted in the Confirm Account Change dialog.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/confirm-account-change.png?raw=true "Confirm Account Change")

6. You will now see the *Log On As* value for the *SQL Server (MSSQLSERVER)* service changed to `./sqlmiuser`:

    ![In the list of SQL Server Services, the SQL Server (MSSQLSERVER) service is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/sql-server-service.png?raw=true "SQL Server Services")

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="Activity-3">Activity 3: Create a backup of TailspinToys database</b></p></a>

To perform online data migrations, DMS looks for backups and logs in the SMB shared backup folder on the source database server. In this task, you will create a backup of the `TailspinToys` database using SSMS, and write it to the SMB network share you created in the previous task. The backup file needs to include a checksum, so you will add that during the backup steps.

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

1. On the SqlServer2008 VM, open *Microsoft SQL Server Management Studio 17* by entering **sql server** into the search bar in the Windows Start menu:

    ![SQL Server is entered into the Windows Start menu search box, and Microsoft SQL Server Management Studio 17 is highlighted in the search results.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/start-menu-ssms-17.png?raw=true "Windows start menu search")

2. In the SSMS *Connect to Server* dialog, enter **SQLSERVER2008** into the *Server name* box, ensure **Windows Authentication** is selected, and then select **Connect**:

    ![The SQL Server Connect to Search dialog is displayed, with SQLSERVER2008 entered into the Server name and Windows Authentication selected.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/sql-server-connect-to-server.png?raw=true "Connect to Server")

3. Once connected, expand **Databases** under *SQLSERVER2008* in the *Object Explorer*, and then right-click the **TailspinToys** database. In the context menu, select **Tasks** and then **Back Up**:

    ![In the SSMS Object Explorer, the context menu for the TailspinToys database is displayed, with Tasks and Back Up... highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-backup.png?raw=true "SSMS Backup")

4. In the *Back Up Database* dialog, you will see `C:\TailspinToys.bak` listed in the *Destinations* box. This is no longer needed, so select it, and then select **Remove**:

    ![In the General tab of the Back Up Database dialog, C:\TailspinToys.bak is selected and the Remove button is highlighted under destinations.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-back-up-database-general-remove.png?raw=true)

 5. Next, select **Add** to add the SMB network share as a backup destination:

    ![In the General tab of the Back Up Database dialog, the Add button is highlighted under destinations.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-back-up-database-general.png?raw=true "Back Up Database")

6. In the *Select Backup Destination* dialog, select the **Browse (...)** button:

    ![The Browse button is highlighted in the Select Backup Destination dialog.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-select-backup-destination.png?raw=true "Select Backup Destination")

7. In the *Locate Database Files* dialog, select the `C:\dma-backups` folder, enter **TailspinToys.bak** into the *File name* field, and then select **OK**:

    ![In the Select the file pane, the C:\dms-backups folder is selected and highlighted and TailspinToys.bak is entered into the File name field.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-locate-database-files.png?raw=true "Location Database Files")

8. Select **OK** to close the Select Backup Destination dialog

9. In the *Back Up Database* dialog, select the **Media Options** in the *Select a page* pane, and then set the following:

    - Select **Back up to the existing media set** and then select **Overwrite all existing backup sets**
    - Under *Reliability*, check the box for **Perform checksum before writing to media**. This is required by DMS when using the backup to restore the database to SQL MI:

    ![In the Back Up Database dialog, the Media Options page is selected, and Overwrite all existing backup sets and Perform checksum before writing to media are selected and highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-back-up-database-media-options.png?raw=true "Back Up Database")

10. Select **OK** to perform the backup

11. You will receive a message when the backup is complete. Select **OK**:

    ![Dialog displayed a message that the database backup was completed successfully.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-backup-complete.png?raw=true "Backup complete")

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="Activity-4">Activity 4: Retrieve SQL MI, SQL Server 2008 VM, and service principal connection information</b></p></a>

> **Note**:  
> If you're doing this lab as part of a workshop and were provided an environment to use, this step has already been completed. You can review, but **there is nothing you need to do**. Please refer to instructor guidance.  

In this task, you will use the Azure Cloud shell to retrieve the information necessary to connect to your SQL MI and SqlServer2008 VM from DMS.

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>


1. In the [Azure portal](https://portal.azure.com), select the **Azure Cloud Shell** icon from the top menu:

    ![The Azure Cloud Shell icon is highlighted in the Azure portal's top menu.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/cloud-shell-icon.png?raw=true "Azure Cloud Shell")

2. In the *Cloud Shell* window that opens at the bottom of your browser window, select **PowerShell**:

    ![In the Welcome to Azure Cloud Shell window, PowerShell is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/cloud-shell-select-powershell.png?raw=true "Azure Cloud Shell")

3. If prompted that you have no storage mounted, select the subscription you are using for this hands-on lab and select **Create storage**:

    ![In the You have no storage mounted dialog, a subscription has been selected, and the Create Storage button is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/cloud-shell-create-storage.png?raw=true "Azure Cloud Shell")

    > **Note**:  
    > If creation fails, you may need to select **Advanced settings** and specify the subscription, region and resource group for the new storage account.

4. After a moment, you will receive a message that you have successfully requested a Cloud Shell, and be presented with a PS Azure prompt:

    ![In the Azure Cloud Shell dialog, a message is displayed that requesting a Cloud Shell succeeded, and the PS Azure prompt is displayed.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/cloud-shell-ps-azure-prompt.png?raw=true "Azure Cloud Shell")

5. At the prompt, you will retrieve information about SQL MI in the hands-on-lab-SUFFIX resource group by entering the following PowerShell command, **replacing SUFFIX** with your unique identifier:

    ```powershell
    az sql mi list --resource-group hands-on-lab-SUFFIX
    ```

6. Within the output of the above command, locate and copy the value of the `fullyQualifiedDomainName` property. Paste the value into a text editor, such as *Notepad.exe*, for later reference:

    ![The output from the az sql mi list command is displayed in the Cloud Shell, and the fullyQualifiedDomainName property and value are highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/cloud-shell-az-sql-mi-list-output.png?raw=true "Azure Cloud Shell")

7. Next, you will enter a second command to retrieve the public IP address of the SqlSerer2008 VM, which you will use to connect to the database on that server. Enter the following PowerShell command, **replacing SUFFIX** with your unique identifier:

    ```powershell
    az vm list-ip-addresses -g hands-on-lab-SUFFIX -n SqlServer2008
    ```

8. Within the output of the command above, locate and copy the value of the `ipAddress` property within the `publicIpAddresses` object. Paste the value into a text editor, such as *Notepad.exe*, for later reference:

    ![The output from the az vm list-ip-addresses command is displayed in the Cloud Shell, and the publicIpAddress for the SqlServer2008 VM is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/cloud-shell-az-vm-list-ip-addresses.png?raw=true "Azure Cloud Shell")

9. (Leave the Azure Cloud Shell open for the next set of tasks)


<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="Activity-5">Activity 5: Create a service principal</b></p></a>

> **Note**:  
> If you're doing this lab as part of a workshop and were provided an environment to use, this step has already been completed. You can review, but **there is nothing you need to do**. Please refer to instructor guidance.  

In this task, you will use the Azure Cloud Shell to create an Azure Active Directory (Azure AD) application and service principal (SP) that will provide DMS access to Azure SQL MI. You will grant the SP permissions to the hands-on-lab-SUFFIX resource group.

> **Note**:  
> You must have rights within your Azure AD tenant to create applications and assign roles to complete this task. If you are blocked by this, but still want to do a migration with Azure Database Migration Services, you can perform an offline migration. In Activity 6, select offline instead of online migration in Step 3, and instead of Step 7, you can refer to [this section of a migrating to Azure SQL Database Managed Instance offline tutorial](https://docs.microsoft.com/en-us/azure/dms/tutorial-sql-server-to-managed-instance#specify-target-details).


<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

> **Note**:  
> If you're doing this lab as part of a workshop and were provided an environment to use, this step has already been completed. You can review, but **there is nothing you need to do**. Please refer to instructor guidance.  

1. Next, you will issue a command to create a service principal named **tailspin-toys** and assign it contributor permissions to your *hands-on-lab-SUFFIX* resource group.

2. First, you need to retrieve your subscription ID. Enter the following at the Cloud Shell prompt:

    ```powershell
    az account list --output table
    ```

3. In the *output* table, locate the subscription you are using for this hands-on lab, and copy the *SubscriptionId* value into a text editor for use later.

4. Next, enter the following command at the Cloud Shell prompt, replacing `{SubscriptionID}` with the value you copied above and `{ResourceGroupName}` with the name of your *hands-on-lab-SUFFIX* resource group, and then press `Enter` to run the command:

    ```powershell
    az ad sp create-for-rbac -n "tailspin-toys" --role owner --scopes subscriptions/{SubscriptionID}/resourceGroups/{ResourceGroupName}
    ```

    ![The az ad sp create-for-rbac command is entered into the Cloud Shell, and the output of the command is displayed.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/azure-cli-create-sp.png?raw=true "Azure CLI")

5. Copy the output from the command into a text editor, as you will need the `appId` and `password` in the next task. The output should be similar to:

    ```json
    {
        "appId": "aeab3b83-9080-426c-94a3-4828db8532e9",
        "displayName": "tailspin-toys",
        "name": "http://tailspin-toys",
        "password": "76ff5bae-8d25-469a-a74b-4a33ad868585",
        "tenant": "d280491c-b27a-XXXX-XXXX-XXXXXXXXXXXX"
    }
    ```

6. To verify the role assignment, select **Access control (IAM)** from the left-hand menu of the *hands-on-lab-SUFFIX* resource group blade, and then select the **Role assignments** tab and locate *tailspin-toys* under the *OWNER* role.

    ![The Role assignments tab is displayed, with tailspin-toys highlighted under OWNER in the list.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/rg-hands-on-lab-role-assignments.png?raw=true "Role assignments")

7. Next, you will issue another command to grant the *CONTRIBUTOR* role at the subscription level to the newly created service principal. At the *Cloud Shell* prompt, run the following command:

    ```powershell
    az role assignment create --assignee http://tailspin-toys --role contributor
    ```

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="Activity-6">Activity 6: Create and run an online data migration project </b></p></a>

In this task, you will create a new online data migration project in DMS for the `TailspinToys` database.

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>


1. In the [Azure portal](https://portal.azure.com), navigate to the *Azure Database Migration Service* by selecting **Resource groups** from the left-hand navigation menu, selecting the **hands-on-lab-SUFFIX** resource group, and then selecting the **tailspin-dms** Azure Database Migration Service in the list of resources:

    ![The tailspin-dms Azure Database Migration Service is highlighted in the list of resources in the hands-on-lab-SUFFIX resource group.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/resource-group-dms-resource.png?raw=true "Resources")

2. On the *Azure Database Migration Service* blade, select **+New Migration Project**:

    ![On the Azure Database Migration Service blade, +New Migration Project is highlighted in the toolbar.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dms-add-new-migration-project.png?raw=true "Azure Database Migration Service New Project")

3. On the New migration project blade, enter the following:

    - *Project name*: Enter **OnPremToSqlMi**
    - *Source server type*: Select **SQL Server**
    - *Target server type*: Select **Azure SQL Database Managed Instance**
    - *Choose type of activity*: Select **Online data migration** and select **Save**

    ![The New migration project blade is displayed, with the values specified above entered into the appropriate fields.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dms-new-migration-project-blade.png?raw=true "New migration project")

4. Select **Create and run activity**

5.  On the Migration Wizard **Select source** blade, enter the following:

    - *Source SQL Server instance name*: Enter the IP address of your SqlServer2008 VM that you copied into a text editor in the previous task. For example, **13.66.228.107**  
    > **Note**:  
    > If you're doing this lab as part of a workshop and were provided an environment to use, please refer to instructor guidance to obtain your SQL Server VM's IP address.
    - *User Name*: Enter **WorkshopUser**
    - *Password*: Enter your password
    - *Connection properties**: Check both **Encrypt connection** and **Trust server certificate**

    > **Note**:  
    > The Password should be consistent among all labs. Your instructor will provide the password if you are taking this Lab in person.  

    ![The Migration Wizard Select source blade is displayed, with the values specified above entered into the appropriate fields.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dms-migration-wizard-select-source.png?raw=true "Migration Wizard Select source")

6. Select **Save**

7. On the *Migration Wizard* | *Select target* blade, enter the following:

    - *Application ID*: Enter the `appId` value from the output of the `az ad sp create-for-rbac' command you executed in the last task
    - *Key*: Enter the `password` value from the output of the `az ad sp create-for-rbac' command you executed in the last task
    > **Note**:  
    > If you're doing this lab as part of a workshop and were provided an environment to use, please refer to instructor guidance to obtain your application ID and key.
    <!-- TODO Add guidance on how to do this -->
    - *Subscription*: Select the subscription you are using for this hand-on lab
    - *Target Azure SQL Managed Instance*: Select the **sqlmi-UNIQUEID** instance
    - *SQL Username*: Enter **sqlmiuser**
    - *Password*: Enter your password

    ![The Migration Wizard Select target blade is displayed, with the values specified above entered into the appropriate fields.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dms-migration-wizard-select-target.png?raw=true "Migration Wizard Select target")

8. Select **Save**

9. On the Migration Wizard *Select databases* blade, select **TailspinToys**:

    ![The Migration Wizard Select databases blade is displayed, with the TailspinToys database selected.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dms-migration-wizard-select-databases.png?raw=true "Migration Wizard Select databases")

10. Select **Save**

11. On the *Migration Wizard* | *Configure migration settings* blade, enter the following configuration:

    - *Network share location*: Enter **\\\SQLSERVER2008\dms-backups**. This is the path of the SMB network share you created during the before the hands-on lab exercises
    - *Windows User Azure Database Migration Service impersonates to upload files to Azure Storage*: Enter **SQLSERVER2008\sqlmiuser**
    - *Password*: Enter your password
    - *Subscription containing storage account*: Select the subscription you are using for this hands-on lab
    - *Storage account*: Select the **sqlmistoreUNIQUEID** storage account

    ![The Migration Wizard Configure migration settings blade is displayed, with the values specified above entered into the appropriate fields.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dms-migration-wizard-configure-migration-settings.png?raw=true "Migration Wizard Configure migration settings")

12. Select **Save** on the *Configure migration setting* blade

13. On the Migration Wizard *Summary* blade, enter the following:

    - *Activity name*: Enter **TailspinToysMigration**

    ![The Migration Wizard summary blade is displayed, Sql2008ToSqlDatabase is entered into the name field, and Validate my database(s) is selected in the Choose validation option blade, with all three validation options selected.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dms-migration-wizard-migration-summary.png?raw=true "Migration Wizard Summary")

14. Select **Run migration**

15. Monitor the migration on the status screen that appears. Select the refresh icon in the toolbar to retrieve the latest status:

    ![On the Migration job blade, the Refresh button is highlighted, and a status of Full backup uploading is displayed and highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dms-migration-wizard-status-running.png?raw=true "Migration status")

16. Continue selecting **Refresh** every 5-10 seconds, until you see the status change to **Log files uploading**. When that status appears, move on to the next task:

    ![In the migration monitoring window, a status of Log files uploading is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dms-migration-wizard-status-log-files-uploading.png?raw=true "Migration status")


<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="Activity-7">Activity 7: Perform migration cutover</b></p></a>

Since you performed the migration as an "online data migration," the migration wizard will continue to monitor the SMB network share for newly added log files. This allows for any updates that happen on the source database to be captured until you cut over to the SQL MI database. In this task, you will add a record to one of the database tables, backup the logs, and complete the migration of the `TailspinToys` database by cutting over to the SQL MI database.

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>


1. In the migration status window in the Azure portal and select **TailspinToys** under *database name* to view further details about the database migration:

    ![The TailspinToys database name is highlighted in the migration status window.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dms-migration-wizard-database-name.png?raw=true "Migration status")

2. On the *TailspinToys* screen you will see a status of *Restored* for the `TailspinToys.bak` file:

    ![On the TailspinToys blade, a status of Restored is highlighted next to the TailspinToys.bak file in the list of active backup files.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dms-migration-wizard-database-restored.png?raw=true "Migration Wizard")  

3. To demonstrate log shipping and how transactions made on the source database during the migration process will be added to the target SQL MI database, you will add a record to one of the database tables.

4. Return to *SSMS* on your SqlServer2008 VM and select **New Query** from the toolbar:

    ![The New Query button is highlighted in the SSMS toolbar.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-new-query.png?raw=true "SSMS Toolbar")

5. Paste the following SQL script, which inserts a record into the `Game` table, into the new query window:

    ```sql
    USE TailspinToys;
    GO

    INSERT [dbo].[Game] (Title, Description, Rating, IsOnlineMultiplayer)
    VALUES ('Space Adventure', 'Explore the universe with are newest online multiplayer gaming experience. Build your own rocket ships, and take off for the stars in an infinite open world adventure.', 'T', 1)
    ```

6. Execute the query by selecting **Execute** in the SSMS toolbar:

    ![The Execute button is highlighted in the SSMS toolbar.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-execute.png?raw=true "SSMS Toolbar")

7. With the new record added to the `Games` table, you will now backup the transaction logs, which will be shipped to DMS. Select **New Query** again in the toolbar, and paste the following script into the new query window:

    ```sql
    USE master;
    GO

    BACKUP LOG TailspinToys
    TO DISK = 'c:\dms-backups\TailspinToysLog.trn'
    WITH CHECKSUM
    GO
    ```

8. Execute the query by selecting **Execute** in the SSMS toolbar:

9. Return to the migration status page in the Azure portal. On the TailspinToys screen, select **Refresh** you should see the **TailspinToysLog.trn** file appear, with a status of **Uploaded**:

    ![On the TailspinToys blade, the Refresh button is highlighted. A status of Uploaded is highlighted next to the TailspinToysLog.trn file in the list of active backup files.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dms-migration-wizard-transaction-log-uploaded.png?raw=true "Migration Wizard")

    >**Note**: If you don't see it the transaction logs entry, continue selecting Refresh every few seconds until it appears.

10. Once the transaction logs are uploaded, they need to be restored to the database. Select **Refresh** every 10-15 seconds until you see the status change to *Restored*, which can take a minute or two:

    ![A status of Restored is highlighted next to the TailspinToysLog.trn file in the list of active backup files.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dms-migration-wizard-transaction-log-restored.png?raw=true "Migration Wizard")

11. After verifying the transaction log status of *Restored*, select **Start Cutover**:

    ![The Start Cutover button is displayed.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dms-migration-wizard-start-cutover.png?raw=true "DMS Migration Wizard")

12. On the *Complete cutover* dialog, verify *pending log backups* is `0`, check **Confirm**, and select **Apply**:

    ![In the Complete cutover dialog, a value of 0 is highlighted next to Pending log backups and the Confirm checkbox is checked.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dms-migration-wizard-complete-cutover-apply.png?raw=true "Migration Wizard")

13. You will be given a progress bar below the *Apply* button in the *Complete cutover* dialog. When the migration is complete, you will see the status as *Completed*:

    ![A status of Completed is displayed in the Complete cutover dialog.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dms-migration-wizard-complete-cutover-completed.png?raw=true "Migration Wizard")  

    > **Note**:  
    > This will take between 10-30 minutes, so it might be a good time to take a break, or to review what you've done so far. Sometimes the progress is delayed, you can select **Refresh** to update manually.  

14. Close the *Complete cutover* dialog by selecting the **X** in the upper right corner of the dialog, and do the same thing for the *TailspinToys* blade. This will return you to the *TailspinToysMigration* blade. Select **Refresh**, and you should see a status of *Completed* from the *TailspinToys* database.

    ![On the Migration job blade, the status of Completed is highlighted](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dms-migration-wizard-status-complete.png?raw=true "Migration with Completed status")

15. You have now successfully migrated the `TailspinToys` database to Azure SQL Managed Instance.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="Activity-8">Activity 8: Verify database and transaction log migration</b></p></a>

In this task, you will connect to the SQL MI database using SSMS, and quickly verify the migration.

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>


1. Return to *SSMS* on your SqlServer2008 VM, and then select **Connect** and **Database Engine** from the *Object Explorer* menu:

    ![In the SSMS Object Explorer, Connect is highlighted in the menu and Database Engine is highlighted in the Connect context menu.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-object-explorer-connect.png?raw=true "SSMS Connect")

2. In the *Connect to Server* dialog, enter the following:

    - *Server name*: Enter the fully qualified domain name of your SQL managed instance, which you copied from the Azure Cloud Shell in a previous task
    - *Authentication*: Select **SQL Server Authentication**
    - *Login*: Enter **sqlmiuser**
    - *Password*: Enter your password
    - Check the **Remember password** box

    ![The SQL managed instance details specified above are entered into the Connect to Server dialog.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-connect-to-server-sql-mi.png?raw=true "Connect to Server")

3. Select **Connect**

4. You will see you SQL MI connection appear below the SQLSERVER2008 connection. Expand *Databases* in the SQL MI connection and select the `TailspinToys` database:

    ![In the SSMS Object Explorer, the SQL MI connection is expanded and the TailspinToys database is highlighted and selected.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-sql-mi-tailspintoys-database.png?raw=true "SSMS Object Explorer")

5. With the `TailspinToys` database selected, select **New Query** on the SSMS toolbar to open a new query window.

6. In the new query window, enter the following SQL script:

    ```sql
    SELECT * FROM Game
    ```

7. Select **Execute** on the SSMS toolbar to run the query. You will see the records contained in the `Game` table displayed, including the new `Space Adventure` you added after initiating the migration process:

    ![In the new query window, the query above has been entered, and in the results pane, the new Space Adventure game is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-query-game-table.png?raw=true "SSMS Query")

8. You are now done using the SqlServer2008 VM. Close any open windows and log off of the VM. You will use the "JumpBox" VM for the remaining tasks of this hands-on-lab.


<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="Activity-9">Activity 9: Update the application</b></p></a>


With the `TailspinToys` database now running on SQL MI in Azure, the next step is to make the required modifications to the TailspinToys gamer information web application.

>**Note**: SQL Managed Instance has a private IP address in its own VNet, so to connect an application you need to configure access to the VNet where Managed Instance is deployed. To learn more, read [Connect your application to Azure SQL Database Managed Instance](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance-connect-app).

>**Note**: Due to time constraints, the lab will deal with switching the app running on a Jumpbox VM locally from leveraging data in SQL Server 2008 to SQL MI (but not the deployment to Azure or integrating the App Service with the Virtual Network). In the [extended version of these labs](https://github.com/microsoft/MCW-Migrating-SQL-databases-to-Azure/blob/master/Hands-on%20lab/HOL%20step-by-step%20-%20Migrating%20SQL%20databases%20to%20Azure.md#exercise-3-update-the-web-application-to-use-the-new-sql-mi-database), or if you have time at the end of the lab, you can do that.  


In this activity, you will create an RDP connection to the JumpBox VM, and then using Visual Studio on the JumpBox, run the `TailspinToysWeb` application on the VM.  

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>


1. In the [Azure portal](https://portal.azure.com), select **Resource groups** in the *Azure navigation pane*, and select the **hands-on-lab-SUFFIX** resource group from the list:

    ![Resource groups is selected in the Azure navigation pane and the "hands-on-lab-SUFFIX" resource group is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/resource-groups.png?raw=true "Resource groups list")

2. In the list of resources for your resource group, select the JumpBox VM:

    ![The list of resources in the hands-on-lab-SUFFIX resource group are displayed, and JumpBox is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/resource-group-resources-jumpbox.png?raw=true "JumpBox in resource group list")

3. On your JumpBox VM blade, select **Connect** from the top menu:

    ![The JumpBox VM blade is displayed, with the Connect button highlighted in the top menu.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/connect-jumpbox.png?raw=true "Connect to JumpBox VM")

4. On the *Connect to virtual machine* blade, select **Download RDP File**, then open the downloaded RDP file:

    ![The Connect to virtual machine blade is displayed, and the Download RDP File button is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/connect-to-virtual-machine.png?raw=true "Connect to virtual machine")

5. Select **Connect** on the *Remote Desktop Connection* dialog:

    ![In the Remote Desktop Connection Dialog Box, the Connect button is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/remote-desktop-connection.png?raw=true "Remote Desktop Connection dialog")

6. Enter the following credentials when prompted, and then select **OK**:

    - *Username*: **sqlmiuser**

    ![The credentials specified above are entered into the Enter your credentials dialog.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/rdc-credentials.png?raw=true "Enter your credentials")

7. Select **Yes** to connect, if prompted that the identity of the remote computer cannot be verified:

    ![In the Remote Desktop Connection dialog box, a warning states that the identity of the remote computer cannot be verified, and asks if you want to continue anyway. At the bottom, the Yes button is circled.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/remote-desktop-connection-identity-verification-jumpbox.png?raw=true "Remote Desktop Connection dialog")

8. Once logged in, the repository containing all of these files can be cloned to `C:/users/`[username]`/sqlworkshops/SQLGroundtoCloud` by opening the command prompt and running the following command:

```cmd
git clone https://github.com/microsoft/sqlworkshops.git
```

> **Note**:  
> If you're doing this lab as part of a workshop and were provided an environment to use, or you have already cloned the repository earlier in the workshop, you do not need to clone the workshop again.

9. Open the `C:/users/`[username]`/sqlworkshops/SQLGroundtoCloud` folder. In the `lab-files` folder, double-click `TailspinToysWeb.sln` to open the solution in Visual Studio:

    ![The folder at the path specified above is displayed, and TailspinToys.sln is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/windows-explorer-tailspintoysweb.png?raw=true "Windows Explorer")

10. If prompted about how you want to open the file, select **Visual Studio 2019** and then select **OK**:

    ![In the Visual Studio version selector, Visual Studio 2019 is selected and highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/visual-studio-version-selector.png?raw=true "Visual Studio")

11. Select **Sign in** and enter your Azure account credentials when prompted:

> **Note**:  
> If you're doing this lab as part of a workshop and were provided an environment to use, please use the Azure account credentials provided to you.

![On the Visual Studio welcome screen, the Sign in button is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/visual-studio-sign-in.png?raw=true) 

12. At the security warning prompt, uncheck Ask me for every project in this solution, and then select **OK**:

    ![A Visual Studio security warning is displayed, and the Ask me for every project in this solution checkbox is unchecked and highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/visual-studio-security-warning.png?raw=true "Visual Studio")


13. Open `appsettings.json` and enter your SQL 2008 VM information and password in the Connection strings section:

```c
"ConnectionStrings": {
    "TailspinToysContext": "Server=tcp:<your-sql-2008-vm-ip>,1433;Database=TailspinToys;User ID=Workshopuser;Password=<your-password>;Trusted_Connection=False;Encrypt=True;TrustServerCertificate=True;",
    "TailspinToysReadOnlyContext": "Server=tcp:<your-sql-2008-vm-ip>,1433;Database=TailspinToys;User ID=WorkshopUser;Password=<your-password>;Trusted_Connection=False;Encrypt=True;TrustServerCertificate=True;"
  }
```

14. Save the file: 
 
![Save the Visual Studio web application after adding the keys](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/vs-save-file.png?raw=true "Visual Studio")

15. Run the application (IIS Express button):

![Run the Visual Studio web application locally](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/vs-run-app.png?raw=true "Visual Studio")

16. You should now see the app running locally and view the site and it's data which is accessing the on-prem data (Select `Leaderboard`):

![View the homepage of the Tailspin Toys application running locally](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/web-app-home.png?raw=true "Tailspin Toys")

![View the leaderboard of the Tailspin Toys application running locally](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/web-app-leaderboard.png?raw=true "Tailspin Toys")

17. Stop the application by closing the browser.  

18. Now, in order to have the app run with the data in SQL MI, update `appsettings.json` by replacing the SQL 2008 VM IP with the fully qualified domain name for your MI (something like `sqlmi.fdsor39943LabExercise-234j3oj4.database.windows.net`). Then, replace `WorkshopUser` with `sqlmiuser`.   

19. Save the file:

![Save the Visual Studio web application after adding the keys](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/vs-save-file.png?raw=true "Visual Studio")

20. Run the application (IIS Express button):

![Run the Visual Studio web application locally](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/vs-run-app.png?raw=true "Visual Studio")

21. You should see the same results as before, but this time, the data is coming from your SQL MI in Azure:  
![View the homepage of the Tailspin Toys application running locally](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/web-app-home.png?raw=true "Tailspin Toys")  

![View the leaderboard of the Tailspin Toys application running locally](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/web-app-leaderboard.png?raw=true "Tailspin Toys")  

> **Note**: If you want to complete an extension of this lab where you deploy the web app to Azure and integrate the App Service within the virtual network using point-to-site and VNet integration, see exercises 3 and 4 in the non-abbreviated lab [here](https://github.com/microsoft/MCW-Migrating-SQL-databases-to-Azure/blob/master/Hands-on%20lab/HOL%20step-by-step%20-%20Migrating%20SQL%20databases%20to%20Azure.md).


<br>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><a name="LabExercise-2">Lab Exercise 2: Improve database security with Advanced Data Security</h2></a>

[Advanced Data Security](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-advanced-data-security) is a unified package for advanced SQL security capabilities. It includes functionality for discovering and classifying sensitive data, surfacing and mitigating potential database vulnerabilities, and detecting anomalous activities that could indicate a threat to your database. It provides a single go-to location for enabling and managing these capabilities.  

In this exercise, you'll enable Advanced Data Security, configure Data Discovery and Classification, and review the Vulnerability Assessment. At the end, you'll also receive a pointer to a Dynamic Data Masking lab extension.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="Activity-2-1">Activity 1: Enable Advanced Data Security</b></p></a>

In this task, you will enable Advanced Data Security (ADS) for all databases on the Managed Instance.

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>


1. In the [Azure portal](https://portal.azure.com), select **Resource groups** from the left-hand menu, select the **hands-on-lab-SUFFIX** resource group, and then select the **TailspinToys** Managed database resource from the list:

    ![The TailspinToys Managed Database is highlighted in the resources list.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/resources-sql-mi-database.png?raw=true "Resources")

2. On the *TailspinToys Managed database* blade, select **Advanced Data Security** from the left-hand menu, under Security, and then select **Enable Advanced Data Security on the managed instance**:

    ![In the Advanced Data Security blade of the Managed database, the Enable Advanced Data Security on the managed instance button is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/managed-database-ads.png?raw=true "Advanced Data Security")

3. Within a few minutes, ADS will be enabled for all databases on the Managed Instance. You will see the three tiles on the *Advanced Data Security* blade become enabled when it has been enabled:

    ![The enabled tiles on the Advance Data Security blade are displayed.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ads-panels.png?raw=true "Advanced Data Security")


<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="Activity-2-2">Activity 2: Configure SQL Data Discovery and Classification</b></p></a>

In this task, you will look at the [SQL Data Discovery and Classification](https://docs.microsoft.com/sql/relational-databases/security/sql-data-discovery-and-classification?view=sql-server-2017) feature of Advanced Data Security. Data Discovery and Classification introduces a new tool for discovering, classifying, labeling & reporting the sensitive data in your databases. It introduces a set of advanced services, forming a new SQL Information Protection paradigm aimed at protecting the data in your database, not just the database. Discovering and classifying your most sensitive data (business, financial, healthcare, etc.) can play a pivotal role in your organizational information protection stature.

> **Note**: This functionality is currently available *in Preview* for SQL MI through the Azure portal.

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>


1. On the *Advanced Data Security* blade, select the **Data Discovery & Classification** tile:

    ![The Data Discovery & Classification tile is displayed.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ads-data-discovery-and-classification-pane.png?raw=true "Advanced Data Security")

2. In the *Data Discovery & Classification* blade, select the **info link** with the message *We have found 40 columns with classification recommendations*:

    ![The recommendations link on the Data Discovery & Classification blade is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ads-data-discovery-and-classification-recommendations-link.png?raw=true "Data Discovery & Classification")

3. Look over the list of recommendations to get a better understanding of the types of data and classifications are assigned, based on the built-in classification settings. In the list of *classification recommendations*, select the recommendation for the **Sales - CreditCard - CardNumber** field:

    ![The CreditCard number recommendation is highlighted in the recommendations list.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ads-data-discovery-and-classification-recommendations-credit-card.png?raw=true "Data Discovery & Classification")

4. Due to the risk of exposing credit card information, Tailspin Toys would like a way to classify it as *highly confidential*, not just *Confidential*, as the recommendation suggests. To correct this, select **+ Add classification** at the top of the *Data Discovery and Classification* blade:

    ![The +Add classification button is highlighted in the toolbar.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ads-data-discovery-and-classification-add-classification-button.png?raw=true "Data Discovery & Classification")

5. Expand the **Sensitivity label** field, and review the various built-in labels you can choose from. You can also add your own labels, should you desire:

    ![The list of built-in Sensitivity labels is displayed.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ads-data-discovery-and-classification-sensitivity-labels.png?raw=true "Data Discovery & Classification")

6. In the *Add classification* dialog, enter the following:

    - *Schema name*: Select **Sales**
    - *Table name*: Select **CreditCard**
    - *Column name*: Select **CardNumber (nvarchar)**
    - *Information type*: Select **Credit Card**
    - *Sensitivity level*: Select **Highly Confidential**

    ![The values specified above are entered into the Add classification dialog.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ads-data-discovery-and-classification-add-classification.png?raw=true "Add classification")

7. Select **Add classification**

8. You will see the *Sales - CreditCard - CardNumber* field disappear from the recommendations list, and the number of recommendations drop by 1

9. Other recommendations you can review are the *HumanResources - Employee* fields for *NationalIDNumber* and *BirthDate*. Note that these have been flagged by the recommendation service as *Confidential - GDPR*. As Tailspin Toys maintains data about gamers from around the world, including Europe, having a tool which helps them discover data which may be relevant to GDPR compliance will be very helpful:

    ![GDPR information is highlighted in the list of recommendations](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ads-data-discovery-and-classification-recommendations-gdpr.png?raw=true "Data Discovery & Classification")

10. Check the **Select all** check box at the top of the list to select all the remaining recommended classifications, and then select **Accept selected recommendations**:

    ![All the recommended classifications are checked and the Accept selected recommendations button is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ads-data-discovery-and-classification-accept-recommendations.png?raw=true "Data Discovery & Classification")

11. Select **Save** on the toolbar of the Data Classification window. It may take several minutes for the save to complete:

    ![Save the updates to the classified columns list.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ads-data-discovery-and-classification-save.png?raw=true "Save")
    
    >**Note**: This feature is still in preview.  If you receive an error when saving, try returning to the Advanced Data Security blade, and selecting the Data Discovery & Classification tile again to see the results.

12. When the save completes, select the **Overview** tab on the *Data Discovery and Classification* blade to view a report with a full summary of the database classification state:

    ![The View Report button is highlighted on the toolbar.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ads-data-discovery-and-classification-overview-report.png?raw=true "View report")


<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="Activity-2-3">Activity 3: Review Advanced Data Security Vulnerability Assessment</b></p></a>

In this task, you will review an assessment report generated by ADS for the `TailspinToys` database and take action to remediate one of the findings in the `TailspinToys` database. The [SQL Vulnerability Assessment service](https://docs.microsoft.com/azure/sql-database/sql-vulnerability-assessment) is a service that provides visibility into your security state, and includes actionable steps to resolve security issues, and enhance your database security.

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

1. Return to the **Advanced Data Security** blade for the `TailspinToys` Managed database and then select the **Vulnerability Assessment** tile:

    ![The Vulnerability tile is displayed.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ads-vulnerability-assessment-tile.png?raw=true "Advanced Data Security")

2. On the *Vulnerability Assessment* blade, select **Scan** on the toolbar:

    ![Vulnerability assessment scan button.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/vulnerability-assessment-scan.png?raw=true "Scan")

3. When the scan completes, you will see a dashboard, displaying the number of failing checks, passing checks, and a breakdown of the risk summary by severity level:

    ![The Vulnerability Assessment dashboard is displayed.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/sql-mi-vulnerability-assessment-dashboard.png?raw=true "Vulnerability Assessment dashboard")

    >**Note**: Scans are run on a schedule, so if you see a message that no vulnerabilities are found your database may not have been scanned yet. You will need to run a scan manually. To do this, select the **Scan** button on the toolbar, and follow any prompts to start a scan. This will take a minute or so to complete.

4. In the scan results, take a few minutes to browse both the *Failed* and *Passed* checks, and review the types of checks that are performed. In the *Failed* list, locate the security check for *Transparent data encryption*. This check has an ID of *VA1219*:

    ![The VA1219 finding for Transparent data encryption is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/sql-mi-vulnerability-assessment-failed-va1219.png?raw=true "Vulnerability assessment")

5. Select the **VA1219** finding to view the detailed description:

    ![The details of the VA1219 - Transparent data encryption should be enabled finding are displayed with the description, impact, and remediation fields highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/sql-mi-vulnerability-assessment-failed-va1219-details.png?raw=true "Vulnerability Assessment")

The details for each finding provide more insight into the reason. Note the fields describing the finding, the impact of the recommended settings, and details on remediation for the finding.

6. You will now act on the recommendation remediation steps for the finding, and enable [Transparent Data Encryption](https://docs.microsoft.com/azure/sql-database/transparent-data-encryption-azure-sql) for the `TailspinToys` database. To accomplish this, you will switch over to using SSMS on your JumpBox VM for the next few steps.

    >**Note**:  
    > Transparent data encryption (TDE) needs to be manually enabled for Azure SQL Managed Instance. TDE helps protect Azure SQL Database, Azure SQL Managed Instance, and Azure Data Warehouse against the threat of malicious activity. It performs real-time encryption and decryption of the database, associated backups, and transaction log files at rest without requiring changes to the application.

7. On your JumpBox VM, open Microsoft SQL Server Management Studio 18 from the Start menu, and enter the following information in the *Connect to Server* dialog.

    - *Server name*: Enter the fully qualified domain name of your SQL managed instance, which you copied from the Azure Cloud Shell in a previous task
    - *Authentication*: Select **SQL Server Authentication**
    - *Login*: Enter **sqlmiuser**
    - *Password*: Enter your password
    - Check the **Remember password** box

    ![The SQL managed instance details specified above are entered into the Connect to Server dialog.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-18-connect-to-server.png?raw=true "Connect to Server")

8. In SSMS, select **New Query** from the toolbar, paste the following SQL script into the new query window:

    ```sql
    ALTER DATABASE [TailspinToys] SET ENCRYPTION ON
    ```

    ![A new query window is displayed, with the script above pasted into it.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-sql-mi-enable-tde.png?raw=true "New query")

    > You turn transparent data encryption on and off on the database level. To enable transparent data encryption on a database in Azure SQL Managed Instance use must use T-SQL.

9. Select **Execute** from the SSMS toolbar. After a few seconds, you will see a message that the "Commands completed successfully":

    ![The Execute button is highlighted on the SSMS toolbar, and the Commands completed successfully message is highlighted in the output window.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-sql-mi-enable-tde-success.png?raw=true "Execute")

10. You can verify the encryption state and view information the associated encryption keys by using the [sys.dm_database_encryption_keys view](https://docs.microsoft.com/sql/relational-databases/system-dynamic-management-views/sys-dm-database-encryption-keys-transact-sql). Select **New Query** on the SSMS toolbar again, and paste the following query into the new query window:

    ```sql
    SELECT * FROM sys.dm_database_encryption_keys
    ```

    ![The query above is pasted into a new query window in SSMS.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-sql-mi-database-encryption-keys.png?raw=true "New query")

11. Select **Execute** from the SSMS toolbar. You will see two records in the Results window, which provide information about the encryption state and keys used for encryption:

    ![The Execute button on the SSMS toolbar is highlighted, and in the Results pane the two records about the encryption state and keys for the TailspinToys database are highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-sql-mi-database-encryption-keys-results.png?raw=true "Results")

By default, service-managed transparent data encryption is used. A transparent data encryption certificate is automatically generated for the server that contains the database.

12. Return to the *Azure portal* and the *Advanced Data Security - Vulnerability Assessment* blade of the `TailspinToys` managed database. On the toolbar, select **Scan** to start a new assessment of the database:

    ![Vulnerability assessment scan button.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/vulnerability-assessment-scan.png?raw=true "Scan")

13. When the scan completes, select the **Failed** tab, enter **VA1219** into the search filter box, and observe that the previous failure is no longer in the Failed list:

    ![The Failed tab is highlighted and VA1219 is entered into the search filter. The list displays no results.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/sql-mi-vulnerability-assessment-failed-filter-va1219.png?raw=true "Failed")

14. Now, select the **Passed** tab, and observe the **VA1219** check is listed with a status of *PASS*:

    ![The Passed tab is highlighted and VA1219 is entered into the search filter. VA1219 with a status of PASS is highlighted in the results.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/sql-mi-vulnerability-assessment-passed-va1219.png?raw=true "Passed")

Using the SQL Vulnerability Assessment, it is simple to identify and remediate potential database vulnerabilities, allowing you to proactively improve your database security.


> **Note**: If you want to complete an extension of this lab where you  also explore the capabilities of [Dynamic Data Masking](https://docs.microsoft.com/en-us/sql/relational-databases/security/dynamic-data-masking?view=sql-server-2017), see exercise 6 and 4 in the non-abbreviated lab [here](https://github.com/microsoft/MCW-Migrating-SQL-databases-to-Azure/blob/master/Hands-on%20lab/HOL%20step-by-step%20-%20Migrating%20SQL%20databases%20to%20Azure.md).

<br>
<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><a name="LabExercise-3">Lab Exercise 3: Use an online secondary for read-only queries </h2></a>

In this exercise, you will look at how you can use the automatically created online secondary for reporting, without feeling the impacts of a heavy transactional load on the primary database. Each database in the SQL MI Business Critical tier is automatically provisioned with several AlwaysON replicas to support the availability SLA. Using [**Read Scale-Out**](https://docs.microsoft.com/azure/sql-database/sql-database-read-scale-out) allows you to load balance Azure SQL Database read-only workloads using the capacity of one read-only replica.

<br>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="Activity-3-1">Activity 1: View Leaderboard report in Tailspin Toys web application</b></p></a>

In this task, you will open a web report using the web application you deployed to your App Service.

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

1. Return to your JumpBox VM, and run the web application:  
![Run the Visual Studio web application locally](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/vs-run-app.png?raw=true "Visual Studio")  


4. In the *TailspinToys web app*, select **Leaderboard** from the menu:

   ![READ_WRITE is highlighted on the Leaderboard page.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/tailspin-toys-leaderboard-read-write.png?raw=true "TailspinToys Web App")

   > Note the `READ_WRITE` string on the page. This is the output from reading the `Updateability` property associated with the `ApplicationIntent` option on the target database. This can be retrieved using the SQL query `SELECT DATABASEPROPERTYEX(DB_NAME(), "Updateability")`.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="Activity-3-2">Activity 2: Update read only connection string</b></p></a>

In this task, you will enable Read Scale-Out for the `TailspinToys` database, using the `ApplicationIntent` option in the connection string. This option dictates whether the connection is routed to the write replica or to a read-only replica. Specifically, if the `ApplicationIntent` value is `ReadWrite` (the default value), the connection will be directed to the database’s read-write replica. If the `ApplicationIntent` value is `ReadOnly`, the connection is routed to a read-only replica.
<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

1. Stop the application by closing the browser
 
2. In order to have the app connect to the read-only replica, open `appsettings.json`. In the `TailspinToysReadOnlyContext` line, paste the following parameter to end the line:

   ```sql
   ApplicationIntent=ReadOnly;
   ```  
4. The `TailspinToysReadOnlyContext` connection string should now look something like the following:

   ```sql
   Server=tcp:sqlmi-abcmxwzksiqoo.15b8611394cLabExercise-database.windows.net,1433;Database=TailspinToys;User ID=sqlmiuser;Password=<your-password>;Trusted_Connection=False;Encrypt=True;TrustServerCertificate=True;ApplicationIntent=ReadOnly;
   ```  


<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="Activity-3-3">Activity 3: Reload leaderboard report in the Tailspin Toys web application</b></p></a>

In this task, you will refresh the Leaderboard report in the Tailspin Toys web app, and observe the results.

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

3. Save the `appsettings.json` file in Visual Studio:
  
![Save the Visual Studio web application after adding the keys](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/vs-save-file.png?raw=true "Visual Studio")

4. Run the application (IIS Express button):

![Run the Visual Studio web application locally](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/vs-run-app.png?raw=true "Visual Studio")  

5. Return to the TailspinToys gamer information website you opened previously, on the **Leaderboard** page. The page should now look similar to the following:

    ![READ_ONLY is highlighted on the Reports page.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/tailspin-toys-leaderboard-read-only.png?raw=true "TailspinToys Web App")

    > Notice the `updateability` option is now displaying as `READ_ONLY`. With a simple addition to your database connection string, you are able to send read-only queries to the online secondary of your SQL MI Business critical database, allowing you to load-balance read-only workloads using the capacity of one read-only replica. The SQL MI Business Critical cluster has built-in Read Scale-Out capability that provides free-of charge built-in read-only node that can be used to run read-only queries that should not affect performance of your primary workload.


> **Note**:  
> If you are attending this lab as part of a day-long workshop, you have finished the activities for Module 5. [Return to it here](https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/05-MigratingToAzureSQL.md#54-after-the-migration), review, and refer to instructor guidance.

<br>
<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><a name="LabExercise-4">Lab Exercise 4: After the Migration</a></h2>

In this Lab, you used the [Azure Database Migration Service](https://azure.microsoft.com/services/database-migration/) (DMS) to migrate the `TailspinToys` database from the on-premises SQL 2008 R2 database to SQL MI. You then updated the web application to use the SQL MI created, and enabled [advanced security features](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-advanced-data-security). Finally, you set up your application to leverage the [online secondary replica](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-read-scale-out) to handle heavy read workloads.  

Now that Tailspin Toys has completed a migration for their gaming database. They'll want to leverage the [post-migration validation and optimization guide](https://docs.microsoft.com/en-us/sql/relational-databases/post-migration-validation-and-optimization-guide?view=sql-server-2017) to ensure data completeness and uncover and resolve performance issues.  

If and when Tailspin Toys chooses to scale their migration to other instances and databases, they can leverage the same process you've seen in Labs 4 and 5, but should also refer to the guidance Microsoft provides on [scaling a migration to Azure](https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/migrate/azure-best-practices/contoso-migration-scale). 

<br>

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/owl.png?raw=true"><b>For Further Study</b></p>
<ul>
    <li><a href="https://www.microsoft.com/handsonlabs" target="_blank">Microsoft Hands On Labs</a> offers free self-paced lab environments as well as a request form for instructor led lab environments. As of last update, there are about eight labs available around Azure SQL (assessment, migration, app innovation, row level security, managed instance, and more).</li>
    <li><a href="https://www.microsoft.com/handsondemos" target="_blank">Microsoft Hands On Demos</a> is similar to Hands On Labs, but offers easy to set up demos that are free for certain internals and partners. As of last update, there are about seven demos available around Azure SQL.</li>
    <li><a href="https://datamigration.microsoft.com/
    " target="_blank">Azure Database Migration Guide</a> contains lots of resources that will help in guiding and supporting database migrations to Azure.</li>
    <li><a href="https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/migrate/azure-best-practices/contoso-migration-overview
    " target="_blank">The Azure Architecture Documentation</a> contains many migration patterns as well as full code samples, scenarios, and guidance about how to migrate on-prem estates. There are useful, detailed scenarios about rehosting to SQL MI and SQL VMs, as well as guidance of how to scale a migration, after you've done a PoC.</li>
    <li><a href="https://github.com/microsoft/MCW-Migrating-SQL-databases-to-Azure
    " target="_blank">MCW: Migrating SQL Databases to Azure</a> contains extended labs from what you've seen in these exercises. There is an opportunity to see how the networking was configured, and deeper dives around the network and setup. </li>
    <li><a href="https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/migrate/azure-best-practices/contoso-migration-infrastructure
    " target="_blank">How to Deploy an Azure Infrastructure</a> and <a href="(https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/migrate/azure-best-practices/migrate-best-practices-networking
    " target="_blank">Best Practices for setting up networking</a> are also two very useful resources when moving to Azure.</li>
    <li><a href="https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/migrate/azure-best-practices/migrate-best-practices-costs
    " target="_blank">Best practices for costing and sizing workloads migrated to Azure</a></li>
    <li><a href="https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/migrate/azure-best-practices/migrate-best-practices-security-management
    " target="_blank">Best practices for securing and managing workloads migrated to Azure</a></li>

</ul>

