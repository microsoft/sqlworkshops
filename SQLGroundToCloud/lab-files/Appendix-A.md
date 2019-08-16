# Appendix A: Lab environment setup

This appendix provides the steps to manually provision and configure the resources created by the ARM template used in the before the hands-on lab guide.

**Contents**:

- [Appendix A: Lab environment setup](#appendix-a-lab-environment-setup)
  - [Task 1: Create virtual network](#task-1-create-virtual-network)
  - [Task 2: Create VPN gateway](#task-2-create-vpn-gateway)
  - [Task 3: Provision SQL MI](#task-3-provision-sql-mi)
  - [Task 4: Create the JumpBox VM](#task-4-create-the-jumpbox-vm)
  - [Task 5: Create SQL Server 2008 R2 virtual machine](#task-5-create-sql-server-2008-r2-virtual-machine)
  - [Task 6: Create Azure Database Migration Service](#task-6-create-azure-database-migration-service)
  - [Task 7: Provision a Web App](#task-7-provision-a-web-app)
  - [Task 8: Create an Azure Blob Storage account](#task-8-create-an-azure-blob-storage-account)
  - [Task 9: Connect to the JumpBox](#task-9-connect-to-the-jumpbox)
  - [Task 10: Install required software on the JumpBox](#task-10-install-required-software-on-the-jumpbox)
  - [Task 11: Open port 1433 on SqlServer2008 VM network security group](#task-11-open-port-1433-on-sqlserver2008-vm-network-security-group)
  - [Task 12: Connect to SqlServer2008 VM](#task-12-connect-to-sqlserver2008-vm)

> **IMPORTANT**: Many Azure resources require unique names. Throughout these steps you will see the word "SUFFIX" as part of resource names. You should replace this with your Microsoft alias, initials, or another value to ensure resources are uniquely named.

## Task 1: Create virtual network

In this task, you will create and configure a virtual network (VNet) which will contain your SQL managed instance, JumpBox VM, and a few other resources use throughout this hands-on lab. Once provisioned, you will associated the route table with the ManagedInstance subnet, and add a Management subnet to the VNet.

1. In the [Azure portal](https://portal.azure.com), select **+Create a resource**, enter "virtual network" into the Search the Marketplace box, and then select **Virtual Network** from the results.

    ![+Create a resource is highlighted in the Azure navigation pane, and "virtual Network" is entered into the Search the Marketplace box. Virtual Network is selected in the results.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/create-resource-vnet.png?raw=true   "Create virtual Network")

2. Select **Create** on the Virtual Network blade.

    ![The Create button is highlighted on the Virtual Network blade.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/vnet-create.png?raw=true   "Create Virtual Network")

3. On the Create virtual network blade, enter the following:

    - **Name**: Enter **hands-on-lab-SUFFIX-vnet**.
    - **Address space**: Accept the default value here. This should be /16 block, in the format 10.X.0.0/16.
    - **Subscription**: Select the subscription you are using for this hands-on lab.
    - **Resource group**: Select the hands-on-lab-SUFFIX resource group from the list.
    - **Location**: Select the region you are using for resources in this hands-on lab.
    - **Subnet Name**: Enter **ManagedInstance**.
    - **Subnet Address range**: Accept the default value. This should have a subnet mask of /24, and be within the address space indicated above, in the format 10.X.0.0/24.
    - **DDOS protection**: Choose **Basic**.
    - **Service endpoints**: Select **Disabled**.
    - **Firewall**: Select **Disabled**.

    ![On the Create virtual network blade, the values specified above are entered into the appropriate fields.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/create-virtual-network.png?raw=true  "Create virtual network")

4. Select **Create**. It will take a few seconds for the virtual network to provision.

5. When it completes, you will get a notification in the Azure portal that the deployment succeeded. Select **Go to resource** within the notification.

    ![The Go to resource button is highlighted in the deployment succeeded notification in the Azure portal.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/vnet-go-to-resource.png?raw=true  "Deployment succeeded notification")

6. On the Virtual network blade, select **Subnets** under Settings in the left-hand menu, and then select **+ Subnet** from the top menu.

    ![The Subnets item is highlighted and selected in the left-hand menu of the Virtual network blade, and + Subnet is highlighted in the top menu.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/vnet-subnets-add.png?raw=true  "Add subnet")

7. On the Add subnet blade, enter the following:

    - **Name**: Enter **Management**.
    - **Address range**: Accept the default value, which should be a subnet mask of /24, within the address range of your VNet.

    ![On the Add subnet blade, Management is entered into the name field and the default values are specified for the remaining settings.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/add-subnet-management.png?raw=true  "Add subnet")

8. Select **OK**.

9. Back on the **Subnets** blade, select **+ Gateway Subnet**.

    ![Subnets is selected and highlighted in the left-hand menu. On the Subnets blade, +Gateway subnet is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/vnet-add-gateway-subnet.png?raw=true  "Subnets")

10. The **Name** for gateway subnet is automatically filled in with the value `GatewaySubnet`. This value is required in order for Azure to recognize the subnet as the gateway subnet. Accept the auto-filled Address range value, and don't configure Route table or Service endpoints.

    ![The Add subnet form is displayed, with the default values.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/vnet-add-gateway-subnet-form.png?raw=true  "Add subnet")

    > If possible, create a gateway subnet using a CIDR block of /24 to provide enough IP addresses to accommodate additional future configuration requirements.

11. Select **OK**.

## Task 2: Create VPN gateway

1. In the [Azure portal](https://portal.azure.com), select **+ Create a resource**, enter "virtual network gateway" into the Search the Marketplace box, and select **Virtual network gateway** from the results.

    ![In the Azure portal, +Create a resource is highlighted in the left-hand menu, "virtual network gateway" is entered into the Search the Marketplace box, and Virtual network gateway is highlighted in the results.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/create-resource-virtual-network-gateway.png?raw=true  "Create resource")

2. Select **Create** on the Virtual network gateway blade.

    ![The Create button is highlighted on the Virtual network gateway blade.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/virtual-network-gateway-create.png?raw=true  "Virtual network gateway")

3. On the Create virtual network gateway **Basics** tab, enter the following:

    - Project Details:

        - **Subscription**: Select the subscription you are using for this hands-on lab.

    - Instance Details:

        - **Name**: Enter hands-on-lab-SUFFIX-vnet-gateway.
        - **Region**: Select the location you are using for resources in this hands-on lab.
        - **Gateway type**: Choose **VPN**.
        - **VPN type**: Choose **Route-based**.
        - **SKU**: Select **VpnGw1**.

    - Virtual Network:

        - **Virtual network**: Select the **hands-on-lab-SUFFIX-vnet**.

    - Public IP Address:

        - **Public IP address**: Choose **Create new**.
        - **Public IP address name**: Enter **vnet-gateway-ip**.
        - **Enable active-active mode**: Choose **Disabled**.
        - **Configure BGP ASN**: Choose **Disabled**.

    ![The values specified above are entered into the appropriate fields in the Create virtual network gateway Basics tab.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/virtual-network-gateway-create-basics.png?raw=true  "Create virtual network gateway")

4. Select **Review + create**.

5. On the **Review + create** tab, ensure the *Validation passed* message is displayed and then select **Create**.

    ![The validation passed message is displayed on the Review + create tab.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/virtual-network-gateway-create-summary.png?raw=true  "Create virtual network gateway")

6. It can take up to 45 minutes for the Virtual network gateway to provision.

## Task 3: Provision SQL MI

In this task, you will create an Azure SQL Managed Instance.

1. In the [Azure portal](https://portal.azure.com), select **+Create a resource**, enter "sql managed instance" into the Search the Marketplace box, and then select **Azure SQL Managed Instance** from the results.

    ![+Create a resource is selected in the Azure navigation pane, and "sql managed instance" is entered into the Search the Marketplace box. Azure SQL Managed Instance is selected in the results.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/create-resource-sql-mi.png?raw=true  "Create SQL Managed Instance")

2. Select **Create** on the Azure SQL Managed Instance blade.

    ![The Create button is highlighted on the Azure SQL Managed Instance blade.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/sql-mi-create.png?raw=true  "Create Azure SQL Managed Instance")

3. On the SQL managed instance blade, enter the following:

    - **Subscription**: Select the subscription you are using for this hands-on lab.
    - **Managed instance name**: Enter **sqlmi-SUFFIX**
    - **Managed instance admin login**: Enter **sqlmiuser**
    - **Password**: Enter **Password.1234567890**
    - **Time zone**: Select **(UTC) Coordinated Universal Time**.
    - **Collation**: Accept the default value, **SQL_Latin1_General_CP1_CI_AS**.
    - **Location**: Select the region you are using for resources in this hands-on lab.
    - **Virtual network**: Select **hands-on-lab-SUFFIX-vnet/ManagedInstance** from the dropdown list.
    - **Prepare subnet for Managed Instance**: Check this box.
    - **Connection type**: Leave Proxy selected.
    - **Enable public endpoint**: Leave this box unchecked.
    - **Resource group**: Select **hands-on-lab-SUFFIX** from the list.
    - **Use this instance as a Failover Group secondary**: This box should remain unchecked.
    - **Pricing tier**: Select this, and on the Configure performance blade, select **Business Critical**, **Gen5**, and set the vCores to **8** and the Storage to **32**, and then select **Apply**

    ![On the Configure performance blade, Business Critical is selected, Gen5 is selected, and the vCores are set to 8 and the Storage size is set to 64.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/sql-mi-configure-performance.png?raw=true  "Configure performance")

    ![On the SQL managed instance blade, the values specified above are entered into the appropriate fields.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/sql-managed-instance.png?raw=true  "SQL Managed Instance")

    > **NOTE**: If you see a message stating that Managed Instance creation is not available for the chosen subscription type, follow the instructions for [obtaining a larger quota for SQL Managed Instance](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-managed-instance-resource-limits#obtaining-a-larger-quota-for-sql-managed-instance).

    ![A message is displayed stating that SQL MI creation not available in the selected subscription.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/sql-mi-creation-not-available.png?raw=true  "SQL MI creation not available")

4. Select **Create**.

> **NOTE**: Provisioning of SQL Managed Instance can take 6+ hours, if this is the first instance being deployed into a subnet. You can move on to the remaining tasks while the provisioning is in process.

## Task 4: Create the JumpBox VM

In this task, you will provision a virtual machine (VM) in Azure. The VM image used will have Visual Studio Community 2019 installed.

1. In the [Azure portal](https://portal.azure.com/), select **+Create a resource**, enter "visual studio 2019" into the Search the Marketplace box, expand the **Visual Studio 2019 Latest** group, and then select **Visual Studio Community 2019 (latest release) on Windows Server 2016 (x64)** from the results.

    ![+Create a resource is selected in the Azure navigation pane, and "visual studio 2019" is entered into the Search the Marketplace box. Visual Studio Community 2019 on Windows Server 2016 (x64) is selected in the results.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/create-resource-visual-studio-on-windows-server-2016.png?raw=true  "Create Windows Server 2016 with Visual Studio Community 2019")

2. Select **Create** on the Visual Studio blade.

    ![The Create button is highlighted on the Create Visual Studio VM blade.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/visual-studio-create.png?raw=true  "Create Visual Studio VM")

3. On the Create a virtual machine **Basics** tab, set the following configuration:

    - Project Details:

        - **Subscription**: Select the subscription you are using for this hands-on lab.
        - **Resource Group**: Select the hands-on-lab-SUFFIX resource group from the list of existing resource groups.

    - Instance Details:

        - **Virtual machine name**: Enter JumpBox.
        - **Region**: Select the region you are using for resources in this hands-on lab.
        - **Availability options**: Select no infrastructure redundancy required.
        - **Image**: Leave Visual Studio Community 2019 (latest release) on Windows Server 2016 (x64) selected.
        - **Size**: Select **Change size**, and select Standard D2s v3 from the list and then select **Accept**.

    - Administrator Account:

        - **Username**: Enter **sqlmiuser**
        - **Password**: Enter **Password.1234567890**

    - Inbound Port Rules:

        - **Public inbound ports**: Choose Allow selected ports.
        - **Select inbound ports**: Select RDP (3389) in the list.

    ![Screenshot of the Basics tab, with fields set to the previously mentioned settings.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/lab-virtual-machine-basics-tab.png?raw=true  "Create a virtual machine Basics tab")

4. Select **Next: Disks** to move to the next step.

5. On the **Disks** tab, set OS disk type to **Premium SSD**, and then select **Next: Networking**.

    ![On the Create a virtual machine Disks tab, the OS disk type is set to Standard SSD.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/lab-virtual-machine-disks-tab.png?raw=true  "Create a virtual machine Disks tab")

6. On the **Networking** tab, set the following configuration:

    - **Virtual network**: Select the **hands-on-lab-SUFFIX-vnet**.
    - **Subnet**: Select the **Management** subnet.
    - **Public IP**: Leave **(new) JumpBox-ip** selected.
    - **NIC network security group**: Select **Basic**.
    - **Public inbound ports**: Leave **Allow selected ports** selected.
    - **Select inbound ports**: Leave **RDP** selected.

    ![On the Create a virtual machine Networking tab, the settings specified above are entered into the appropriate fields.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/lab-virtual-machine-networking-tab.png?raw=true  "Create a virtual machine Networking tab")

    > **NOTE**: The remaining tabs can be skipped, and default values will be used.

7. Select **Review + create** to validate the configuration.

8. On the **Review + create** tab, ensure the Validation passed message is displayed, and then select **Create** to provision the virtual machine.

    ![The Review + create tab is displayed, with a Validation passed message.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/lab-virtual-machine-review-create-tab.png?raw=true  "Create a virtual machine Review + create tab")

9. It will take approximately 15 minutes for the VM to finish provisioning. You can move on to the next task while you wait.

## Task 5: Create SQL Server 2008 R2 virtual machine

In this task, you will provision another virtual machine (VM) in Azure which will host your "on-premises" instance of SQL Server 2008 R2. The VM will use the SQL Server 2008 R2 SP3 Standard on Windows Server 2008 R2 image.

> **NOTE**: An older version of Windows Server is being used because SQL Server 2008 R2 is not supported on Windows Server 2016.

1. In the [Azure portal](https://portal.azure.com/), select **+Create a resource**, and enter "SQL Server 2008R2SP3 on Windows Server 2008R2" into the Search the Marketplace box.

2. On the **SQL Server 2008 R2 SP3 on Windows Server 2008 R2** blade, select **SQL Server R2 SP3 Standard on Windows Server 2008 R2** for the software plan and then select **Create**.

    ![The SQL Server 2008 R2 SP3 on Windows Server 2008 R2 blade is displayed with the standard edition selected for the software plan. The Create button highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/create-resource-sql-server-2008-r2.png?raw=true  "Create SQL Server 2008 R2 Resource")

3. On the Create a virtual machine **Basics** tab, set the following configuration:

    - Project Details:

        - **Subscription**: Select the subscription you are using for this hands-on lab.
        - **Resource Group**: Select the hands-on-lab-SUFFIX resource group from the list of existing resource groups.

    - Instance Details:

        - **Virtual machine name**: Enter SqlServer2008.
        - **Region**: Select the region you are using for resources in this hands-on lab.
        - **Availability options**: Select no infrastructure redundancy required.
        - **Image**: Leave SQL Server 2008 R2 SP3 Standard on Windows Server 2008 R2 selected.
        - **Size**: Select **Change size**, and select Standard D2s v3 from the list and then select **Accept**.

    - Administrator Account:

        - **Username**: Enter **sqlmiuser**
        - **Password**: Enter **Password.1234567890**

    - Inbound Port Rules:

        - **Public inbound ports**: Choose Allow selected ports.
        - **Select inbound ports**: Select RDP (3389) in the list.

    ![Screenshot of the Basics tab, with fields set to the previously mentioned settings.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/sql-server-2008-r2-vm-basics-tab.png?raw=true  "Create a virtual machine Basics tab")

4. Select **Next: Disks** to move to the next step.

5. On the **Disks** tab, set OS disk type to **Premium SSD**, and then select **Next: Networking**.

    ![On the Create a virtual machine Disks tab, the OS disk type is set to Standard SSD.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/lab-virtual-machine-disks-tab.png?raw=true  "Create a virtual machine Disks tab")

6. On the **Networking** tab, set the following configuration:

    - **Virtual network**: Select the **hands-on-lab-vnet**.
    - **Subnet**: Select the **Management** subnet.
    - **Public IP**: Leave **(new) SqlServer2008-ip** selected.
    - **NIC network security group**: Select **Basic**.
    - **Public inbound ports**: Leave **Allow selected ports** selected.
    - **Select inbound ports**: Leave **RDP** selected.

    ![On the Create a virtual machine Networking tab, the settings specified above are entered into the appropriate fields.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/sql-virtual-machine-networking-tab.png?raw=true  "Create a virtual machine Networking tab")

    > **NOTE**: The remaining tabs can be skipped, and default values will be used.

7. Select **Review + create** to validate the configuration.

8. On the **Review + create** tab, ensure the Validation passed message is displayed, and then select **Create** to provision the virtual machine.
 
    ![The Review + create tab is displayed, with a Validation passed message.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/sql-virtual-machine-review-create-tab.png?raw=true  "Create a virtual machine Review + create tab")

9. It will take approximately 10 minutes for the SQL VM to finish provisioning. You can move on to the next task while you wait.

## Task 6: Create Azure Database Migration Service

In this task, you will provision an instance of the Azure Database Migration Service (DMS).

1. In the [Azure portal](https://portal.azure.com/), select **+Create a resource**, enter "database migration" into the Search the Marketplace box, select **Azure Database Migration Service** from the results, and select **Create**.

    ![+Create a resource is selected in the Azure navigation pane, and "database migration" is entered into the Search the Marketplace box. Azure Database Migration Service is selected in the results.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/create-resource-azure-database-migration-service.png?raw=true  "Create Azure Database Migration Service")

2. On the Create Migration Service blade, enter the following:

    - **Service Name**: Enter tailspin-dms.
    - **Subscription**: Select the subscription you are using for this hands-on lab.
    - **Resource Group**: Select the hands-on-lab-SUFFIX resource group from the list of existing resource groups.
    - **Location**: Select the location you are using for resources in this hands-on lab.
    - **Virtual network**: Select the **hands-on-lab-SUFFIX-vnet/Management** virtual network, and then select **OK**. This will place the DMS instance into the same VNet as your SQL MI and Lab VMs.
    - **Pricing tier**: Select Premium: 4 vCores.

    ![The Create Migration Service blade is displayed, with the values specified above entered into the appropriate fields.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/create-migration-service.png?raw=true  "Create Migration Service")

    > **NOTE**: If you see the message `Your subscription doesn't have proper access to Microsoft.DataMigration`, refresh the browser window before proceeding. If the message persists, verify you successfully registered the resource provider, and then you can safely ignore this message.

3. Select **Create**.

4. It can take 15 minutes to deploy the Azure Data Migration Service. You can move on to the next task while you wait.

## Task 7: Provision a Web App

In this task, you will provision an App Service (Web app), which will be used for hosting the Tailspin Toys web application.

1. In the [Azure portal](https://portal.azure.com/), select **+Create a resource**, enter "web app" into the Search the Marketplace box, select **Web App** from the results.

    ![+Create a resource is selected in the Azure navigation pane, and "web app" is entered into the Search the Marketplace box. Web App is selected in the results.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/create-resource-web-app.png?raw=true  "Create Web App")

2. On the Web App blade, select **Create**.

    ![On the Web App blade, the Create button is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/create-web-app.png?raw=true  "Create Web App")

3. On the Create Web App **Basics** tab, set the following configuration:

    - Project Details:

        - **Subscription**: Select the subscription you are using for this hands-on lab.
        - **Resource Group**: Select the hands-on-lab-SUFFIX resource group from the list of existing resource groups.

    - Instance Details:

        - **Name**: Enter tailspintoysSUFFIX.
        - **Publish**: Select Code.
        - **Runtime stack**: Select .NET Core 2.1.
        - **Operating System**: Select Windows.
        - **Location**: Select the location you are using for resources in this hands-on lab.

    - App Service Plan:

        - **Plan**: Accept the default value for creating a new App Service Plan.
        - **Sku and size**: Accept the default value of Standard S1.

    ![The values specified above are entered into the appropriate fields in the Create Web App Basics tab.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/create-web-app-basics-tab.png?raw=true  "Create Web App Basics tab")

4. Select **Review and create**.

5. On the **Review and create** tab, select **Create**.

    ![The Create Web App Review and Create tab is displayed.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/create-web-app-review-and-create-tab.png?raw=true  "Create Web App Review and Create tab")

6. It will take a few minutes for the Wep App creation to complete. You can move on to the next task while you wait.

## Task 8: Create an Azure Blob Storage account

1. On the Create storage account blade, enter the following:

    - Project Details:

        - **Subscription**: Select the subscription you are using for this hands-on lab.
        - **Resource Group**: Select the hands-on-lab-SUFFIX resource group from the list of existing resource groups.

    - Instance Details:

        - **Storage account name**: Enter sqlmistoreSUFFIX.
        - **Location**: Select the location you are using for resources in this hands-on lab.
        - **Performance**: Choose **Standard**.
        - **Account kind**: Select **StorageV2 (general purpose v2)**.
        - **Replication**: Select **Locally-redundant storage (LRS)**.
        - **Access tier**: Choose **Hot**.

    ![On the Create storage account blade, the values specified above are entered into the appropriate fields.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/storage-create-account.png?raw=true  "Create storage account")

2. Select **Review + create**.

3. On the **Review + create** blade, ensure the Validate passed message is displayed and then select **Create**.

    ![On the Review + create blade, the Validation passed message is displayed at the top.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/storage-create-account-review.png?raw=true  "Create storage account")

## Task 9: Connect to the JumpBox

In this task, you will create an RDP connection to your JumpBox virtual machine (VM), and disable Internet Explorer Enhanced Security Configuration.

1. In the [Azure portal](https://portal.azure.com), select **Resource groups** in the Azure navigation pane, and select the hands-on-lab-SUFFIX resource group from the list.

    ![Resource groups is selected in the Azure navigation pane and the "hands-on-lab-SUFFIX" resource group is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphicsresource-groups.png?raw=true  "Resource groups list")

2. In the list of resources for your resource group, select the JumpBox VM.

    ![The list of resources in the hands-on-lab-SUFFIX resource group are displayed, and JumpBox is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/resource-group-resources-jumpbox.png?raw=true  "JumpBox in resource group list")

3. On your JumpBox VM blade, select **Connect** from the top menu.

    ![The JumpBox VM blade is displayed, with the Connect button highlighted in the top menu.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/connect-jumpbox.png?raw=true  "Connect to JumpBox VM")

4. On the Connect to virtual machine blade, select **Download RDP File**, then open the downloaded RDP file.

    ![The Connect to virtual machine blade is displayed, and the Download RDP File button is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/connect-to-virtual-machine.png?raw=true  "Connect to virtual machine")

5. Select **Connect** on the Remote Desktop Connection dialog.

    ![In the Remote Desktop Connection Dialog Box, the Connect button is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/remote-desktop-connection.png?raw=true  "Remote Desktop Connection dialog")

6. Enter the following credentials when prompted, and then select **OK**:

    - **User name**: sqlmiuser
    - **Password**: Password.1234567890

    ![The credentials specified above are entered into the Enter your credentials dialog.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/rdc-credentials.png?raw=true  "Enter your credentials")

7. Select **Yes** to connect, if prompted that the identity of the remote computer cannot be verified.

    ![In the Remote Desktop Connection dialog box, a warning states that the identity of the remote computer cannot be verified, and asks if you want to continue anyway. At the bottom, the Yes button is circled.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/remote-desktop-connection-identity-verification-jumpbox.png?raw=true  "Remote Desktop Connection dialog")

8. Once logged in, launch the **Server Manager**. This should start automatically, but you can access it via the Start menu if it does not.

9. Select **Local Server**, then select **On** next to **IE Enhanced Security Configuration**.

    ![Screenshot of the Server Manager. In the left pane, Local Server is selected. In the right, Properties (For LabVM) pane, the IE Enhanced Security Configuration, which is set to On, is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/windows-server-manager-ie-enhanced-security-configuration.png?raw=true  "Server Manager")

10. In the Internet Explorer Enhanced Security Configuration dialog, select **Off** under both Administrators and Users, and then select **OK**.

    ![Screenshot of the Internet Explorer Enhanced Security Configuration dialog box, with Administrators set to Off.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/internet-explorer-enhanced-security-configuration-dialog.png?raw=true  "Internet Explorer Enhanced Security Configuration dialog box")

11. Close the Server Manager, but leave the connection to the JumpBox open for the next task.

## Task 10: Install required software on the JumpBox

In this task, you will install SQL Server Management Studio (SSMS) on the JumpBox.

1. First, you will install SSMS on the JumpBox. Open a web browser on your JumpBox, navigate to <https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms> and then select the **Download SQL Server Management Studio 18.x** link to download the latest version of SSMS.

    ![The Download SQL Server Management Studio 18.x link is highlighted on the page specified above.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/download-ssms.png?raw=true  "Download SSMS")

    > **NOTE**: Versions change frequently, so if the version number you see does not match the screenshot, just download and install the most recent version.

2. Run the downloaded installer.

3. On the Welcome screen, select **Install** to begin the installation.

    ![The Install button is highlighted on the SSMS installation welcome screen.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-install.png?raw=true "Install SSMS")

4. Select **Close** when the installation completes.

    ![The Close button is highlighted on the SSMS Setup Completed dialog.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/ssms-install-close.png?raw=true  "Setup completed")

## Task 11: Open port 1433 on SqlServer2008 VM network security group

In this task, you will open port 1433 on the network security group associated with the SqlServer2008 VM to allow external communication with SQL Server.

1. In the [Azure portal](https://portal.azure.com), select **Resource groups** in the Azure navigation pane, enter your resource group name (hands-on-lab-SUFFIX) into the filter box, and select it from the list.

    ![Resource groups is selected in the Azure navigation pane, "hands" is entered into the filter box, and the "hands-on-lab-SUFFIX" resource group is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/resource-groups.png?raw=true  "Resource groups list")

2. In the list of resources for your resource group, select the SqlServer2008 VM.

    ![The list of resources in the hands-on-lab-SUFFIX resource group are displayed, and SqlServer2008 is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/resource-group-resources-sqlserver2008.png?raw=true  "SqlServer2008 VM in resource group list")

3. On the SqlServer2008R2 blade, select **Networking** under Settings in the left-hand menu, and then select **Add inbound port rule**.

    ![Add inbound port rule is highlighted on the SqlServer2008 - Networking blade.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/sql-virtual-machine-add-inbound-port-rule.png?raw=true  "SqlServer2008 - Networking blade")

4. On the **Add inbound security rule blade**, enter the following:

    - Select **Basic** on the toolbar to switch to the basic view.
    - **Service**: Select MS SQL.
    - **Port ranges**: Value will be set to 1433.
    - **Priority**: Accept the default priority value.
    - **Name**: Enter SqlServer.

    ![On the Add inbound security rule dialog, MS SQL is selected for Service, port 1433 is selected, and the SqlServer is entered as the name.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/sql-virtual-machine-add-inbound-security-rule-1433.png?raw=true  "Add MS SQL inbound security rule")

5. Select **Add**. Remain on the SqlServer2008 VM blade for the next step.

## Task 12: Connect to SqlServer2008 VM

In this task, you will open an RDP connection to the SqlServer2008 VM, disable Internet Explorer Enhanced Security Configuration, and add a firewall rule to open port 1433 to inbound TCP traffic. You will also install Data Migration Assistant (DMA).

1. As you did for the JumpBox, navigate to the SqlServer2008 VM blade in the Azure portal, select **Overview** from the left-hand menu, and then select **Connect** on the top menu.

    ![The SqlServer2008 VM blade is displayed, with the Connect button highlighted in the top menu.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/connect-sqlserver2008.png?raw=true  "Connect to SqlServer2008 VM")

2. On the Connect to virtual machine blade, select **Download RDP File**, then open the downloaded RDP file.

3. Select **Connect** on the Remote Desktop Connection dialog.

    ![In the Remote Desktop Connection Dialog Box, the Connect button is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/remote-desktop-connection-sql-2008.png?raw=true  "Remote Desktop Connection dialog")

4. Enter the following credentials when prompted, and then select **OK**:

    - **User name**: sqlmiuser
    - **Password**: Password.1234567890

    ![The credentials specified above are entered into the Enter your credentials dialog.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/rdc-credentials-sql-2008.png?raw=true  "Enter your credentials")

5. Select **Yes** to connect, if prompted that the identity of the remote computer cannot be verified.

    ![In the Remote Desktop Connection dialog box, a warning states that the identity of the remote computer cannot be verified, and asks if you want to continue anyway. At the bottom, the Yes button is circled.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/remote-desktop-connection-identity-verification-sqlserver2008.png?raw=true  "Remote Desktop Connection dialog")

6. Once logged in, launch the **Server Manager**. This should start automatically, but you can access it via the Start menu if it does not.

7. On the **Server Manager** view, select **Configure IE ESC** under Security Information.

    ![Screenshot of the Server Manager. In the left pane, Local Server is selected. In the right, Properties (For LabVM) pane, the IE Enhanced Security Configuration, which is set to On, is highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/windows-server-2008-manager-ie-enhanced-security-configuration.png?raw=true  "Server Manager")

8. In the Internet Explorer Enhanced Security Configuration dialog, select **Off** under both Administrators and Users, and then select **OK**.

    ![Screenshot of the Internet Explorer Enhanced Security Configuration dialog box, with Administrators set to Off.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/2008-internet-explorer-enhanced-security-configuration-dialog.png?raw=true  "Internet Explorer Enhanced Security Configuration dialog box")

9. Back in the Server Manager, expand **Configuration** and **Windows Firewall with Advanced Security**.

    ![In Server Manager, Configuration and Windows Firewall with Advanced Security are expanded, Inbound Rules is selected and highlighted.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/windows-firewall-inbound-rules.png?raw=true  "Windows Firewall")

10. Right-click on **Inbound Rules** and then select **New Rule** from the context menu.

    ![Inbound Rules is selected and New Rule is highlighted in the context menu.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/windows-firewall-with-advanced-security-new-inbound-rule.png?raw=true  "New Rule")

11. In the New Inbound Rule Wizard, under Rule Type, select **Port**, then select **Next**.

    ![Rule Type is selected and highlighted on the left side of the New Inbound Rule Wizard, and Port is selected and highlighted on the right.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/windows-2008-new-inbound-rule-wizard-rule-type.png?raw=true  "Select Port")

12. In the Protocol and Ports dialog, use the default **TCP**, and enter **1433** in the Specific local ports text box, and then select **Next**.

    ![Protocol and Ports is selected on the left side of the New Inbound Rule Wizard, and 1433 is in the Specific local ports box, which is selected on the right.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/windows-2008-new-inbound-rule-wizard-protocol-and-ports.png?raw=true  "Select a specific local port")

13. In the Action dialog, select **Allow the connection**, and then select **Next**.

    ![Action is selected on the left side of the New Inbound Rule Wizard, and Allow the connection is selected on the right.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/windows-2008-new-inbound-rule-wizard-action.png?raw=true  "Specify the action")

14. In the Profile step, check **Domain**, **Private**, and **Public**, then select **Next**.

    ![Profile is selected on the left side of the New Inbound Rule Wizard, and Domain, Private, and Public are selected on the right.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/windows-2008-new-inbound-rule-wizard-profile.png?raw=true  "Select Domain, Private, and Public")

15. On the Name screen, enter **SqlServer** for the name, and select **Finish**.

    ![Profile is selected on the left side of the New Inbound Rule Wizard, and sqlserver is in the Name box on the right.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/windows-2008-new-inbound-rule-wizard-name.png?raw=true  "Specify the name")

16. Close the Server Manager.

17. Next, you will install DMA by navigating to <https://www.microsoft.com/en-us/download/details.aspx?id=53595> in a web browser on the SqlServer2008 VM, and then selecting the **Download** button.

    ![The Download button is highlighted on the Data Migration Assistant download page.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/dma-download.png?raw=true  "Download Data Migration Assistant")  
    > It may be a later version when you access, that is OK.

18. Run the downloaded installer.

19. Select **Next** on each of the screens, accepting to the license terms and privacy policy in the process.

20. Select **Install** on the Privacy Policy screen to begin the installation.

21. On the final screen, select **Finish** to close the installer.

    ![The Finish button is selected on the Microsoft Data Migration Assistant Setup dialog.](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/data-migration-assistant-setup-finish.png?raw=true  "Run the Microsoft Data Migration Assistant")
