![](graphics/solutions-microsoft-logo-small.png)

# R for Data Professionals

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/SmallBuck.png">00 Pre-Requisites</h2>

The "R for Data Professionals" course is taught using Microsoft Windows, SQL Server, and Visual Studio. You can of course use the R language on many platforms and in other distributions and with other tools, but using this configuration allows you to stay consistent for instruction during this course. Feel free to use other installations after you complete the course.

*Note that all following activities must be completed prior to class - there will not be time to perform these operations during the course.*

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity 1: Set up the Windows Operating System</b></p>

You have three options for setting up Microsoft Windows to complete this course. You can use a Local installation of Windows, a Virtual Machine on your local system, or a Virtual Machine stored in a Cloud provider such as Microsoft Azure. *(The third option is only for classrooms where you have reliable connections to the Internet)*

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/checkbox.png"><b>Option 1 - Local Installation</b></p>

- Install a recent version of Microsoft Windows. For this course, Windows 10, or any current of Windows Server is acceptable.
- Install all updates to the operating system.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/checkbox.png"><b>Option 2 - Install Windows on a Local Virtual Machine Environment</b></p>

- Using your local system, [navigate to this resource](https://developer.microsoft.com/en-us/windows/downloads/virtual-machines) and follow the instructions there.

**NOTE: Wait as long as reasonably possible to ensure that the system does not expire - these are free licenses, but they have a time limit**

- You can also use whatever Hypervisor you like for your system and install a legal, registered copy of Microsoft Windows.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/checkbox.png"><b>Option 3 - Use a Virtual Machine in a Cloud Provider</b></p>

- If you have access to the Internet, you can set up a [free Microsoft Azure Account](https://azure.microsoft.com/en-us/free/search/?&OCID=AID631184_SEM_bSHIQHtA&lnkd=Google_Azure_Brand&gclid=Cj0KCQjwpcLZBRCnARIsAMPBgF2myLWEk3Hllm2354GEs0rD1sDST_xcfkFGRdAE8toYZMalbQJ4M3YaAs9UEALw_wcB&dclid=CPDRgcv57tsCFVXE4Qodo-gLzg) and use a [Data Science Virtual Machine](https://docs.microsoft.com/en-us/azure/machine-learning/data-science-virtual-machine/provision-vm). Any size will do, and the free account provides enough resources for a single course. You will not need to install Anaconda, VSCode or SQL Server if you use this choice, as they are already installed for you.
- Log in to the system and run [Windows Update](https://support.microsoft.com/en-us/help/4027667/windows-update-windows-10)

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity 2: Install SQL Server 2017 with ML Services</b></p>

- [Navigate to this resource](https://www.microsoft.com/en-us/sql-server/sql-server-downloads), Select **Developer** from the lower part of the page, and install the **Developer Edition**. Select all components for installation.

- Run Windows Update and select the ["Install updates for other products" option](https://www.lifewire.com/how-to-change-windows-update-settings-2625778). Apply the latest updates to the classroom system.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity 3: Install Visual Studio with Machine Learning and Data Science workloads</b></p>

- On your classroom system, [install Visual Studio 2017](https://www.visualstudio.com/downloads/) - The free Community Edition is adequate for this course.

- During the installation, select the "Data storage and processing" and "Data science and analytical applicaitons" Workloads.  *(NOTE: [In the Data Science Workload installation box, select ALL optional components on the Summary pane!](https://blogs.msdn.microsoft.com/visualstudio/2016/11/18/data-science-workloads-in-visual-studio-2017-rc/))*

- Log in with a Live ID to Visual Studio, let the system load, and apply any updates.

- After the updates complete, click the "R Tools" menu item and open the "Interactive R Window" option (This will verify that the Data Science Workloads add-ins are working, R and Python). Type the following in that panel to ensure the installation was successful:

`x <- 10`

`x`

You should see the result **\[1\]10** returned. If not, open the Visual Studio Installer and select the "Repair" option.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/thinking.jpg"><b>For Further Study</b></p>

- Platforms supported: https://www.python.org/download/other/ 

- Installing R: https://mran.microsoft.com/download/download-platforms

Next, Continue to *01 Overview and Course Setup*
