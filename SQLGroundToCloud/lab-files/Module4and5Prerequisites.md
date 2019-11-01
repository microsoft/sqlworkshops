

# SQL Ground to Cloud 

## Prerequisites for Modules 4 and 5 Labs

**Contents**

<!-- TOC -->

- [Migrating SQL databases to Azure before the hands-on lab setup guide](#migrating-sql-databases-to-azure-before-the-hands-on-lab-setup-guide)
  - [Requirements](#requirements)
  - [Before the hands-on lab](#before-the-hands-on-lab)
    - [Task 1: Provision a resource group](#task-1-provision-a-resource-group)
    - [Task 2: Register the Microsoft DataMigration resource provider](#task-2-register-the-microsoft-datamigration-resource-provider)
    - [Task 3: Run ARM template to provision lab resources](#task-3-run-arm-template-to-provision-lab-resources)

<!-- /TOC -->
## Requirements

1. Microsoft Azure subscription must be pay-as-you-go or MSDN.
   - Trial subscriptions will *not* work.
   - Rights to create an Azure Active Directory application and service principal and assign roles on your subscription.

## Before the hands-on lab

Duration: 30 minutes

In this exercise, you will set up your environment for use in the rest of the hands-on lab. You should follow all steps provided *before* attending the Hands-on lab.

> **IMPORTANT**: Many Azure resources require unique names. Throughout these steps you will see the word "SUFFIX" as part of resource names. You should replace this with your Microsoft alias, initials, or another value to ensure resources are uniquely named.

### Task 1: Provision a resource group

In this task, you will create an Azure resource group which will serve as a container for the resources used throughout this lab.

1. In the [Azure portal](https://portal.azure.com), select **Resource groups**, select **+Add**, then enter the following in the Create an empty resource group blade:

    - **Subscription**: Select the subscription you are using for this hands-on lab.
    - **Resource group**: Enter hands-on-lab-SUFFIX.
    - **Region**: Select the region you would like to use for resources in this hands-on lab. Remember this location so you can use it for the other resources you'll provision throughout this lab.

    ![Add Resource group Resource groups is highlighted in the navigation pane of the Azure portal, +Add is highlighted in the Resource groups blade, and "hands-on-labs" is entered into the Resource group name box on the Create an empty resource group blade.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/create-resource-group.png?raw=true "Create resource group")

2. Select **Review + Create**.

3. On the Review + Create tab, select **Create** to provision the resource group.

### Task 2: Register the Microsoft DataMigration resource provider

In this task, you will register the `Microsoft.DataMigration` resource provider with your subscription in Azure.

1. In the [Azure portal](https://portal.azure.com), select **All services** from the Azure navigation pane, and then select **Subscriptions**.

    ![All services is highlighted in the Azure navigation pane, and Subscriptions is highlighted in the All services blade.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/azure-portal-all-services-subscriptions.png?raw=true  "Azure All services blade")

2. Select the subscription you are using for this hands-on lab from the list, select **Resource providers**, enter "migration" into the filter box, and then select **Register** next to **Microsoft.DataMigration**.

    ![The Subscription blade is displayed, with Resource providers selected and highlighted under Settings. On the Resource providers blade, migration is entered into the filter box, and Register is highlighted next to Microsoft.DataMigration.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/azure-portal-subscriptions-resource-providers-register-microsoft-datamigration.png?raw=true   "Resource provider registration")

3. It can take a couple of minutes for the registration to complete. Make sure you see a status of **Registered** before moving on.

    ![Registered is highlighted next to the Microsoft.DataMigration resource provider.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/resource-providers-datamigration-registered.png?raw=true  "Microsoft DataMigration Resource Provider")

### Task 3: Run ARM template to provision lab resources

In this task, you will run an Azure Resource Manager (ARM) template to deploy the resources required for this hands-on lab. The components will be deployed inside a new virtual network (VNet) to facilitate communication between the VMs and SQL MI. The ARM template also adds inbound and outbound security rules to the network security groups associated with SQL MI and the VMs, including opening port 3389 to allow RDP connections to the JumpBox. In addition to the provisioning of resources, the ARM template will also execute PowerShell scripts on each of the VMs to install software and configure the servers. The resources created by the ARM template include:

- A virtual network with three subnets, ManagedInstance, Management, and a Gateway subnet
- A virtual network gateway, associated with the Gateway subnet
- A route table
- Azure SQL Database Managed Instance (SQL MI), added to the ManagedInstance subnet
- A JumpBox with Visual Studio 2019 Community edition and SQL Server Management Studio (SSMS installed, added to the Management subnet)
- A SQL Server 2008 R2 VM with the Data Migration Assistant (DMA) installed, added to the Management subnet
- Azure Database Migration Service (DMS)
- Azure App Service Plan and App Service (Web App)
- Azure Blob Storage account

>**Note**: You can review the steps to manually provision the lab resources in [Appendix A](https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/lab-files/Appendix-A.md).

1. Before running the ARM template, it is beneficial to quickly verify that you will be able to provision SQL MI in your subscription. In the [Azure portal](https://portal.azure.com), select **+Create a resource**, enter "sql managed instance" into the Search the Marketplace box, and then select **Azure SQL Managed Instance** from the results.

    ![+Create a resource is selected in the Azure navigation pane, and "sql managed instance" is entered into the Search the Marketplace box. Azure SQL Managed Instance is selected in the results.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/create-resource-sql-mi.png?raw=true   "Create SQL Managed Instance")

2. Select **Create** on the Azure SQL Managed Instance blade.

    ![The Create button is highlighted on the Azure SQL Managed Instance blade.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/sql-mi-create.png?raw=true   "Create Azure SQL Managed Instance")

3. On the SQL managed instance blade, look for a message stating that "Managed instance creation is not available for the chosen subscription type...", which will be displayed near the bottom of the SQL managed instance blade.

    ![A message is displayed stating that SQL MI creation not available in the selected subscription.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/sql-mi-creation-not-available.png?raw=true   "SQL MI creation not available")

    > **Note**: If you see the message stating that Managed Instance creation is not available for the chosen subscription type, follow the instructions for [obtaining a larger quota for SQL Managed Instance](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-managed-instance-resource-limits#obtaining-a-larger-quota-for-sql-managed-instance) before proceeding with the following steps.

4. You are now ready to begin the ARM template deployment. To open a custom deployment screen in the Azure portal, select the Deploy to Azure button below:

    <a href ="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmicrosoft%2FMigrating-SQL-databases-to-Azure%2Fmaster%2FHands-on%20lab%2Flab-files%2FARM-template%2Fazure-deploy.json" target="_blank" title="Deploy to Azure">
    <img src="http://azuredeploy.net/deploybutton.png"/>
    </a>

5. On the custom deployment screen in the Azure portal, enter the following:

    - **Subscription**: Select the subscription you are using for this hands-on lab.
    - **Resource group**: Select the hands-on-lab-SUFFIX resource group from the dropdown list.
    - **Location**: Select the location you used for the hands-on-lab-SUFFIX resource group.
    - **Managed Instance Name**: Accept the default value, **sqlmi**. **Note**: The actual name must be globally unique, so a unique string will be generated from your Resource Group and appended to the name during provisioning.
    - **Admin Username**: Accept the default value, **sqlmiuser**.
    - **Admin Password**: Accept the default value or create a unique password.
    > Note: You should note this password, it will be the password for everything in Modules 4 and 5 of the lab.
    - **V Cores**: Select the smallest number possible.
    - **Storage Size in GB**: Accept the default value, **32**.
    - Check the box to agree to the Azure Marketplace terms and conditions.

    ![The Custom deployment blade displays, and the information above is entered on the Custom deployment blade.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/azure-custom-deployment.png?raw=true   "Custom deployment blade")

6. Select **Purchase** to start provisioning the JumpBox VM and SQL Managed Instance.

    > **Note**: The deployment of the custom ARM template can take over 6 hours due to the inclusion of SQL MI. However, the deployment of most of the resources will complete within a few minutes. The JumpBox and SQL Server 2008 R2 VMs should complete in about 15 minutes.

7. You can monitor the progress of the deployment by navigating to the hands-on-lab-SUFFIX resource group in the Azure portal, and then selecting **Deployments** from the left-hand menu. The deployment will be named **Microsoft.Template**. Select that to view the progress of each item in the template.

    ![The Deployments menu item is selected in the left-hand menu of the hands-on-lab-SUFFIX resource group and the Microsoft.Template deployment is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/resource-group-deployments.png?raw=true   "Resource group deployments")

> You have now completed the before the hands-on lab. Check back in a few hours to monitor the progress of your SQL MI provisioning. If the provisioning goes on for longer than 7 hours, you may need to issue a support ticket in the Azure portal to request the provisioning process be unblocked by Microsoft support.

You should follow all steps provided *before* attending the Hands-on lab.
