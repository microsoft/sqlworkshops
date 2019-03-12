![](graphics/microsoftlogo.png)

# Hybrid Machine Learning

#### <i>A Microsoft Course from the Learn AI team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png">00 Pre-Requisites</h2>

The "Hybrid Machine Learning" course is taught using the following components, which you will install and configure in the sections that follow:

- **Microsoft Azure**: A free account. MSDN Account, your own account, or potentially one provided for you is acceptable as long as you can create a Data Science Virtual Machine (DSVM) in it

- **SQL Server 2017 Developer Edition:** with ML Services installed and configured. *(Already installed on the DSVM)*

- **Visual Studio Code**: You'll focus on using VS Code with Python. *(Already installed on the DSVM)*

- **Azure Machine Learning Services Workspace**: You'll use this to set up the Azure ML components discussed in the course*

- **Additional Components:** It's also a good idea to install a Markdown-File previewer in your browser of choice, since the instructions are all based on MD files. On the DSVM, open FireFox and install the *Markdown Viewer Webext* Extension. You can then simply drag the MD files into the browser for a clean course display. Alter Visual Studio Code to install Python, Markdown, Azure AI, SQL Server, and Anaconda extensions. These will be detailed below.

*Note that all following activities must be completed prior to class - there will not be time to perform these operations during the course.*

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity 1: Set up a Microsoft Azure Account</b></p>

You have multiple options for setting up Microsoft Azure account to complete this course. You can use a free account, a Microsoft Developer Network (MSDN) account, a personal or corporate account, or in some cases a pass may be provided by the instructor. (Note: for most classes, the MSDN account is best)

**Unless you are explicitly told you will be provided an account by the instructor in the invitation to this course, you must have your Microsoft Azure account and Data Science Virutal Machine set up before you arrive at class.**

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/checkbox.png"><b>Option 1 - Free Account</b></p>

The free account gives you twelve months of time, and a limited amount of resources. Set this up prior to coming to class, and ensure you can access it from the system you will bring to the class.

- [Open this resource, and click the "Start Free" button you see there](https://azure.microsoft.com/en-us/free/)

**NOTE: You can only use the Free subscription once, and it expires in 12 months. Set up your account and create the DSVM per the instructions below, but ensure that you turn off the VM in the Portal to ensure that you do no exceed the cost limits on this account. You will turn it off and on in the classroom per the instructor's directions.**

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/checkbox.png"><b>Option 2 - Microsoft Developer Network Account (MSDN) Account</b></p>

The best way to take this course is to use your [Microsoft Developer Network (MSDN) benefits if you have a subscription](https://marketplace.visualstudio.com/subscriptions).

- [Open this resource and click the "Activate your monthly Azure credit" button](https://azure.microsoft.com/en-us/pricing/member-offers/credit-for-visual-studio-subscribers/)

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/checkbox.png"><b>Option 3 - Use Your Own Account</b></p>

You can also use your own account or one provided to you by your organization, but you must be able to create a resource group and create, start, and manage a Data Science Virtual Machine (DSVM). More on that product below.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/checkbox.png"><b>Option 4 - Use an account provided by your instructor</b></p>

Your course invitation may have instructed you that they will provide a Microsoft Azure account for you to use. If so, you will receive instructions that it will be provided.

**Unless you received explicit instructions in your course invitations, you much create either a free, MSDN or Personal account. You must have an account prior to the course.**

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity 2: Create a Data Science Virtual Machine</b></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/checkbox.png"><b>Create the DSVM</b> - <a href="https://docs.microsoft.com/en-us/azure/machine-learning/data-science-virtual-machine/provision-vm" target=_blank>Open this reference</a> and follow the instructions you see there. You will select a Windows 2016 Server DSVM, and a size of **DS4_v3**.
- Start the Data Science Virtual Machine from the Portal and log in.

**Note: Power off the Virtual Machine using the Azure Portal every time you are done with it. Turning off the VM using just the Windows power off in the VM only stops it running, but you are still charged for the VM if you do not stop it from the Portal. Stop the VM from the Portal unless you are actively using it.**

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity 3: Set up the Additional Requirements</b></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/checkbox.png"><b>Update the DSVM</b> - Start your Data Science Virtual Machine (DSVM) and log in using the credentials you provided. Run Windows Update and update the system, and allow it to reboot if required.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/checkbox.png"><b>Update VS Code</b> - On the DSVM, open Visual Studio Code. <a href="https://code.visualstudio.com/docs/setup/setup-overview#_update-cadence" target= _blank>Click this link to read about updating the product.</a> Allow the product to update before continuing to the next step.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/checkbox.png"><b>Add Extensions to VS Code</b> - In Visual Studio Code, add the following extensions <a href="https://code.visualstudio.com/docs/setup/setup-overview#_extensions" target=_blank>(You can read more about how to add extensions here)</a>:

- Anaconda Extension Pack
- Azure Account
- Azure CLI Tools
- Excel Viewer
- VS Code Jupyter Notebook Previewer
- Markdown Preview Enhanced
- Python
- Python Extension Pack
- SQL Server (mssql)
- Visual Studio Code Tools for AI

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity 4: Set up an Azure Machine Learning account (free)</b></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/checkbox.png"><b>Create a Azure Machine Learning Service Workspace</b> - <a href="https://docs.microsoft.com/en-us/azure/machine-learning/service/quickstart-get-started" target=_blank>Open this reference, watch the video, and follow the instructions to create a Workspace</a>. Folow the instructions on this page, but do not delete the resources - you will need them in class.

<p><img style="margin: 0px 15px 15px 0px;" src="./graphics/thinking.jpg"><b>For Further Study</b></p>

<br>

- [Microsoft Azure](https://docs.microsoft.com/en-us/learn/paths/azure-fundamentals/)
- [Working with Jupyter Notebooks](https://notebooks.azure.com/Microsoft/libraries/samples)
- [Python Introduction](https://notebooks.azure.com/Microsoft/libraries/samples/html/Introduction%20to%20Python.ipynb)
- [Visual Studio Code](https://code.visualstudio.com/docs/getstarted/introvideos)
- [Microsoft SQL Server](https://docs.microsoft.com/en-us/sql/relational-databases/database-engine-tutorials?view=sql-server-2017)

Next, continue to <a href="01%20Project%20Methodology%20and%20Data%20Science.md" target="_blank">01 Project Methodology and Data Science</a>