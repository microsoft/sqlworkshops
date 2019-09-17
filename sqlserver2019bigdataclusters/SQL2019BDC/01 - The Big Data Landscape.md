![](../graphics/microsoftlogo.png)

# Workshop: SQL Server Big Data Clusters - Architecture (CTP 3.2)

#### <i>A Microsoft Course from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/textbubble.png"> <h1>The Big Data Landscape</h1>

In this workshop you'll cover using a Process and various Platform components to create a Big Data Cluster for SQL Server (BDC) solution you can deploy on premises, in the cloud, or in a hybrid architecture. In each module you'll get more references, which you should follow up on to learn more. Also watch for links within the text - click on each one to explore that topic. There's a lot here - so focus on understanding the overall system first, then come back and explore each section.

(<a href="https://github.com/Microsoft/sqlworkshops/blob/master/sqlserver2019bigdataclusters/SQL2019BDC/00%20-%20Prerequisites.md" target="_blank">Make sure you check out the <b>prerequisites</b> page before you start</a>. You'll need all of the items loaded there before you can proceed with the workshop.)

You'll cover the following topics in this Module:

<dl>

  <dt><a href="#1-1">1.1 Business Applications and Big Data</a></dt>
  <dt><a href="#1-2">1.2 Workshop Scenario</a></dt>
  <dt><a href="#1-3">1.3 Big Data Technologies: Operating Systems</a></dt>
  <dt><a href="#1-4">1.4 Big Data Technologies: Containers and Controllers</a></dt>
  <dt><a href="#1-5">1.5 Big Data Technologies: Distributed Data Storage</a></dt>
  <dt><a href="#1-6">1.6 Big Data Technologies: Command and Control</a></dt>
  <dt><a href="#1-7">1.7 Big Data Technologies: Data Ingestion, Processing and Output</a></dt>

</dl>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="1-1">1.1 Business Applications and Big Data</a></h2>

Businesses require near real-time insights from ever-larger sets of data. Large-scale data ingestion requires scale-out storage and processing in ways that allow fast response times. In addition to simply querying this data, organizations want full analysis and even predictive capabilities over their data. A few industry examples of applications of technology that create large data sets are:

 <table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 2px; border-color: gray;">

  <tr><th style="background-color: #1b20a1; color: white;">Industry Sector</th> <th style="background-color: #1b20a1; color: white;">Primary Use-Cases</th></tr>

  <tr><td><b>Retail</b></td><td>Demand prediction</td></tr>
  <tr><td></td><td>In-store analytics</td></tr>
  <tr><td></td><td>Supply chain optimization</td></tr>
  <tr><td></td><td>Customer retention</td></tr>
  <tr><td></td><td>Cost/Revenue analytics</td></tr>
  <tr><td></td><td>HR analytics</td></tr>
  <tr><td></td><td>Inventory control</td></tr>
  <tr><td><b>Finance</b></td><td>Cyberattack Prevention</td></tr>
  <tr><td></td><td>Fraud detection</td></tr>
  <tr><td></td><td>Customer segmentation</td></tr>
  <tr><td></td><td>Market analysis</td></tr>
  <tr><td></td><td>Risk analysis</td></tr>
  <tr><td></td><td>Blockchain</td></tr>
  <tr><td></td><td>Customer retention</td></tr>
  <tr><td><b>Healthcare</b></td><td>Fiscal control analytics</td></tr>
  <tr><td></td><td>Disease Prevention prediction and classification</td></tr>
  <tr><td></td><td>Clinical Trials optimization</td></tr>
  <tr><td></td><td>Patient load analysis</td></tr>
  <tr><td></td><td>Episode analytics</td></tr>
  <tr><td><b>Public Sector</b></td><td>Revenue prediction</td></tr>
  <tr><td></td><td>Education effectiveness analysis</td></tr>
  <tr><td></td><td>Transportation analysis and prediction</td></tr>
  <tr><td></td><td>Energy demand and supply prediction and control</td></tr>
  <tr><td></td><td>Defense readiness predictions and threat analysis</td></tr>
  <tr><td><b>Manufacturing</b></td><td>Predictive Maintenance (PdM)</td></tr>
  <tr><td></td><td>Anomaly Detection</td></tr>
  <tr><td></td><td>Pattern analysis</td></tr>
  <tr><td><b>Agriculture</b></td><td>Food Safety analysis</td></tr>
  <tr><td></td><td>Crop forecasting</td></tr>
  <tr><td></td><td>Market forecasting</td></tr>
  <tr><td></td><td>Pipeline Optimization</td></tr>

</table>

While solutions for large-scale data processing exist, they are often batch-based, which has a lag in the time from query to response. Also, batch systems <a href="https://hadoop.apache.org/docs/stable/hadoop-mapreduce-client/hadoop-mapreduce-client-core/MapReduceTutorial.html" target="_blank">such as Hadoop </a>are complicated to set up and manage. Operational data is often stored in Relational Database systems on-premises, and joining that data to larger-scale cloud systems exposes security weaknesses and brittle architectures.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b>Activity: Define Your Use-Case</b></p>

In this activity, you will define the use-case that best fits the industry where you work.

While you will review the design for a complete solution in this workshop, it extrapolates to many other scenarios. You need to find the top scenarios specific your industry.

<b>Steps</b></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png"> Open a web browser and any professional notes or resources you use at work.</p>
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png"> Spend 5 minutes looking online for the terms "Big Data" and "Machine Learning" and "Top" for your industry. For example:  <b>Hospital Big Data Machine Learning Top</b></p>
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png"> Record your findings in your personal workshop notes.</p>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/textbubble.png"> <h2><a name="1-2"><a name="1-2">1.2 Workshop Scenario</a></h2>

This solution uses an example of a retail organization that has multiple data sources, but it has many applications to the other industries listed above. It serves as an end-to-end scenario where you will learn the technologies and processes you can use to create multiple solutions. 

<img style="height: 25;" src="../graphics/WWI-logo.png">

Wide World Importeres (WWI) is a traditional brick and mortar business with a long track record of success, generating profits through strong retail store sales of their unique offering of affordable products from around the world. They have a great training program for new employees, that focuses on connecting with their customers and providing great face-to-face customer service. This strong focus on customer relationships has helped set WWI apart from their competitors. 

WWI has now added web and mobile commerce to their platform, which has generated a significant amount of additional data, and data formats. These new platforms have been added without integrating into the OLTP system data or Business Intelligence infrastructures. As a result, "silos" of data stores have developed.

<img style="height: 150; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" src="../graphics/WWI-001.png">

Now they want to expand their reach to customers around the world through web and mobile e-commerce. But they don't want to just simply make their inventory available online. They want to build upon their track record of strong customer connections, and engage with their customers through personalized, high-quality application experiences that incorporate data and intelligence.

The technology team at WWI has recognized that moving to an omni-channel strategy has quickly outgrown their ability to handle data. They anticipate the following solutions needed to reach more customers and grow the business:

 - Scale data systems to reach more consumers
 - Unlock business insights from multiple sources of structured and unstructured data
 - Apply deep analytics with high-performance responses
 - Enable AI into apps to actively engage with customers

Prior to expanding to their current omni-channel strategy, WWI had a simple Point of Sale (POS) application that handled customer orders at each retail store. The back-end was a series of service layers used to process orders and store them in a SQL database. They had designed their systems and tuned them to handle this level of data.

<img style="height: 150; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" src="../graphics/WWI-002.png">

As they added new e-commerce channels to expand the customer base, consumer demand also increased. This increased demand from more customers ordering products through more channels generated more data. Now WWI has new challenges to address:

 - Increased consumer demand, leading to increased app data
 - They are unable to determine business trends because of siloed insights
 - They have a rising data management footprint, increasing cost and complexity
 - New development challenges resulting from more deployment targets and duplicated code

<br>
<img style="height: 300; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" src="../graphics/WWI-003.png">
<br>

In the <i>04 - Operationalization</i> Module, you'll learn how the team solves each of these challenges.

You can read more about <a href="https://azure-scenarios-experience.azurewebsites.net/big-data.html#the-wide-world-importers-sample-customer-scenario" target="_blank">Wide World Importers here</a>.

<br>
<p style="border-bottom: 1px solid lightgrey;"></p>
<br>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b><a name="aks">Activity: Install Class Environment on AKS</a></b></p>

In this lab you will deploy a BDC to the Azure Kubernetes Service. You will need a client machine and a subscription to Microsoft Azure where you can create assets. This will take some time, so you'll do this now as you work through the next few modules, and then return to the installation process in a later module. 

*NOTE: Your instructor may walk through these steps if the class environment does not have enough resources or time for each person to deploy. If so, they will provide you credentials to work with a pre-configured system in class.*

Using the following steps, you will create a Resource Group in Azure that will hold your BDC on AKS. When you complete your lab you can delete this Resource Group which will stop the Azure charges for this course. 

<p><b>Steps</b></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png"> <a href="https://github.com/Microsoft/sqlworkshops/blob/master/sqlserver2019bigdataclusters/SQL2019BDC/00%20-%20Prerequisites.md" target="_blank">  Ensure that you have completed all prerequisites</a>.</p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png"> <a href="https://docs.microsoft.com/en-us/sql/big-data-cluster/deploy-big-data-tools?view=sqlallproducts-allversions" target="_blank"> Read the following article to install the big data cluster Tools, ensuring that you carefully follow each step</a>. Note that if you followed the pre-requisites properly, you will already have <i>Python</i>, <i>kubectl</i>, and <i>Azure Data Studio</i> installed, so those may be skipped. Follow all other instructions.</p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png"> <a href="https://docs.microsoft.com/en-us/sql/big-data-cluster/quickstart-big-data-cluster-deploy?view=sqlallproducts-allversions" target="_blank"> Read the following article to deploy the bdc to AKS, ensuring that you carefully follow each step</a>. Stop at the section marked <b>Connect to the cluster</b>.</p>
 
<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="1-3">1.3 Big Data Technologies: Operating Systems</a></h2>

In this section you will learn more about the designs of two primary operating systems (Microsoft Windows and Linux) and how they are suited to working with Big Data. 

<i>NOTE: This is not meant to be a comprehensive discussion of the merits of an operating system or ecostructure. The goal is to understand the salient features in each architecture as they pertain to processing large sets of data.</i>

When working with large-scale, distributed data processing systems, there are two primary concepts to keep in mind: You should move as much processing to the data location as possible, and the storage system should be abstracted so that the code does not have to determine where to get its data from each node. Both Windows and Linux have specific attributes to keep in mind as you select hardware, drivers, and configurations for your systems. 

<h3>Storage</h3>

The general rules for storage in a distributed data processing environment are that the disks should be as fast as possible, you should optimize for the best number of nodes that will store and process the data, and that the abstraction system (in the case of BDC, this includes HDFS and relational storage) be at the latest version and optimized settings.

For general concepts for Windows storage see the following resources:

<ul>
    <li><a href="https://social.technet.microsoft.com/wiki/contents/articles/5375.windows-file-systems.aspx?Redirected=true" target="_blank">Understand Windows File Systems</a></li>
    <li><a href="https://docs.microsoft.com/en-us/windows-server/storage/storage" target="_blank">Microsoft primary location for Storage on Windows Server</a></li>
    <li><a href="https://blogs.msdn.microsoft.com/clustering/2018/05/31/scale-out-file-server-improvements-in-windows-server-2019/" target="_blank">Improvements in Windows Server Storage</a></li>
</ul>

In general, Linux treats almost everything as a file system or a process. For general concepts for Linux storage see the following resources:

<ul>
    <li><a href="http://www.tldp.org/LDP/intro-linux/html/sect_03_01.html" target="_blank">Understand the Linux File System</a></li>
    <li><a href="https://www.howtogeek.com/howto/33552/htg-explains-which-linux-file-system-should-you-choose/" target="_blank">The File System options explained</a></li>
    <li><a href="https://www.tecmint.com/fdisk-commands-to-manage-linux-disk-partitions/" target="_blank">Working with the fdisk utility</a></li>
</ul>

<h3>Processor</h3>

Both Windows and Linux (in the x86 architecture) are Symmetric Multiprocessing systems, which means that all processors are addressed as a single unit. In general, distributed processing systems should have larger, and more, processors at the "head" node. General Purpose (GP) processors are normally used in these systems, but for certain uses such as Deep Learning or Artificial Intelligence, Purpose-Built processors such as Graphics Processing Unit (GPU's) are used within the environment, and in some cases,  Advanced RISC Machines (ARM) chips can be brought into play for specific tasks. For the purposes of this workshop, you will not need these latter two technologies, although both Windows and Linux support them.

<i>NOTE: Linux can be installed on chipsets other than x86 compatible systems. In this workshop, you will focus on x86 systems.</i>

<ul>
    <li><a href="https://docs.microsoft.com/en-us/windows/desktop/ProcThread/multitasking" target="_blank">Microsoft Windows and Processors</a></li>
    <li><a href="https://www.tecmint.com/check-linux-cpu-information/" target="_blank">Getting Processor Information using Linux utilities</a></li>
</ul>

<h3>Memory</h3>

Storage Nodes in a distributed processing system need a nominal amount of memory, and the processing nodes in the framework (Spark) included with BDC need more.
Both Linux and Windows support large amounts of memory (most often as much as the system can hold) natively, and no special configuration for memory is needed.

Modern operating systems use a temporary area on storage to act as memory for light caching and also as being able to extend RAM memory. This should be avoided as much as possible in both Windows and Linux.

While technically a Processor system, NUMA (Non-Uniform Memory Access) systems allow for special memory configurations to be mixed in a single server by a processor set. Both Linux and Windows support NUMA access.

<ul>
    <li><a href="https://blogs.technet.microsoft.com/perfguru/2008/01/08/explanation-of-pagefile-usage-as-reported-in-the-task-manager/" target="_blank">Monitoring Page File use in Windows</a></li>
    <li><a href="https://www.linux.com/news/all-about-linux-swap-space" target="_blank">Monitoring the Swap File in Linux</a></li>
</ul>

<h3>Networking</h3>

The general guidance for large-scale distributed processing systems is that the network between them be as fast and collision-free (in the case of TCP/IP) as possible. The networking stacks in both Windows and Linux require no special settings within the operating system, but you should thoroughly understand the driver settings as they apply to each NIC installed in your system, that each setting is best optimized for your networking hardware and topology and that the drivers are at the latest tested versions.

Although a full discussion of the TCP/IP protocol is beyond the scope of this workshop, it's important that you have a good understanding of how it works, since it permeates every part of the BDC architecture. <a href="https://support.microsoft.com/en-us/help/164015/understanding-tcp-ip-addressing-and-subnetting-basics" target="_blank">You can get a quick overview of TCP/IP here</a>.

The other rule you should keep in mind is that in general you should have only the presentation of the data handled by the workstation or device that accesses the solution. Do not move large amounts of data back and forth over the network to have the data processed locally. That being said, there are times (such as certain IoT scenarios) where subsets of data should be moved to the client, but you will not face those scenarios in this workshop. 

<h3>5-Minute Linux Overview for the Windows Professional</h3>

The best way to learn an operating system is to install it and perform real-world tasks. <a href="https://www.edx.org/course/introduction-to-linux" target="_blank">(A good place to learn a lot more about Linux is here</a>). For this workshop, the essential concepts you need from the SQL Server perspective are: 

<table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 2px; border-color: gray;">

  <tr><th style="background-color: #1b20a1; color: white;">Linux Concept</th> <th style="background-color: #1b20a1; color: white;">Description</th></tr>

  <tr><td><b><a href="https://www.howtogeek.com/117579/htg-explains-how-software-installation-package-managers-work-on-linux/" target="_blank">Distributions</a></b></td><td>Unlike Windows, which is written and controlled by Microsoft, Linux is comprised only of a small Kernel, and then all other parts of the operating system are created by commercial entities or the public, and packaged up into a <i>Distribution</i>. These Distributions have all of the complementary functions to the operating system, and in some cases a graphical interface and other files. The Distributions supported by SQL Server are RedHat, Ubuntu, and SuSE.</td></tr>
  <tr><td><b><a href="https://www.howtogeek.com/117579/htg-explains-how-software-installation-package-managers-work-on-linux/" target="_blank">Package Managers</a></b></td><td>Software installation on Linux can be done manually by copying files or compiling source code. A Package Manager is a tool that simplifies this process, and is based on the Distribution. The two package managers you will see most often in SQL Server are <b>yum</b> and <b>apt</b>.</td></tr>
  <tr><td><b><a href="https://www.tecmint.com/explanation-of-everything-is-a-file-and-types-of-files-in-linux/" target="_blank">File Systems</a></b></td><td>Like Windows, organized as a tree, but referenced by a forward-slash <b>/</b>. There are no drive letters in Linux - everything is "mounted" to what looks like a directory.</td></tr>
  <tr><td><b><a href="https://courses.cs.washington.edu/courses/cse484/11au/sections/section6.pdf" target="_blank">Access and Authentication</a></b></td><td>Users and Groups are stored in protected files, called <b>/etc/passwd</b> and <b>/etc/group</b>. These files and locations may be augmented or slightly different based in the distribution. By default, each user has very low privileges and must be granted access to files or directories. The <b>sudo</b> command allows you to run as a privileged user (known as root) or as another user.</td></tr>

</table>

The essential commands you should know for this workshop are below. In Linux you can often send the results of one command to another using the "pipe" symbol, similar to PowerShell: <b>|</b>. 

<table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 2px; border-color: gray;">

  <tr><th style="background-color: #1b20a1; color: white;">Linux Command</th> <th style="background-color: #1b20a1; color: white;">Description</th></tr>

  <tr><td><b><a href="http://www.linfo.org/man.html" target="_blank">man</a></b></td><td>Shows help on a command or concept. You can also add <b>--help</b> to most commands for a quick syntax display. Similar to <b>HELP</b> in Windows.</td></tr>
  <tr><td><b><a href="http://www.linfo.org/cat.html" target="_blank">cat</a></b></td><td>Display File Contents. Similar to <b>TYPE</b> in Windows.</td></tr>
  <tr><td><b><a href="http://www.linfo.org/cd.html" target="_blank">cd</a></b></td><td>Changes Directory. Same as in Windows.</td></tr>
  <tr><td><b><a href="https://linux.die.net/man/1/chgrp" target="_blank">chgrp</a></b></td><td>Change file group access.</td></tr>
  <tr><td><b><a href="http://www.linfo.org/chown.html" target="_blank">chown</a></b></td><td>Change permissions. Similar to <b>CACLS</b> in Windows.</td></tr>
  <tr><td><b><a href="http://www.linfo.org/cp.html" target="_blank">cp</a></b></td><td>Copy source file into destination. Similar to <b>COPY</b> in Windows.</td></tr>
  <tr><td><b><a href="http://www.linfo.org/df.html" target="_blank">df</a></b></td><td>Shows free space on mounted devices. Similar to <b>dir | find "bytes free"</b> in Windows.</td></tr>
  <tr><td><b><a href="http://www.linfo.org/file.html" target="_blank">file</a></b></td><td>Determine file type.</td></tr>
  <tr><td><b><a href="https://linux.die.net/man/1/find" target="_blank">find</a></b></td><td>Find files. Similar to <b>DIR filename /S</b> in Windows.</td></tr>
  <tr><td><b><a href="http://www.linfo.org/grep.html" target="_blank">grep</a></b></td><td>Search files for regular expressions. Similar to <b>FIND</b> in Windows.</td></tr>
  <tr><td><b><a href="http://www.linfo.org/head.html" target="_blank">head</a></b></td><td>Display the first few lines of a file.</td></tr>
  <tr><td><b><a href="http://www.linfo.org/ln.html" target="_blank">ln</a></b></td><td>Create softlink on oldname</td></tr>
  <tr><td><b><a href="https://linux.die.net/man/1/ls" target="_blank">ls</a></b></td><td>Display information about file type. Similar to <b>DIR</b> in Windows.</td></tr>
  <tr><td><b><a href="http://www.linfo.org/mkdir.html" target="_blank">mkdir</a></b></td><td>Create a new directory dirname. Same as in Windows.</td></tr>
  <tr><td><b><a href="https://www.lifewire.com/what-to-know-more-command-4051953" target="_blank">more</a></b></td><td>Display data in paginated form. Same as in Windows. An improved version of this command is <a href="https://www.lifewire.com/what-to-know-less-command-4051972" target="_blank">less</a>.</td></tr>
  <tr><td><b><a href="https://linux.die.net/man/8/mount" target="_blank">mount</a></b></td><td>Makes a drive, network location, and many other objects available to the operating system so that you can work with it.</td></tr>
  <tr><td><b><a href="http://www.linfo.org/mv.html" target="_blank">mv</a></b></td><td>Move (Rename) an oldname to newname. Similar to <b>REN</b> and <b>DEL</b> combined in Windows.</td></tr>
  <tr><td><b><a href="https://wiki.gentoo.org/wiki/Nano/Basics_Guide" target="_blank">nano</a></b></td><td>Create and edit text files.</td></tr>
  <tr><td><b><a href="http://www.linfo.org/pwd.html" target="_blank">pwd</a></b></td><td>Print current working directory.</td></tr>
  <tr><td><b><a href="http://www.linfo.org/rm.html" target="_blank">rm</a></b></td><td>Remove (Delete) filename. Similar to <b>DEL</b> in Windows.</td></tr>
  <tr><td><b><a href="http://www.linfo.org/rmdir.html" target="_blank">rmdir</a></b></td><td>Delete an existing directory provided it is empty. Same as in Windows.</td></tr>  
  <tr><td><b><a href="https://linuxacademy.com/blog/linux/linux-commands-for-beginners-sudo/" target="_blank">sudo</a></b></td><td>Elevate commands that follow to sysadmin privileges.</td></tr>
  <tr><td><b><a href="http://www.linfo.org/tail.html" target="_blank">tail</a></b></td><td>Prints last few lines in a file.</td></tr>
  <tr><td><b><a href="http://www.linfo.org/touch.html" target="_blank">touch</a></b></td><td>Update access and modification time of a file. Similar to <b>ECHO > test.txt</b> in Windows.</td></tr>

</table>

A <a href="https://opensourceforu.com/2016/07/introduction-linux-system-administration/" target="_blank">longer explanation of system administration for Linux is here</a>.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b>Activity: Work with Linux Commands</b></p>

<p><b>Steps</b></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png"><a href="https://bellard.org/jslinux/vm.html?url=https://bellard.org/jslinux/buildroot-x86.cfg" target="_blank">Open this link to run a Linux Emulator in a browser</a></p>
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Find the mounted file systems, and then show the free space in them.</p>
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Show the current directory.</p>
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Show the files in the current directory. </p>
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Create a new directory, navigate to it, and create a file called <i>test.txt</i> with the words <i>This is a test</i> in it. (hint: us the <b>nano</b> editor or the <b>echo</b> command)</p>
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Display the contents of that file.</p>
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Show the help for the <b>cat</b> command.</p>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="1-4">1.4 Big Data Technologies: Containers and Controllers</a></h2>

Bare-metal installations of an operating system such as Windows are deployed on hardware using a <i>Kernel</i>, and additional software to bring all of the hardware into a set of calls. 

<h3>Virtual machines</h3>

One abstraction layer above installing software directly on hardware is using a <i>Hypervisor</i>. In essence, this layer uses the base operating system to emulate hardware. You install an operating system (called a *Guest* OS) on the Hypervisor (called the *Host*), and the Guest OS acts as if it is on bare-metal.

<br>
<img style="height: 300;" src="https://docs.docker.com/images/VM%402x.png">
<br>

In this abstraction level, you have full control (and responsibility) for the entire operating system, but not the hardware. This isolates all process space and provides an entire "Virtual Machine" to applications. For scale-out systems, a Virtual Machine allows for a distribution and control of complete computer environments using only software.

You can <a href="https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs" target="_blank">read the details of Microsoft's Hypervisor here</a>.

<h3>Containers <i>(Docker)</i></h3>

The next level of Abstraction is a <i>Container</i>. There are various types of Container technologies, in this workshop, you will focus on <a href="https://docs.docker.com" target="_blank">Docker</a>.

A Docker Container is provided by the Docker runtime engine, which sits above the operating system (Windows or Linux). In this abstraction, you do not control the hardware <i>or</i> the operating system. The Container has a very small Kernel in it, and can contain binaries such as Python, R, SQL Server, or other binaries. A Container with all its binaries is called an <i>Image</i>. 

<i>(NOTE: The Container Image Kernel can run on Windows or Linux, but you will focus on the Linux Kernel Containers in this workshop.)</i>

<br>
<img style="height: 300;" src="https://docs.docker.com/images/Container%402x.png"> 
<br>

This abstraction holds everything for an application to isolate it from other running processes. It is also completely portable - you can create an image on one system, and another system can run it so long as the Docker Runtime is installed. Containers also start very quickly, are easy to create (called <i>Composing</i>) using a simple text file with instructions of what to install on the image. The instructions pull the base Kernel, and then any binaries you want to install. Several pre-built Containers are already available, SQL Server is one of these. <a href="https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-2017" target="_blank">You can read more about installing SQL Server on Docker here</a>.

You can have several Containers running at any one time, based on the amount of hardware resources where you run it. For scale-out systems, a Container allows for distribution and control of complete applications using only declarative commands.

You can <a href="https://hackernoon.com/docker-commands-the-ultimate-cheat-sheet-994ac78e2888" target="_blank">read more about Docker here</a>. 

<h3>Container Orchestration <i>(Kubernetes)</i></h3>

For Big Data systems, having lots of Containers is very advantageous to segment purpose and performance profiles. However, dealing with many Container Images, allowing persisted storage, and interconnecting them for network and internetwork communications is a complex task. <i>Kubernetes</i> is an open source Container orchestrator, which can scale Container deployments according to need. The following table defines some important Kubernetes terminology:

<table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 5px; border-color: gray;">

  <tr><td style="background-color: AliceBlue; color: black;"><b>Component</b></td><td style="background-color: AliceBlue; color: black;"><b>Used for</b></td></tr>

  <tr><td>Cluster</td><td> A Kubernetes cluster is a set of machines, known as nodes. One node controls the cluster and is designated the master node; the remaining nodes are worker nodes. The Kubernetes master is responsible for distributing work between the workers, and for monitoring the health of the cluster.</td></tr>
  <tr><td style="background-color: AliceBlue; color: black;">Node</td><td td style="background-color: AliceBlue; color: black;"> A node runs containerized applications. It can be either a physical machine or a virtual machine. A Kubernetes cluster can contain a mixture of physical machine and virtual machine nodes.</td></tr>
  <tr><td>Pod</td><td> A pod is the atomic deployment unit of Kubernetes. A pod is a logical group of one or more containers-and associated resources-needed to run an application. Each pod runs on a node; a node can run one or more pods. The Kubernetes master automatically assigns pods to nodes in the cluster.</td></tr>
 
</table>
	
<br> 
<p><img style="height: 400; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);"  src="../graphics/KubernetesCluster.png"></p> 	 	
<br>

You can <a href="https://kubernetes.io/docs/tutorials/kubernetes-basics/" target="_blank">learn much more about Kubernetes here</a>. We're using the Azure Kubernetes Service (AKS) in this workshop, and <a href="https://aksworkshop.io/" target="_blank">they have a great tutorial here</a>.

In SQL Server Big Data Clusters, Kubernetes is responsible for the state of the BDC; Kubernetes builds and configures the cluster Nodes, assigns Pods to Nodes,creates and manages the Persistent Voumes (durable storage) and manages the operation of the cluster.

(You'll cover the storage aspects of Kubernetes clusters in more detail in a moment.)

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b>Activity: Familiarize Yourself with Kubernetes using minikube</b></p>

To practice with Kubernetes, you will use an online emulator to work with the `minikube` platform. 

<p><b>Steps</b></p>
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png"><a href="https://kubernetes.io/docs/tutorials/kubernetes-basics/create-cluster/cluster-interactive/ 
" target="_blank">Open this resource, and complete the first module</a>. (You can return to it later to complete all exercises if you wish)</p>

<br>
<p style="border-bottom: 1px solid lightgrey;"></p>
<br>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="1-5">1.5 Big Data Technologies: Distributed Data Storage</a></h2>

Traditional storage uses a call from the operating system to an underlying I/O system, as you learned earlier. These file systems are either directly connected to the operating system or appear to be connected directly using a Storage Area Network. The blocks of data are stored and managed by the operating system. 

For large scale-out data systems, the mounting point for an I/O is another abstraction. For SQL Server BDC, the most commonly used scale-out file system is the <a href="https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-hdfs/HdfsDesign.html" target="_blank">Hadoop Data File System</a>, or <i>HDFS</i>. HDFS is a set of Java code that gathers disparate disk subsystems into a <i>Cluster</i> which is comprised of various <i>Nodes</i> - a <i>NameNode</i>, which manages the cluster's metadata, and <i>DataNodes</i> that physically store the data. Files and directories are represented on the NameNode by a structure called <i>inodes</i>. Inodes record attributes such as permissions, modification and access times, and namespace and diskspace quotas.

<p><img style="height: 300; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);"  src="../graphics/hdfs.png"></p> 	 	

With an abstraction such as Containers, storage becomes an issue for two reasons: The storage can disappear when the Container is removed, and other Containers and technologies can't access storage easily within a Container. 

To solve this, Docker implemented the concept of <a href="https://docs.docker.com/engine/admin/volumes/" target="_blank">Volumes</a>, and <a href="https://kubernetes.io/docs/concepts/storage/persistent-volumes/" target="_blank">Kubernetes extended this concept</a>. Using <a href="https://github.com/kubernetes/examples/blob/master/staging/volumes/azure_disk/README.md" target="_blank">a specific protocol and command, Kubernetes (and in specific, SQL Server BDC) mounts the storage as a *Persistent Volume* and uses a construct called a *Persistent Volume Claim* to access it</a>. A Kubernetes Volume is a mounted directory which is accessible to the Containers in a Pod within the Node.

You'll cover Volumes in more depth in a future module as you learn how the SQL Server BDC takes advantage of these constructs.

You <a href="https://hadoop.apache.org/docs/r1.2.1/hdfs_design.html#Introduction" target="_blank">can read more about HDFS here</a>.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b>Activity: Review HDFS Tutorial</b></p>

There are two primary storage concepts you will work with in SQL Server Big Data Clusters: the HDFS layer, and SQL Server. Fro HDFS, it's important to know the basics of how it works. 

<p><b>Steps</b></p>
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png"><a href="https://data-flair.training/blogs/hadoop-hdfs-tutorial/" target="_blank">Open this reference, and review the lessons you see there</a>. Bookmark this reference for later review.</p>

<br>
<p style="border-bottom: 1px solid lightgrey;"></p>
<br>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="1-6">1.6 Big Data Technologies: Command and Control</a></h2>

There are three primary tools and utilities you will use to control the SQL Server big data cluster:

 - kubectl
 - azdata
 - Azure Data Studio

<h3>Managing the Kubernetes Cluster<i>(kubectl)</i></h3>

The **kubectl** command accesses the Application Programming Interfaces (API's) from Kubernetes. The utility <a href="https://kubernetes.io/docs/tasks/tools/install-kubectl/" target="_blank">can be installed your workstation using this process</a>, and it is also available in the <a href="https://azure.microsoft.com/en-us/features/cloud-shell/" target="_blank">Azure Cloud Shell with no installation</a>. 

A <a href="https://kubernetes.io/docs/reference/kubectl/cheatsheet/" target="_blank">full list of the **kubectl** commands is here</a>. You can <a href="https://docs.microsoft.com/en-us/sql/big-data-cluster/cluster-troubleshooting-commands?view=sqlallproducts-allversions 
" target="_blank">use these commands for troubleshooting the SQL Server BDC as well</a>. 
 
You'll explore further operations with these tools in the <i>Management and Monitoring</i> module.

<h3>Managing and Monitoring the SQL Server big data cluster <i>(azdata)</i></h3>

The **azdata** command-line utility is written in Python and can be installed on your workstation using the **pip** command in Python. You will see how to install this utility in the *Planning, Installation and Configuration* module.

The **azdata** utility enables cluster administrators to bootstrap and manage big data clusters via the REST APIs exposed by the Controller service. The controller is deployed and hosted in the same Kubernetes namespace where the customer wants to build out a big data cluster. The Controller is responsible for core logic for deploying and managing a big data cluster.

The <a href="https://docs.microsoft.com/en-us/sql/big-data-cluster/concept-controller?view=sqlallproducts-allversions 
" target="_blank">Controller service is installed by a Kubernetes administrator during cluster bootstrap</a>, using the azdata command-line utility. 

You'll explore further operations with these tools in the <i>Management and Monitoring</i> module.

<h3>SQL Server BDC Programming and GUI Surface <i>(Azure Data Studio and Jupyter Notebooks)</i></h3>

<h4>Jupyter Notebooks</h4>

A Jupyter *Notebook* is a web-page-based interface consisting of *Cells* that can contain text (using the Markdown specification) or code. The code depends on the Kernel that has been installed for the Notebook. Traditionally, Python and R Kernels are installed by default. 

*Notebook Servers* run **.ipynb** files (the Notebooks). You can install a Notebook Server locally, remotely, or you can use something like <a href="https://notebooks.azure.com" target="_blank">Azure Notebooks</a> which provides a free, quick, easy way to work with and share Notebooks. (It's all a bit like a specific kind of web server). 

*Libraries* are a container on your Notebook server where you can have Notebooks, code, directories and other files. 

Notebooks are JSON files that contain areas called *Cells*, which have text or code in them. When you double-click a Notebook, the Notebook server renders and can display text or run code, such as R or Python, using a Kernel. Cells can hold text (such as *Markdown*, *HTML*, or *LaTeX*) which you can mix together, or Code. Double-click a Cell in a Notebook to edit it, and then click the "Run" button to render what you typed. Code runs and displays an output below the cell. You can toggle the result for code to show or hide it.

*Markdown* is a simplified markup language for text. Use it for general text and simple graphics. You can <a href="https://www.markdowntutorial.com/" target="_blank">read more about Markdown here</a>, and <a href="https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet" target="_blank">there's a great cheat-sheet on Markdown here</a>. 

You'll use Notebooks within Azure Data Studio to work with Spark, which you'll learn about in a moment. Learn <a href="https://jupyter-notebook.readthedocs.io/en/stable/" target="_blank">more about Jupyter Notebooks here</a>.  

<h4>Azure Data Studio</h4>

*Azure Data Studio* is a cross-platform database tool to manage and program on-premises and cloud data platforms on Windows, MacOS, and Linux. It is extensible, and one of these extensions is how you work with Azure Data Studio code and Jupyter Notebooks. It is built on the Visual Studio Code shell. The editor in Azure Data Studio has Intellisense, code snippets, source control integration, and an integrated terminal. 

If you have not completed the prerequisites for this workshop you can <a href="https://docs.microsoft.com/en-us/sql/azure-data-studio/download?view=sql-server-2017
" target="_blank">install Azure Data Studio from this location</a>, and you will install the Extension to work with SQL Server big data clusters in a future module</a>.

You can <a href="https://docs.microsoft.com/en-us/sql/azure-data-studio/what-is?view=sql-server-2017 
" target="_blank">learn more about Azure Data Studio here</a>.

<br>
<p><img style="height: 300; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);"  src="../graphics/ads.png"></p> 	 	
<br>

You'll explore further operations with the Azure Data Studio in the <i>Operationalization</i> module.

<br>
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b>Activity: Practice with Notebooks</b></p>

<p><b>Steps</b></p>
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png"><a href="https://notebooks.azure.com/BuckWoodyNoteBooks/projects/AzureNotebooks" target="_blank">Open this reference, and review the instructions you see there</a>. You can clone this Notebook to work with it later.</p>

<br>
<p style="border-bottom: 1px solid lightgrey;"></p>
<br>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="1-7">1.7 Big Data Technologies: Data Ingestion, Processing and Output</a></h2>

In any large data system, you will need a way to bring the data in. In some cases, you will edit the data either on the way in, or after it is staged using a process called "Extract, Transform and Load" (ETL) or leave the data "pure" and unaltered (common in Data Science projects), using a process called "Extract, Load and Transform" (ELT). 

In exploring the BDC architecture, you'll learn about three ways that the system interacts with large sets of data:

 - "Virtualize" the data by pushing down the query to the source system (no data is ingested in this scenario)
 - Ingesting data into SQL Server Tables, using the PolyBase feature or into standard SQL Server constructs
 - Loading data into HDFS

In Data Virtualization, no data is brought into storage - it is queried directly from it's source. It's important to think about the network bandwidth per query in this scenario. The next two scenarios do bring data into the system, either into SQL Server tables within the big data cluster or into the HDFS mount points.

In both cases, the first considerations for loading data are source-data locality and network bandwidth, utilization, and predictability of the path to the SQL Server BDC destination. Depending on where the data originates, network bandwidth will play a major part in your loading performance. For source data residing on premises, network throughput performance and predictability can be enhanced with a service such as a dedicated network path or "hot potato routing". You must consider the current average bandwidth, utilization, predictability, and maximum capabilities of your current public Internet-facing, source-to-destination route, regardless of the method you are using.

In this section you'll learn more about working with the last two options for loading data into the SQL Server BDC architecture. In the *Operationalization* module you'll learn more about Data Virtualization, and also see a practical method for working with data ingestion and pipelines. You can use multiple methods to control the pipeline or workflow of your system, depending on the requirements and other parts of the Data Architecture at your location. In general, <a href="https://docs.microsoft.com/en-us/azure/machine-learning/team-data-science-process/overview" target="_blank">you will use the Team Data Science Process</a> to define your objectives, identify and explore data sources, perform any transforms and do any Feature Engineering for Machine Learning, and then Operationalize your solution. 

Next you'll explore the two locations you can store data in the system, and then you'll learn about creating a Pipeline system to standardize and automate the process. In the <i>Operationalization</i> Module you'll see practical examples of each of these. 

<h3>Data Ingestion for SQL Server Data Stores</h3>

For SQL Server tables (regardless of structure), standard ingestion methods work well: 

 - <a href="https://docs.microsoft.com/en-us/sql/tools/bcp-utility?view=sql-server-ver15" target="_blank">The bcp utility</a>
 - <a href="https://docs.microsoft.com/en-us/sql/integration-services/sql-server-integration-services?view=sql-server-ver15" target="_blank">SQL Server Integration Services</a>
 - <a href="https://docs.microsoft.com/en-us/dotnet/framework/data/adonet/sql/bulk-copy-operations-in-sql-server" target="_blank">The SQLBulkCopy class in ADO.NET</a>

In the case of PolyBase, statements can not only <a href="https://docs.microsoft.com/en-us/sql/relational-databases/polybase/data-virtualization?toc=%2fsql%2fbig-data-cluster%2ftoc.json&view=sqlallproducts-allversions" target="_blank">query data</a> from various sources, <a href="https://docs.microsoft.com/en-us/sql/relational-databases/polybase/polybase-queries?view=sql-server-2017#import-data" target="_blank">but also persist them in SQL Server physical tables</a>. 

<h3>Data Ingestion for HDFS</h3>

Since HDFS is a file-system, data transfer is largely a matter of using it as a mount-point. The following methods are generally used, although the platform and location of the HDFS system affects the choices available:

 - If your HDFS mount-point is on-premises, you can use multiple tools to copy or transfer data to it, <a href="https://github.com/Microsoft/hdfs-mount" target="_blank">including mounting it in Linux as a file system</a> 
 - There is also a Network File System (NFS) <a href="https://hadoop.apache.org/docs/r2.4.1/hadoop-project-dist/hadoop-hdfs/HdfsNfsGateway.html" target="_blank">gateway you can install to access the HDFS mount point</a>
 - <a href="https://github.com/EDS-APHP/py-hdfs-mount" target="_blank">Python code use the Fuse library to mount HDFS, allowing you to access the mount point programmatically</a>. 
 - If the HDFS is located in the cloud, each provider has methods for accessing that data. Microsoft Azure has multiple ways of hosting HDFS, and a common method of transferring data to almost any location within Azure is using <a href="https://docs.microsoft.com/en-us/azure/data-factory/v1/data-factory-create-datasets" target="_blank">Azure Data Factory</a>.

<h3>Data Pipelines using <i>Azure Data Factory</i></h3>

As described earlier, you can use various methods to ingest data ad-hoc and as-needed for your two data targets (HDFS and SQL Server Tables. A more holistic archicture is to use a <i>Pipeline</i> system that can define sources, triggers and events, transforms, targets, and has logging and tracking capabilities. The Microsoft Azure Data Factory provides all of the capabilities, and often serves as the mechanism to transfer data to and from on-premises, in-cloud, and other sources and targets. <a href="https://docs.microsoft.com/en-us/azure/data-factory/concepts-pipelines-activities" target="_blank">ADF can serve as a full data pipeline system, as described here</a>. 

<br>
<img style="height: 75;" src="../graphics/adf.png"> 
<br>

A <a href="https://docs.microsoft.com/en-us/azure/data-factory/introduction" target="_blank">full description of Azure Data Factory is here</a>.

<h3>Data Pipelines using <i>Apache Spark</i></h3>

<a href="https://spark.apache.org/" target="_blank">Apache Spark is an analytics engine</a> for large-scale data. It can be used with data stored in HDFS, and has connectors to work with data in SQL Server as well. 

<br>
<p><img style="height: 300; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);"  src="../graphics/spark3.png"></p> 	 	
<br>

While Spark is used for all phases of the data processing lifecycle and can compliment and extend the capabilities of SQL Server, it is also <a href="https://www.perfomatix.com/building-real-time-data-pipeline-using-apache-spark/" target="_blank">often used to ingest and transform data as a data pipeline</a>. An important concept to keep in mind when you ingest data using Spark is that Spark has three main data storage representations it works with once they are ingested:

 - RDD (2011): Distribution of JVM objects, Functional Operators (map, filter, etc)
 - DataFrame (2013): Distribution of Row objects, Expression-based operations and UDF’s, Logical plans and an optimizer, Fast, efficient internal representations
 - Dataset (2015): Internally rows, externally JVM objects – type-safe + fast, Slower than DF’s, not as suited for interactive analysis 

<a href="https://databricks.com/blog/2016/01/04/introducing-apache-spark-datasets.html" target="_blank">You can learn more about these data representations here</a>. You'll see an example of ingesting data using Apache Spark in the <i>Operationalization</i> module.

<br>
<p style="border-bottom: 1px solid lightgrey;"></p>
<br>

<p><img style="margin: 0px 15px 15px 0px;" src="../graphics/owl.png"><b>For Further Study</b></p>
<br>

<ul>
    <li><a href = "https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-what-is?view=sql-server-2017" target="_blank">Official Documentation for this section - Wide World Importers Data Dictionary and company description</a></li>
    <li><a href = "https://www.simplilearn.com/data-science-vs-big-data-vs-data-analytics-article" target="_blank">Understanding the Big Data Landscape</a></li>
    <li><a href = "http://www.admin-magazine.com/Articles/Linux-Essentials-for-Windows-Admins-Part-1" target="_blank">Linux for the Windows Admin</a></li>
    <li><a href = "https://docs.docker.com/v17.09/engine/userguide/" target="_blank">Docker Guide</a></li>
    <li><a href = "https://www.youtube.com/playlist?list=PLLasX02E8BPCrIhFrc_ZiINhbRkYMKdPT" target="_blank">Video introduction to Kubernetes</a></li>
    <li><a href = "https://github.com/vlele/k8onazure" target="_blank">Complete course on Azure Kubernetes Service (AKS)</a></li>
     <li><a href = "https://www.kdnuggets.com/2019/01/practical-apache-spark-10-minutes.html" target="_blank">Working with Spark</a></li>
    <li><a href="https://realpython.com/jupyter-notebook-introduction/" target="_blank">Full tutorial on Jupyter Notebooks</a></li>
</ul>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/geopin.png"><b >Next Steps</b></p>

Next, Continue to <a href="02%20-%20SQL%20Server%20BDC%20Components.md" target="_blank"><i> SQL Server big data cluster Components</i></a>.
