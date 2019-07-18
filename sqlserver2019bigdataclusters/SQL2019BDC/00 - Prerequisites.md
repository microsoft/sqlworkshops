![](../graphics/microsoftlogo.png)

# Workshop: Microsoft SQL Server big data clusters Architecture (CTP 3.1)

#### <i>A Microsoft Course from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/textbubble.png"> <h2>00 prerequisites</h2>

The "Microsoft SQL Server big data clusters Architecture" workshop is taught using the following components, which you will install and configure in the sections that follow. 

*(Note: Due to the nature of working with large-scale systems, it may not be possible for you to set up everything you need to perform each lab exercise.  Participation in each Activity is optional - we will be working through the exercises together, but if you cannot install any software or don't have an Azure account, the instructor will work through each exercise in the workshop. You will also have full access to these materials so that you can work through them later when you have more time and resources.)*

For this workshop, you will use Microsoft Windows as the base workstation, although Apple and Linux operating systems can be used in production. You can <a href="https://developer.microsoft.com/en-us/windows/downloads/virtual-machines" target="_blank">download a Windows 10 Workstation Image for VirtualBox, Hyper-V, VMWare, or Parallels for free here</a>. 

The other requirements are:

- **Microsoft Azure**: This workshop uses the Microsoft Azure platform to host the Kubernetes cluster (using the Azure Kubernetes Service), and optionally you can deploy a system there to act as a workstation. You can use an MSDN Account, your own account, or potentially one provided for you, as long as you can create about $100.00 (U.S.) worth of assets.
- **SQL Server big data cluster credentials** - As of this writing, you must have an invitation code to install and configure SQL Server big data clusters.
- **Azure Command Line Interface**: The Azure CLI allows you to work from the command line on multiple platforms to interact with your Azure subscription, and also has control statements for AKS.
- **Python (3)**: Python version 3.5 (and higher) is used by the SQL Server programs to deploy and manage a SQL Server big data cluster.
- **The pip3 Package**: The Python package manager *pip3* is used to install various SQL Server BDC deployment and configuration tools. 
- **The kubectl program**: The *kubectl* program is the command-line control feature for Kubernetes.
- **The mssqlctl program**: The *mssqlctl* program is the deployment and configuration tool for SQL Server big data clusters.
- **Azure Data Studio**: The *Azure Data Studio*, along with various Extensions, is used for both the query and management of SQL Server BDC. In addition, you will use this tool to participate in the workshop.

*Note that all following activities must be completed prior to class - there will not be time to perform these operations during the workshop.*

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b>Activity 1: Set up a Microsoft Azure Account</b></p>

You have multiple options for setting up Microsoft Azure account to complete this workshop. You can use an Microsoft Developer Network (MSDN) account, a personal or corporate account, or in some cases a pass may be provided by the instructor. (Note: for most classes, the MSDN account is best)

**If you are attending this course in-person:**
Unless you are explicitly told you will be provided an account by the instructor in the invitation to this workshop, you must have your Microsoft Azure account and Data Science Virtual Machine set up before you arrive at class. There will NOT be time to configure these resources during the course.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png"><b>Option 1 - Microsoft Developer Network Account (MSDN) Account</b></p>

The best way to take this workshop is to use your [Microsoft Developer Network (MSDN) benefits if you have a subscription](https://marketplace.visualstudio.com/subscriptions).

- [Open this resource and click the "Activate your monthly Azure credit" button](https://azure.microsoft.com/en-us/pricing/member-offers/credit-for-visual-studio-subscribers/)

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png"><b>Option 2 - Use Your Own Account</b></p>

You can also use your own account or one provided to you by your organization, but you must be able to create a resource group and create, start, and manage a Data Science Virtual Machine (DSVM) and an Azure AKS cluster. 

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png"><b>Option 3 - Use an account provided by your instructor</b></p>

Your workshop invitation may have instructed you that they will provide a Microsoft Azure account for you to use. If so, you will receive instructions that it will be provided.

**Unless you received explicit instructions in your workshop invitations, you much create either an MSDN or Personal account. You must have an account prior to the workshop.**

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b>Activity 2: Request Access Credentials to SQL Server 2019 BDC features</b></p>
<br>
As of this writing, the SQL Server big data cluster feature is enabled for preview customers. You can request access at this site:

https://aka.ms/eapsignup 

When you access that site, put the words **Purpose: SQL Server 2019 BDC Workshop** in the *Please describe the specific application or workload that you will be testing with SQL Server 2019?* box. You will be motified when approved. For the *Platform*, select **Azure Kubernetes Service (AKS)**.

You will use these credentials in a subsequent step. It can take up to a week to receive your code. 

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b>Activity 3: Prepare Your Workstation</b></p>
<br>
The instructions that follow are the same for either a "base metal" workstation or laptop, or a Virtual Machine. It's best to have at least 4GB of RAM on the management system, and these instructions assume that you are not planning to run the database server or any Containers on the workstation. It's also assumed that you are using a current version of Windows, either desktop or server.
<br>

*(You can copy and paste all of the commands that follow in a PowerShell window that you run as the system Administrator)*

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Updates<p>

First, ensure all of your updates are current. You can use the following commands to do that in an Administrator-level PowerShell session:

<pre>
write-host "Standard Install for Windows. Classroom or test system only - use at your own risk!"
Set-ExecutionPolicy RemoteSigned

write-host "Update Windows"
Install-Module PSWindowsUpdate
Import-Module PSWindowsUpdate
Get-WindowsUpdate
Install-WindowsUpdate
</pre>

*Note: If you get an error during this update process, evaluate it to see if it is fatal. You may recieve certain driver errors if you are using a Virtual Machine, this can be safely ignored.*

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Install Chocolatey Windows package Manager</p>

Next, install the Chocolatey Windows Package manager to aid in command-line installations:

<pre>
write-host "Install Chocolatey" 
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation
</pre>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Review Environment Variables</p>

Your environment variables control how the cluster will be built.  

<p><a href="https://docs.microsoft.com/en-us/sql/big-data-cluster/quickstart-big-data-cluster-deploy?view=sqlallproducts-allversions#define-environment-variables" target="_blank">Refer to this documentation for both the latest statements, and for what they need to be set to. These change based on the current release of the Private Preview.</a> Do not set these at this time, just review the page.</p> 

The variables for **name**, **password** and **e-mail** for the big data cluster is provided to you when you request access to the Early Adopter program. 

*(Note that in production, you'll set these environment variables permanently using the Control Panel or by adding them with a Registry command, and will be handled by an improved and secure installation experience)*

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b>Activity 4: Install Azure CLI</b></p>

The Azure Command Line Utility is used to set up and control Azure resources. Run the following commands in your elevated PowerShell window:

<pre>
write-host "Install Azure CLI"
choco install azure-cli
</pre>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b>Activity 5: Install Python 3 and git</b></p>

While `git` has not been mentioned as a requirement for SQL Server, it's used for the workshop. First you'll install Python.

<pre>
write-host "Install Python 3"
choco install python3 

write-host "Install git"
choco install git
</pre>

Note: Python can install in multiple locations based on various conditions. To see the Python intepreter location in current use in Windows, type: 

`where python`

Note that the Chocolatey Package Manager should have set the Path variable for Python and pip, but if they are not in your path <a href="https://superuser.com/questions/143119/how-do-i-add-python-to-the-windows-path" target="_blank">you can learn how to set that here</a>. 

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b>Activity 6: Install kubectl</b></p>

The `kubectl` program is used to deploy, configure and manage Kubernetes Clusters. It is used in several parts of the big data clusters program.

<pre>
write-host "Install kubectl"
choco install kubernetes-cli 
</pre>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b>Activity 7: Install mssqlctl</b></p>

the `mssqlctl` program then deploys the SQL Server big data cluster environment onto Kubernetes. 

<i>Notes: 

You must delete the old version before the class. It is updated quite frequently during the preview phase.

You may need to run these steps in CMD rather than PowerShell.

You may have `pip3` instead of `pip` as the command. 
</i>


<pre>
REM If Python does not run in your path, try:
REM setx path "%path%;C:\Users\<replace with your login name>\AppData\Roaming\Python\Python37\Scripts"

choco upgrade kubernetes-cli

python -m pip install --upgrade pip

REM for 2.7 and lower:
pip uninstall mssqlctl

REM for 2.5:
pip3 uninstall -r  https://private-repo.microsoft.com/python/ctp-2.5/mssqlctl/requirements.txt
</pre>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b>Activity 8: Install Azure Data Studio and Extensions</b></p>

The primary management tool for working with SQL Server big data clusters is Azure Data Studio. You will also use this tool in your workshop.

<pre>
write-host "Install Azure Data Studio" 
choco install azure-data-studio
</pre>

Once again, download the MSI and run it from there. It's always a good idea after this many installations to run Windows Update again:

<pre>
write-host "Re-Update Windows"
Get-WindowsUpdate
Install-WindowsUpdate
</pre>

*Note 1: If you get an error during this update process, evaluate it to see if it is fatal. You may recieve certain driver errors if you are using a Virtual Machine, this can be safely ignored.*

**Note 2: If you are using a Virtual Machine in Azure, power off the Virtual Machine using the Azure Portal every time you are done with it. Turning off the VM using just the Windows power off in the VM only stops it running, but you are still charged for the VM if you do not stop it from the Portal. Stop the VM from the Portal unless you are actively using it.**

<p><img style="margin: 0px 15px 15px 0px;" src="../graphics/owl.png"><b>For Further Study</b></p>
<ul>
    <li><a href="https://docs.microsoft.com/en-us/sql/big-data-cluster/big-data-cluster-overview?view=sqlallproducts-allversions" target="_blank">Official Documentation for this section</a></li>
</ul>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/geopin.png"><b >Next Steps</b></p>

Next, Continue to <a href="01%20-%20The%20Big%20Data%20Landscape.md" target="_blank"><i> 01 - The Big Data Landscape</i></a>.
