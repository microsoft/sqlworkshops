<img src="https://github.com/Microsoft/sqlworkshops/blob/master/graphics/solutions-microsoft-logo-small.png?raw=true" alt="Microsoft">
<br>

# Workshop: Microsoft SQL Server Machine Learning Services

#### <i>A Microsoft Course from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/Microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=TRUE"> <h2>00 Prerequisites</h2>

The "Microsoft SQL Server Machine Learning Services" workshop is taught using the following components, which you will install and configure in the sections that follow. 

*(Note: If you are not able to set up everything you need to perform each lab exercise, participation in each Activity is optional - in a classroom setting we will be working through the exercises together, but if you cannot install any software or don't have an Azure account, the instructor will work through each exercise in the workshop. You will also have full access to these materials so that you can work through them later when you have more time and resources. If you are simply observing this course, a complete set of results is included.)*

For this workshop, you will use Microsoft Windows (Server or Windows 10) as the base workstation, although Apple and Linux operating systems can be used in production. You can <a href="https://developer.microsoft.com/en-us/windows/downloads/virtual-machines" target="_blank">download a Windows 10 Workstation Image for VirtualBox, Hyper-V, VMWare, or Parallels for free here</a>. 

The other requirements are:

- **Choclatey**: The *Chocolatey* tool allows you to install most of these components simply and quickly from the command-line. 
- **Windows System Updates**: Your workstation needs to be at the latest service packs and patches. 
- **Java** (Optional): Used in pre-processing Machine Learning for SQL Server, you'll need to install the latest Java language Runtime. We will not be using Java in this course, but the solution could work with Java if you desire to explore more on ML Services in SQL Server. 
- **git**: The `git` program allows you to copy this course (called a *clone*) and provides other utilities you will use during the class. 
- **Azure Data Studio**: The *Azure Data Studio*, along with various Extensions, is used for both the query and management of SQL Server Machine Learning Services. In addition, you will use this tool to participate in the workshop using Jupyter Notebooks.
- **Microsoft SQL Server**: This workshop uses the *Developer Edition* of SQL Server 2019 (or higher). You will install SQL Server to a system where you have administration rights, so a Virtual Machine may be a better environment for you.
- **SQL Server Management Studio (optional)** - While this course uses the Azure Data Studio to work through the exercises, the T-SQL code you find here will also run in SQL Server Management Studio.

*Note that all following activities must be completed prior to class - there will not be time to perform these operations during the workshop.*

<br>
The instructions that follow are the same for either a "bare metal" workstation or laptop, or a Virtual Machine. It's best to have at least 8GB of RAM on the system, and these instructions assume that you are able to install and configure software on the system. It's also assumed that you are using a current version of Windows, either desktop or server.
<br>

*(Copy and paste each of the commands that follow in a PowerShell window that you run as the system Administrator. You may need to reboot your system in between installation steps.)*

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/Microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><b>Activity 1: Update Your Workstation</b></p>

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

*Note: If you get an error during this update process, evaluate it to see if it is fatal. You may receive certain driver errors if you are using a Virtual Machine, this can be safely ignored.*

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/Microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><b>Activity 2: Install the Chocolatey Windows package Manager</b></p>

The Chocolatey Windows Package manager aids in simple, command-line installations. In your elevated PowerShell window, enter the following commands:

<pre>
write-host "Install Chocolatey" 
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation
</pre>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/Microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><b>Activity 3 (Optional): Install Java</b></p>

Java is not required for this course, but if you want to experiment with more Machine Learning Services you can install it using these commands: 

<pre>
write-host "Install the latest Java Runtime environment" 
choco install javaruntime
</pre> 


<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/Microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><b>Activity 4: Install Azure Data Studio</b></p>

The primary management tool we will use in this workshop is Notebooks in the Azure Data Studio. You will also use this tool in your production environment.

<pre>
write-host "Install Azure Data Studio" 
choco install azure-data-studio
</pre>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/Microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><b>Activity 5: Install git</b></p>

The `git` program and environment is used for code check-in and check-out control. It also provides a `bash` shell that you can use for some of the exercises in this course. It is not a requirement for SQL Server, but it is useful for this course. 

<pre>
write-host "Install git"
choco install git
</pre>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/Microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><b>Activity 6: Install SQL Server 2019 Developer Edition</b></p>

You're now ready to install SQL Server with Machine Learning Services. You won't use the Choclatey package manager for this step, since it's important that you understand the installation process. 

<a href="https://www.microsoft.com/en-us/sql-server/sql-server-2019" target="_blank">Open this link, Click the **Download Now** Button and follow the instructions you see there</a>, with these instructions: 

 - Use **Windows** as the Operating System
 - Select the **Developer** Edition 
 - Take all defaults 
 - Select all **SQL Server Machine Learning** components and languages (but not the *Stand-Alone Machine Learning Services* ones)
- Use the **Mixed** authentication method
- Assign the `sa` account a strong password and remember it

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Activity 7: Set Environment Variables for SQL Server Machine Learning Services</p>

For R feature integration, you should set the `MKL_CBWR` environment variable to ensure consistent output from Intel Math Kernel Library (MKL) calculations.

- Open the Windows **Control Panel**, click **System and Security** > **System** > **Advanced System Settings** > **Environment Variables**.
- Create a new **System** variable.
- Set variable name to **MKL_CBWR**
- Set the variable value to **AUTO**

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Activity 8: Install SQL Server Machine Management Studio</p>

For this course you will use the Azure Data Studio tool, but you may be more familiar with SQL Server Management Studio. You can install it so that you have that environment with this command:

<pre>
write-host "Install SSMS"
choco install sql-server-management-studio 
</pre>


<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Activity 9: Copy the Course Database</b></p>

- The dataset used in this course is contained in a few SQL Server tables. The tables contain data from various systems on-premises over a period of time. <a href="https://cs7a9736a9346a1x44c6xb00.blob.core.windows.net/backups/Analysis.bak" target="_blank">The backup (.bak) file is located here - note that it may take some time to download, so do this before you arrive to class if taking this course in-person.</a> 
- Copy that file to this location on your Instance: `C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup`.

During the course, you will restore this backup to your system. You do not need to do that now. 

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Activity 10: Update and Reboot system</p>

It's always a good idea after this many installations to run Windows Update again and reboot your system:

<pre>
write-host "Re-Update Windows"
Get-WindowsUpdate
Install-WindowsUpdate
</pre>

*Note 1: If you get an error during this update process, evaluate it to see if it is fatal. You may receive certain driver errors if you are using a Virtual Machine, this can be safely ignored.*

*Note 2: If you are using a Virtual Machine in Azure, power off the Virtual Machine using the Azure Portal every time you are done with it. Turning off the VM using just the Windows power off in the VM only stops it running, but you are still charged for the VM if you do not stop it from the Portal. Stop the VM from the Portal unless you are actively using it.*

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/Microsoft/sqlworkshops/blob/master/graphics/thinking.jpg?raw=true"><b>For Further Study</b></p>

<br>
<br>

<ul>
    <li><a href="https://docs.microsoft.com/en-us/sql/advanced-analytics/install/sql-machine-learning-services-windows-install?view=sql-server-ver15" target="_blank">Official Documentation for setting up Machine Learning Services in SQL Server 2019</a></li>
</ul>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/Microsoft/sqlworkshops/blob/master/graphics/education1.png?raw=true"><b >In-Class Steps</b></p>

When all of the above is complete and you are in class, you'll download a zip file of the entire set of SQL Server workshops to your local environment, open the Notebooks in Azure Data Studio, and continue through the course. If you are taking this course self-paced, continue with the next steps.

**NOTE:** *If you are taking this course self-paced, continue with these instructions, if you are going to take the course in-class, you can stop here.*

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png"><b>Get the Course Files</b></p>

<br>
<a href="https://github.com/Microsoft/sqlworkshops/archive/master.zip" target="_blank">Open this link</a> and open the file, and un-zip the files into your workstation's <b>Documents</b> directory. The base directory we will use for this class is called <b>SQLServerMLServices</b>. Even if you did this prior to class, do this again so that you have the latest versions.

*Note: You can use `git` to clone the workshop if you like with the following commands, typed in a command shell in your "Documents" directory*: 

<pre>
git clone https://github.com/Microsoft/sqlworkshops.git
</pre>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png"><b>Begin the Course using Azure Data Studio and Notebooks</b></p>

Now you can open **Azure Data Studio**, navigate using the file-icon on the left, and open the base directory for this course. Locate the **notebooks** folder and open the Notebook called **01-SQLServerMachineLearningServicesArchitecture.ipynb**
