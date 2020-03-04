![](https://github.com/microsoft/sqlworkshops/blob/master/graphics/microsoftlogo.png?raw=true)

# Workshop: Kubernetes - From Bare Metal to SQL Server Big Data Clusters

#### <i>A Microsoft Course from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=true"> <h2>00 prerequisites</h2>

This workshop is taught using various components, which you will install and configure in the sections that follow. 

> Note: Due to the nature of working with large-scale systems, it may not be possible for you to set up everything you need to perform each lab exercise.  Participation in each Activity is optional - we will be working through the exercises together, but if you cannot install any software or don't have an Azure account, the instructor will work through each exercise in the workshop. You will also have full access to these materials so that you can work through them later when you have more time and resources. Another option is to "pair-up" with a fellow student and work together on a single environment.

For this workshop, you will use an instructor-provided Virtual Machine environment with Ubuntu as the operating system, along with Docker, and Kubernetes pre-installed. The intention of the course is that these systems are provided to you in class. However, to ensure that you have an environment available should something go wrong with the in-class system, or if you want to take this course outside of a classroom, you need to set up a Virtual Machine with these software components. 

> Note: If you wish to use another cloud service or a local Virtual Machine, it needs to match or exceed the [Microsoft Azure Standard_D8s_v3 Virtual Machine](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes-general#dsv3-series-1) which  has the following requirements:
- Ubuntu 16.04
- 8 CPU's
- 32 GB Memory
- 200 GB Disk, all on primary OS mount

Whether you use the provided classroom system, the Microsoft Azure Virtual Machine, or another Virtual Machine system, the requirements for your local laptop are (*You will get instructions for setting these up in a moment*):

- **A Microsoft Azure Account**: This workshop uses the Microsoft Azure platform to host the backup Kubernetes cluster (using an appropriately sized Virtual Machine). You can use an MSDN account for Azure, your own Azure account, or potentially one provided for you, as long as you can create about $75.00 (U.S.) worth of Microsoft Azure assets.
- **The Azure Command Line Interface**: The Azure CLI allows you to work from the command line on multiple platforms to interact with your Azure subscription, and also has control statements for AKS.
- **Microsoft Azure Data Studio**: The *Azure Data Studio* IDE, along with various Extensions, is used for deploying the system, and querying and management of the BDC. In addition, you will use this tool to participate in the workshop. Note: You can connect to a SQL Server 2019 Big Data Cluster using any SQL Server connection tool or application, such as SQL Server Management Studio, but this course will use Microsoft Azure Data Studio for cluster management, Jupyter Notebooks and other capabilities. 

*Note that all following activities must be completed prior to class - there will not be time to perform these operations during the workshop.*

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity 1: Set up a Microsoft Azure Account</b></p>

You have multiple options for setting up Microsoft Azure account to complete this workshop. You can use a Microsoft Developer Network (MSDN) account, a personal or corporate account, or in some cases a pass may be provided by the instructor. (Note: for most classes, the MSDN account is best)

**If you are attending this course in-person:**
Unless you are explicitly told you will be provided an account by the instructor in the invitation to this workshop, you must have your Microsoft Azure account and  Virtual Machine set up before you arrive at class. There will NOT be time to configure these resources during the course.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><b>Option 1 - Microsoft Developer Network Account (MSDN) Account</b></p>

The best way to take this workshop is to use your [Microsoft Developer Network (MSDN) benefits if you have a subscription](https://azure.microsoft.com/en-us/pricing/member-offers/visual-studio-subscriptions/).

- [Open this resource and click the "Activate your monthly Azure credit" button](https://azure.microsoft.com/en-us/pricing/member-offers/credit-for-visual-studio-subscribers/)

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><b>Option 2 - Use Your Own Account</b></p>

You can also use your own account or one provided to you by your organization, but you must be able to create a resource group and create, start, and manage a Virtual Machine and an Azure Virtual Machine. 

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><b>Option 3 - Use an account provided by your instructor</b></p>

Your workshop invitation may have instructed you that they will provide a Microsoft Azure account for you to use. If so, you will receive instructions that it will be provided.

**Unless you received explicit instructions in your workshop invitations, you must create either an MSDN or Personal Microsoft Azure account. You must have an account prior to the workshop. No Microsoft Azure assets will be provided the day of class unless instructed otherwise.**

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity 2: Prepare Your Workstation</b></p>

You will need to install the Azure Command Line utility to run the rest of these commands, and at the end of the course you will need the Microsoft Azure Data Studio tool to access the SQL Server Big Data Cluster.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><b>Install The Microsoft Azure Command Line Utility</b></p>

[Open this reference in another browser tab, and follow the instructions you find there.](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><b>Install The Microsoft Azure Data Studio</b></p>

[Open this reference in another browser tab, and follow the instructions you find there.](https://docs.microsoft.com/en-us/sql/azure-data-studio/download-azure-data-studio?view=sql-server-ver15)

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity 3: Prepare The Virtual Machine on Azure</b></p>

These instructions create a Single-Node Kubernetes Cluster on an Azure Virtual Machine *(Unsupported for production - classroom use only)*.

In this set of instructions you'll set up a SQL Server 2019 big data cluster using Ubuntu on a single-Node using a Microsoft Azure Virtual Machine.

> Note: This is an unsupported configuration, and should be used only for classroom purposes. Carefully read the instructions for the parameters you need to replace for your specific subscription and parameters.

These instructions use shell commands, such as PowerShell, bash, or the CMD window from a system that has the Secure Shell software installed (SSH). You can type:

<pre>ssh -h</pre>

To see if this tool is installed. 

You can copy-and-paste the lines that follow to run the commands, or you can set your IDE to run the current line in a Terminal window. In [Visual Studio Code or Azure Data Studio, these are called Keybindings](https://code.visualstudio.com/docs/getstarted/keybindings) and you can set the command to run the current line from a text file in the default terminal to any key you like:

*Preferences* | *Keyboard Shortcuts* | *Terminal: Run Selected Text in Active Terminal*

In other IDE systems you can configure the current line to run in a terminal, or simply perform all of these commands from a Terminal window.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><b>Step 1: Log in to Azure</b></p>

<pre>az login</pre>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><b>Step 2: Set your account</b></p>

Show the accounts:

<pre>az account list --output table</pre>

Replace **YourAccountNameHere** (leave the quotes in place) with your account name from the previous command. If you have one account, that will automatically be the set account, but it's best to be specific.

<pre>az account set --subscription "YourAccountNameHere"</pre>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><b>Step 3: Create a Resource Group, and a Virtual Machine</b></p>

>Note: You'll needs a machine large enough to run BDC and also have Nested Virtualization. The script steps that follow take care of that for you. 

In the commands below, replace the following items with your values: 

- **ReplaceWithResourceGroupName** : Enter a Resource Group name you would like for this class. Use lowercase only.
- **ReplaceWithPassword** : Enter a password to use for the Virtual Machine. 
- **ReplaceWithVMName** : Enter a Virtual Machine name you would like for this class. Use lowercase only.

<pre>
az group create -n ReplaceWithResourceGroupName -l eastus2

az vm create -n ReplaceWithVMName -g ReplaceWithResourceGroupName -l eastus2 --image UbuntuLTS --os-disk-size-gb 200 --storage-sku Premium_LRS --admin-username bdcadmin --admin-password ReplaceWithPassword --size Standard_D8s_v3 --public-ip-address-allocation static
</pre>

The last set of commands will return an IP address. Replace the value **ReplaceWithIPAddressThatReturnsFromLastCommand** with that number.

<pre>ssh -X bdcadmin@ReplaceWithIPAddressThatReturnsFromLastCommand</pre>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><b>Step 4: Update and Upgrade Ubuntu</b></p>

Once connected, you'll need to update the Linux Environment.

<pre> 
sudo apt-get update

sudo apt-get upgrade

sudo apt autoremove
</pre>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity 4: Install BDC Single Node - Pre-requisites (Current as of 1/31/2020)</b></p>

Now you're ready to install Docker, Kubernetes, and all of the components for a SQL Server Big Data Cluster. You should still be in the Secure Shell environment - if not, run this command again using the proper IP address. Replace the value **ReplaceWithIPAddressThatReturnsFromLastCommand** with that number.

> Note: Although every effort is made to keep this document current, if the steps below do not work, [you can examine the reference here for the latest official process](https://docs.microsoft.com/en-us/sql/big-data-cluster/deployment-script-single-node-kubeadm?view=sql-server-ver15). 

<pre>ssh -X bdcadmin@ReplaceWithIPAddressThatReturnsFromLastCommand</pre>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><b>Step 5: Download and mark the BDC Setup script for Execution</b></p>

In  this step you'll pull down the complete SQL Server Big Data Cluster Single-Node script. This will install Docker, Kubernetes, and all of SQL Server. This will take anywhere from 15-30 minutes. 

<pre>
curl --output setup-bdc.sh https://raw.githubusercontent.com/microsoft/sql-server-samples/master/samples/features/sql-big-data-cluster/deployment/kubeadm/ubuntu-single-node-vm/setup-bdc.sh

chmod +x setup-bdc.sh

sudo ./setup-bdc.sh
</pre>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><b>Step 6: Set the tools path and Check Installation</b></p>

In this final step you'll set the Linux path so that the tools run properly, and then check to make sure everything is up.

<pre>
source ~/.bashrc

azdata --version

kubectl get pods
</pre>

The system is now ready for class. Use the Linux <pre>shutdown -h</pre> command in the secure shell to stop the Virtual Machine. 

Next, run the following command to de-allocate the machine safely so that you are no longer charged (except for the storage) until class starts.  

>Note: This command does not remove the Virtual Machine. You will start it again once you start the class. Do NOT leave the system running in the Auzre Portal or it will use all your credits, and potentially result in additional charges.  

<pre>az vm deallocate --name ReplaceWithVMName</pre>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity 5: After Class Cleanup - Erase everything</b></p> 

When the class is complete, you can remove your environment so that you are no longer charged for it. The following commands will do that for you. 

> Only perform this step when you are done experimenting with the system, after the class

<pre>az group delete --name ReplaceWithResourceGroupName</pre>

>Note: If you are using a Virtual Machine in Azure, power off the Virtual Machine using the Azure Portal every time you are done with it. Turning off the VM using just the Linux shutdown command in the VM only stops it running, but you are still charged for the VM if you do not stop it from the Portal. Stop (de-allocate) the VM from the Portal unless you are actively using it.

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/owl.png?raw=true"><b>For Further Study</b></p>
<ul>
    <li><a href="https://docs.microsoft.com/en-us/sql/big-data-cluster/deployment-script-single-node-kubeadm?view=sql-server-ver15" target="_blank">This Notebook uses the script located here</a>, and that reference supersedes the information in the steps listed above.</li> 
    <li><a href="https://docs.microsoft.com/en-us/sql/big-data-cluster/quickstart-big-data-cluster-deploy?view=sql-server-ver15" target="_blank">You can also create a SQL Server Big Data Cluster on the Azure Kubernetes Service (AKS) using these instructions</a>.</li>
    <li><a href="https://github.com/Microsoft/sqlworkshops/tree/master/sqlserver2019bigdataclusters" target="_blank">For a complete workshop on SQL Server 2019's big data clusters, see this reference</a>.</li>
</ul>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/geopin.png?raw=true"><b >Next Steps</b></p>

Next, Continue to <a href="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/KubernetesToBDC/01-introduction.md" target="_blank"><i> Module 1 - Introduction</i></a>.
