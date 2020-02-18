![](https://github.com/microsoft/sqlworkshops/blob/master/graphics/microsoftlogo.png?raw=true)

# The Azure SQL Workshop   

#### <i>A Microsoft Workshop from the SQL team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=true"> <h2>00 Prerequisites</h2>

The Azure SQL Workshop is taught using the following components, which you will install and configure in the sections that follow. 

> NOTE: If you take this Workshop in person, you may be provided with a complete environment, or have different instructions. The invitation where you registered for the Workshop will be followed up with details for that environment, otherwise assume that you need to complete all of the following steps to complete the Workshop. The Labs in this Workshop are optional, all screenshots and Notebooks are provided for you to follow along if you cannot meet these requirements. 

For this workshop, you can use any base OS station, as long as you can connect to a Remote Desktop (RDP).  

Other requirements include:

- **Microsoft Azure**: This Workshop uses the Microsoft Azure platform to host the environment and workstation. You can use a free Azure account, an MSDN Account, your own account, or potentially one provided for you, as long as you can create about $100.00 (U.S.) worth of assets.

> Note that all following activities must be completed prior to class - there will not be time to perform these operations during the workshop.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity 1: Set up a Microsoft Azure Account</b></p>

You have multiple options for setting up Microsoft Azure account to complete this workshop. You can [use a free account](https://azure.microsoft.com/en-us/free/), a Microsoft Developer Network (MSDN) account, a personal or corporate account, or in some cases a pass may be provided by the instructor. (Note: for most classes, the MSDN account is best)

**Unless you are explicitly told you will be provided an account by the instructor in the invitation to this workshop, you must have your Microsoft Azure account set up before you arrive at class.**

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><b>Option 1 - Free Account</b></p>

The free account gives you twelve months of time, and a limited amount of resources. Set this up prior to coming to class, and ensure you can access it from the system you will bring to the class.

- [Open this resource, and click the "Start Free" button you see there](https://azure.microsoft.com/en-us/free/)

**NOTE: You can only use the Free subscription once, and it expires in 12 months. Set up your account per the instructions below, but ensure that you "Stop" any VM's in the Portal to ensure that you do not exceed the cost limits on this account. You will turn it off and on in the classroom per the instructor's directions.**

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><b>Option 2 - Microsoft Developer Network Account (MSDN) Account</b></p>

The best way to take this workshop is to use your [Microsoft Developer Network (MSDN) benefits if you have a subscription](https://marketplace.visualstudio.com/subscriptions).

- [Open this resource and click the "Activate your monthly Azure credit" button](https://azure.microsoft.com/en-us/pricing/member-offers/credit-for-visual-studio-subscribers/)

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><b>Option 3 - Use Your Own Account</b></p>

You can also use your own account or one provided to you by your organization, but you must be able to create a resource group and create, start, and manage a Virtual Machine and Azure SQL components. 

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><b>Option 4 - Use an account provided by your instructor</b></p>

Your workshop invitation may have instructed you that they will provide a Microsoft Azure account for you to use. If so, you will receive instructions that it will be provided.

**Unless you received explicit instructions in your workshop invitations, you must create either a free, MSDN or Personal account. You must have an account prior to the workshop.**

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity 2: Set up your environment</b></p>

In order to complete this workshop, you need to install the following software:  

1. Using your Azure account, create a resource group for the workshop, naming it **azuresqlworkshopID** where **ID** is some 4-6 digit identifier that you can easily remember (e.g. 0406 is my birthday so I might pick "azuresqlworkshop0406"). Use this same **ID** every time you are told to name something ending in **ID**. Select a region that is close to where you are, and use this region for all future resources.
1. Deploy an [Azure virtual machine](https://ms.portal.azure.com/#create/Microsoft.VirtualMachine-ARM) (link goes to service in Azure portal). The recommended minimum size is a **D2s_v3**, and you should use a **Windows 10 Pro** image. Name the virtual machine **win-vmID** (i.e. "win-vm0406"). Use the username **vmuser** and choose a password. Accept other defaults, and refer to more information on deploying Azure virtual machines [here](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/quick-create-portal#create-virtual-machine).  

1. After your virtual machine is deployed, you need to add **Microsoft.Sql** as a service endpoint in the virtual network that is created in the resource group. Navigate to the vNet in the Azure portal, should be similar to **azuresqlworkshop`ID`-vnet**, and select **Service endpoints** in the left-hand task menu. Select **Add** and for the Service select **Microsoft.Sql** and apply this to the **default** subnet. Select add.    

1. [Connect to the virtual machine](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/connect-logon), and perform the remaining steps in the virtual machine.  

1. Download the [new Microsoft Edge](https://www.microsoft.com/en-us/edge?form=MY01BL&OCID=MY01BL) and make it your default browser (you can type "default browser" in the Windows taskbar and it will take you to the settings for this).  

1. Navigate to the [Azure portal](https://www.portal.azure.com) and log in with the same Azure credentials used to create the resource group and Azure virtual machine.  

1. Complete [Step 1.2 and 1.3 at this link to install and configure Java and Maven](https://www.microsoft.com/en-us/sql-server/developer-get-started/java/windows). You can confirm this worked by opening a new command prompt and running `mvn --version`. If this command results include Maven 3.6.3+ and Java 1.8.0_241+, the configuration is complete.  

1. Pin the command prompt to the taskbar (right-click on icon in taskbar and select **Pin to taskbar**).

1. Install the [RMUtils tool (which contains ostress)](https://www.microsoft.com/en-us/download/details.aspx?id=4511) and add `C:\Program Files\Microsoft Corporation\RMLUtils` to the VM's System variables' Path. You can confirm this worked by opening a new command prompt and running `ostress`. If you see the available commands, the configuration is complete.  

1. Install [SQL Server 2019 Developer/Evaluation edition](https://www.microsoft.com/en-us/sql-server/sql-server-2019#Install) with default features enabled (using the **Basic** selection).  

1. Install the [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?view=azure-cli-latest).  

1. Install the [Az PowerShell Module](https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-3.4.0). Open PowerShell and right-click on the icon in the taskbar and select **Pin to taskbar**. Close PowerShell.    

3. Install [Azure Data Studio February 2020 or later](https://docs.microsoft.com/en-us/sql/azure-data-studio/download). T-SQL and PowerShell notebooks are used in this course.  

1. Open Azure Data Studio and select **New notebook** from the main page. For kernel, change to PowerShell. You should get a pop-up to the side that reads "Configure Python for Notebooks". Leave all the defaults and select **Install**. While it's installing, you can right-click on the icon in the taskbar and select **Pin to taskbar**.   

1. In Azure Data Studio, if/when you get a pop-up asking to enable preview features, select **Yes**. When the installation of Python is complete and you have enabled preview features., you can close Azure Data Studio (no need to save the "New notebook").    

2. Install [SQL Server Management Studio (SSMS) 18.4 or higher](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms). Several of the modules require features built only into SSMS. Once it installs, restart the virtual machine.      

4. Download the [AdventureWorksLT2017.bak](https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksLT2017.bak). Copy the file to the `C:` drive. Open SSMS and right-click on the icon in the taskbar and select **Pin to taskbar**. Then, use SSMS to restore the backup on the SQL Server 2019 instance you created in an earlier step (you can use **.** and **Windows Authentication** to connect to the local SQL Server in SSMS).

1. Install [Git for Windows](https://git-scm.com/download/win) with all defaults, and run the following command in Windows Command Prompt. This downloads the repository (i.e. all the files for the workshop) to `C:\Users\<vm-username>`.  
```cmd
git clone --config core.autocrlf=false https://github.com/microsoft/sqlworkshops.git
```



<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/geopin.png?raw=true"><b >Next Steps</b></p>

Next, Continue to <a href="https://github.com/microsoft/sqlworkshops/blob/master/azuresqlworkshop/azuresqlworkshop/01-IntroToAzureSQL.md" target="_blank"><i> 01 - Introduction to Azure SQL</i></a>.
