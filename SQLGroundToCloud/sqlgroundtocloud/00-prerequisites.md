![](https://github.com/microsoft/sqlworkshops/blob/master/graphics/microsoftlogo.png?raw=true)

# Workshop: SQL Ground-to-Cloud

#### <i>A Microsoft Workshop from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=true"> <h2>00 Prerequisites</h2>

The *Workshop: SQL Ground-to-Cloud* workshop is taught using the following components, which you will install and configure in the sections that follow. 

> NOTE: If you take this Workshop in person, you may be provided with a complete environment, or have different instructions. The invitation where you registered for the Workshop will be followed up with details for that environment, otherwise assume that you need to complete all of the following steps to complete the Workshop. The Labs in this Workshop are optional, all screenshots and Notebooks are provided for you to follow along if you cannot meet these requirements. 

For this workshop, you will use Microsoft Windows as the base workstation, although Apple and Linux operating systems can be used in production. You can <a href="https://developer.microsoft.com/en-us/windows/downloads/virtual-machines" target="_blank">download a Windows 10 Workstation Image for VirtualBox, Hyper-V, VMWare, or Parallels for free here to use in the course</a>. You must be able to install software on the system you will use for the course, so a Virtual Machine is often a good choice. This Workshop was built and designed for a server or VM to run SQL Server with at least 8Gb RAM and 4 CPUs. 

Note that you will need to be able to run the Docker program on your workstation, so [Nested Virtualization must be enabled on the system](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/nested-virtualization), or your physical workstation must be able to run Hyper-V images. 

Other requirements include:

- **Microsoft Azure**: This Workshop uses the Microsoft Azure platform to host various components, and optionally you can deploy a system there to act as a workstation. You can use a free Azure account, an MSDN Account, your own account, or potentially one provided for you, as long as you can create about $100.00 (U.S.) worth of assets.

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

In order to complete this workshop you need to install the following software:

1. Install [SQL Server 2019 CTP 3.2 or later](https://www.microsoft.com/en-us/sql-server/sql-server-2019#Install) with all features, PolyBase (stand-alone) enabled, and ensure you have 20GB of drive space available.

2. Install SQL Server Management Studio (SSMS) 18.2 or higher from https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms. Several of the modules require features built only into SSMS.

3. Install Azure Data Studio June 2019 or higher from https://docs.microsoft.com/en-us/sql/azure-data-studio/download. T-SQL notebooks are used extensively in this course.

4. [Install Docker Desktop for Windows](https://docs.docker.com/docker-for-windows/install/).

5. Download the WideWorldImporters sample backup from https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Full.bak


<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity 3: Clone the Workshop</b></p>

To complete this Workshop you will work from local files. You can either use the `git` program or a ZIP file, which you will save on your workstation.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><b>Getting the Workshop files</b></p>

- You can [download the repository holding these files using this link](https://github.com/microsoft/sqlworkshops/archive/master.zip).

- If you have git installed, The workshop git repository is: https://github.com/microsoft/sqlworkshops.git  
    `git clone --config core.autocrlf=false https://github.com/microsoft/sqlworkshops.git`
	
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity 4: Set up your environment for Modules 4 and 5</b></p>

> **Important Note!** If you are being provided an account by your instructor (see Option 4 in Activity 1), you do not need to complete this activity.  

Before arriving at the workshop, if you intend to complete `04-SQLServerOnTheMicrosoftAzurePlatform` and/or `05-MigratingToAzureSQL`, you must complete the prerequisites outlined [here](../lab-files/Module4and5Prerequisites.md). Note that all screenshots are provided, so you can "audit" this part of the Workshop if you like. 

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/geopin.png?raw=true"><b >Next Steps</b></p>

Next, Continue to <a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/01-IntroductionAndWorkshopMethodology.md" target="_blank"><i> 01 - Introduction and Workshop Methodology</i></a>.
