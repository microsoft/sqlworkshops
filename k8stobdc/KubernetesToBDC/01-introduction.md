![](https://github.com/microsoft/sqlworkshops/blob/master/graphics/microsoftlogo.png?raw=true)

# Workshop: Kubernetes - From Bare Metal to SQL Server Big Data Clusters

#### <i>A Microsoft Course from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=true"> 01 - An introduction to Linux, Storage, Containers and Kubernetes </h2>

In this workshop you'll cover using a Process and various Platform components to create a Big Data Cluster for SQL Server solution using Kubernetes that you can deploy on premises, in the cloud, or in a hybrid architecture. In each module you'll get more references, which you should follow up on to learn more. Also watch for links within the text - click on each one to explore that topic. There's a lot here - so focus on understanding the overall system first, then come back and explore each section.

This module covers Container technologies and how they are different than Virtual Machines. Then you'll learn about the need for container orchestration using Kubernetes. We'll start with some computer architecture basics, and introduce the Linux operating system in case you're new to that topic. There are many references and links throughout the module, and a further set of references at the bottom of this module. 

You may now start the Virtual Machine you created in the pre-requisites. You will run all commands from that environment.

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><a name="1-3">1.1 Big Data Technologies: Operating Systems</a></h2>

In this section you will learn more about the design the primary operating system (Linux) used with a Kubernetes Cluster. 

> NOTE: This is not meant to be a comprehensive discussion of the merits of an operating system or ecostructure. The goal is to understand the salient features in each architecture as they pertain to processing large sets of data.

When working with large-scale, distributed data processing systems, there are two primary concepts to keep in mind: You should move as much processing to the data location as possible, and the storage system should be abstracted so that the code does not have to determine where to get its data from each node. Both Windows and Linux have specific attributes to keep in mind as you select hardware, drivers, and configurations for your systems. 

<h3>Storage</h3>

The general rules for storage in a distributed data processing environment are that the disks should be as fast as possible, you should optimize for the best number of nodes that will store and process the data, and that the abstraction system (in the case of BDC, this includes HDFS and relational storage) be at the latest version and optimized settings.

In general, Linux treats almost everything as a file system or a process. For general concepts for Linux storage see the following resources:

<ul>
    <li><a href="http://www.tldp.org/LDP/intro-linux/html/sect_03_01.html" target="_blank">Understand the Linux File System</a></li>
    <li><a href="https://www.howtogeek.com/howto/33552/htg-explains-which-linux-file-system-should-you-choose/" target="_blank">The File System options explained</a></li>
    <li><a href="https://www.tecmint.com/fdisk-commands-to-manage-linux-disk-partitions/" target="_blank">Working with the fdisk utility</a></li>
</ul>

<h3>Processor</h3>

Both Windows and Linux (in the x86 architecture) are *Symmetric Multiprocessing* systems, which means that all processors are addressed as a single unit. In general, distributed processing systems should have larger, and more, processors at the "head" node. General Purpose (GP) processors are normally used in these systems, but for certain uses such as Deep Learning or Artificial Intelligence, Purpose-Built processors such as Graphics Processing Unit (GPU's) are used within the environment, and in some cases,  Advanced RISC Machines (ARM) chips can be brought into play for specific tasks. For the purposes of this workshop, you will not need these latter two technologies, although both Windows and Linux support them.

> NOTE: Linux can be installed on chipsets other than x86 compatible systems. In this workshop, you will focus on x86 systems.

<ul>
    <li><a href="https://www.tecmint.com/check-linux-cpu-information/" target="_blank">Getting Processor Information using Linux utilities</a></li>
</ul>

<h3>Memory</h3>

Storage Nodes in a distributed processing system need a nominal amount of memory, and the processing nodes in the framework (Spark) included with SQL Server big data clusters need much more. Both Linux and Windows support large amounts of memory (most often as much as the system can hold) natively, and no special configuration for memory is needed.

Modern operating systems use a temporary area on storage to act as memory for light caching and also as being able to extend RAM memory. This should be avoided as much as possible in both Windows and Linux.

While technically a Processor system, [NUMA (Non-Uniform Memory Access) systems](https://www.kernel.org/doc/html/latest/vm/numa.html) allow for special memory configurations to be mixed in a single server by a processor set. Both Linux and Windows support NUMA access.

<ul>
    <li><a href="https://www.linux.com/news/all-about-linux-swap-space" target="_blank">Monitoring the Swap File in Linux</a></li>
</ul>

<h3>Networking</h3>

The general guidance for large-scale distributed processing systems is that the network between them be as fast and collision-free (in the case of TCP/IP) as possible. The networking stacks in both Windows and Linux require no special settings within the operating system, but you should thoroughly understand the driver settings as they apply to each NIC installed in your system, that each setting is best optimized for your networking hardware and topology and that the drivers are at the latest tested versions.

Although a full discussion of the TCP/IP protocol is beyond the scope of this workshop, it's important that you have a good understanding of how it works, since it permeates every part of a Kubernetes architecture. <a href="https://support.microsoft.com/en-us/help/164015/understanding-tcp-ip-addressing-and-subnetting-basics" target="_blank">You can get a quick overview of TCP/IP here</a>.

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

The essential commands you should know for this workshop are listed below, with links to learn more. In Linux you can often send the results of one command to another using the "pipe" symbol, similar to PowerShell: <b>|</b>. 

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

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: Work with Linux Commands</b></p>

<p><b>Steps</b></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><a href="https://bellard.org/jslinux/vm.html?url=https://bellard.org/jslinux/buildroot-x86.cfg" target="_blank">Open this link to run a Linux Emulator in a browser</a></p>
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true">Find the mounted file systems, and then show the free space in them.</p>
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true">Show the current directory.</p>
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true">Show the files in the current directory. </p>
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true">Create a new directory, navigate to it, and create a file called <i>test.txt</i> with the words <i>This is a test</i> in it. (hint: us the <b>nano</b> editor or the <b>echo</b> command)</p>
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true">Display the contents of that file.</p>
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true">Show the help for the <b>cat</b> command.</p>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><a name="1-4">1.2 Big Data Technologies: Containers and Controllers</a></h2>

Bare-metal installations of an operating system such as Windows are deployed on hardware using a <i>Kernel</i>, and additional software to bring all of the hardware into a set of calls. 

<h3>Virtual machines</h3>

One abstraction layer above installing software directly on hardware is using a <i>Hypervisor</i>. In essence, this layer uses the base operating system to emulate hardware. You install an operating system (called a *Guest* OS) on the Hypervisor (called the *Host*), and the Guest OS acts as if it is on bare-metal.

<br>
<img style="height: 300;" src="https://docs.docker.com/images/VM%402x.png?raw=true">
<br>

In this abstraction level, you have full control (and responsibility) for the entire operating system, but not the hardware. This isolates all process space and provides an entire "Virtual Machine" to applications. For scale-out systems, a Virtual Machine allows for a distribution and control of complete computer environments using only software.

You can <a href="https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs" target="_blank">read the details of Microsoft's Hypervisor here</a>, and [the VMWare approach is detailed here](https://docs.vmware.com/en/VMware-vSphere/6.7/com.vmware.vsphere.vcenterhost.doc/GUID-302A4F73-CA2D-49DC-8727-81052727A763.html). Another popular Hypervisor is [VirtualBox, which you can read more about here](https://www.virtualbox.org/manual/UserManual.html). 

<h3>Containers <i>(Docker)</i></h3>

The next level of Abstraction is a <i>Container</i>. There are various types of Container technologies, in this workshop, you will focus on the docker container format, as implemented in the <a href="https://mobyproject.org/" target="_blank">Moby framework</a>.

A Container is provided by the Container Runtime (Such as [containerd](https://containerd.io/)]) runtime engine, which sits on the operating system (Windows or Linux). In this abstraction, you do not control the hardware <i>or</i> the operating system. In general, you create a manifest (in the case of Docker a "dockerfile") which is a text file containing the binaries, code, files or other assets you want to run in a Container. You then "build" that file into a binary object called an "Image", which you can then store in a "Repository". Now you can use the runtime commands to download (pull) that Image from the Repository and run it on your system. This running, protected memory space is now a "Container". 

> NOTE: The Container service runs natively on Linux, but in Windows it often runs in a Virtual Machine environment running Linux as a VM. So in Windows you may see several layers of abstraction for Containers to run.

<br>
<img style="height: 300;" src="https://docs.docker.com/images/Container%402x.png?raw=true"> 
<br>

This abstraction holds everything for an application to isolate it from other running processes. It is also completely portable - you can create an image on one system, and another system can run it so long as the Container Runtimes (Such as Docker) Runtime is installed. Containers also start very quickly, are easy to create (called <i>Composing</i>) using a simple text file with instructions of what to install on the image. The instructions pull the base Kernel, and then any binaries you want to install. Several pre-built Containers are already available, SQL Server is one of these. <a href="https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-2017" target="_blank">You can read more about installing SQL Server on Container Runtimes (Such as Docker) here</a>.

You can have several Containers running at any one time, based on the amount of hardware resources where you run it. For scale-out systems, a Container allows for distribution and control of complete applications using only declarative commands.

You can <a href="https://hackernoon.com/docker-commands-the-ultimate-cheat-sheet-994ac78e2888" target="_blank">read more about Container Runtimes (Such as Docker) here</a>. 

<h3>Container Orchestration <i>(Kubernetes)</i></h3>

For Big Data systems, having lots of Containers is very advantageous to segment purpose and performance profiles. However, dealing with many Container Images, allowing persisted storage, and interconnecting them for network and internetwork communications is a complex task. One such Container Orchestration tool is <i>Kubernetes</i>, an open source Container orchestrator, which can scale Container deployments according to need. The following table defines some important Container Orchestration Tools (Such as Kubernetes or OpenShift) terminology:

<table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 5px; border-color: gray;">

  <tr><td style="background-color: AliceBlue; color: black;"><b>Component</b></td><td style="background-color: AliceBlue; color: black;"><b>Used for</b></td></tr>

  <tr><td>Cluster</td><td> Container Orchestration (Such as Kubernetes or OpenShift) cluster is a set of machines, known as Nodes. One node controls the cluster and is designated the master node; the remaining nodes are worker nodes. The Container Orchestration *master* is responsible for distributing work between the workers, and for monitoring the health of the cluster.</td></tr>
  <tr><td style="background-color: AliceBlue; color: black;">Node</td><td td style="background-color: AliceBlue; color: black;"> A Node runs containerized applications. It can be either a physical machine or a virtual machine. A Cluster can contain a mixture of physical machine and virtual machines as Nodes.</td></tr>
  <tr><td>Pod</td><td> A Pod is the atomic deployment unit of a Cluster. A pod is a logical group of one or more Containers and associated resources needed to run an application. Each Pod runs on a Node; a Node can run one or more Pods. The Cluster master automatically assigns Pods to Nodes in the Cluster.</td></tr>
 
</table>
	
<br> 
<p><img style="height: 400; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);"  src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/KubernetesCluster.png?raw=true"></p> 	 	
<br>

You can <a href="https://kubernetes.io/docs/tutorials/kubernetes-basics/" target="_blank">learn much more about Container Orchestration systems here</a>. We're using the Azure Kubernetes Service (AKS) as a backup in this workshop, and <a href="https://aksworkshop.io/" target="_blank">they have a great set of tutorials for you to learn more here</a>.

In SQL Server Big Data Clusters, the Container Orchestration system (Such as Kubernetes or OpenShift) is responsible for the state of the BDC; it is responsible for building and configuring the Nodes, assigns Pods to Nodes,creates and manages the Persistent Volumes (durable storage), and manages the operation of the Cluster.

> NOTE: The OpenShift Container Platform is a commercially supported Platform as a Service (PaaS) based on Kubernetes from RedHat. Many shops require a commercial vendor to implement and support Kubernetes. 

(You'll cover the storage aspects of Container Orchestration in more detail in a moment.)

All of this orchestration is controlled by another set of text files, called "Manifests", which you will learn more about in the Modules that follow. You declare the state of the layout, networking, storage, redundancy and more in these files, load them to the Kubernetes environment, and it is responsible for instantiating and maintaining a Cluster with that configuration. 

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: Familiarize Yourself with Container Orchestration using minikube</b></p>

To practice with Kubernetes, you will use an online emulator to work with the `minikube` platform. This is a small Virtual Machine with a single Node acting as a full Cluster. 

<p><b>Steps</b></p>
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><a href="https://kubernetes.io/docs/tutorials/kubernetes-basics/create-cluster/cluster-interactive/ 
" target="_blank">Open this resource, and complete the first module</a>. (You can return to it later to complete all exercises if you wish)</p>

<br>
<p style="border-bottom: 1px solid lightgrey;"></p>
<br>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><a name="1-5">1.3 Big Data Technologies: Distributed Data Storage</a></h2>

Traditional storage uses a call from the operating system to an underlying I/O system, as you learned earlier. These file systems are either directly connected to the operating system or appear to be connected directly using a Storage Area Network. The blocks of data are stored and managed by the operating system. 

For large scale-out data systems, the mounting point for an I/O is another abstraction. For SQL Server BDC, the most commonly used scale-out file system is the <a href="https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-hdfs/HdfsDesign.html" target="_blank">Hadoop Data File System</a>, or <i>HDFS</i>. HDFS is a set of Java code that gathers disparate disk subsystems into a <i>Cluster</i> which is comprised of various <i>Nodes</i> - a <i>NameNode</i>, which manages the cluster's metadata, and <i>DataNodes</i> that physically store the data. Files and directories are represented on the NameNode by a structure called <i>inodes</i>. Inodes record attributes such as permissions, modification and access times, and namespace and disk space quotas.

<p><img style="height: 300; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);"  src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/hdfs.png?raw=true"></p> 	 	

With an abstraction such as Containers, storage becomes an issue for two reasons: The storage can disappear when the Container is removed, and other Containers and technologies can't access storage easily within a Container. 

To solve this, Container Runtimes (Such as docker) implemented the concept of <a href="https://docs.docker.com/engine/admin/volumes/" target="_blank">Volumes</a>, and <a href="https://kubernetes.io/docs/concepts/storage/persistent-volumes/" target="_blank">Container Orchestration systems extended this concept</a>. Using <a href="https://github.com/kubernetes/examples/blob/master/staging/volumes/azure_disk/README.md" target="_blank">a specific protocol and command, the Container Orchestration system (and in specific, SQL Server BDC) mounts the storage as a *Persistent Volume* and uses a construct called a *Persistent Volume Claim* to access it</a>. A Container Volume is a mounted directory which is accessible to the Containers in a Pod within the Node.

You'll cover Volumes in more depth in a future module as you learn how the SQL Server BDC takes advantage of these constructs.

You <a href="https://hadoop.apache.org/docs/r1.2.1/hdfs_design.html#Introduction" target="_blank">can read more about HDFS here</a>.

<br>
<p style="border-bottom: 1px solid lightgrey;"></p>
<br>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><a name="1-6">1.4 Big Data Technologies: Command and Control</a></h2>

There are three primary tools and utilities you will use to control the SQL Server big data cluster:

 - kubectl
 - azdata (Not covered in this course)
 - Azure Data Studio (Used for the final Module)

<h3>Managing the Container Orchestration Cluster<i>(cmd-line tools)</i></h3>

The **kubectl** command accesses the Application Programming Interfaces (API's) from Kubernetes (other clustering systems may have different command line tools). The utility <a href="https://kubernetes.io/docs/tasks/tools/install-kubectl/" target="_blank">can be installed your workstation using this process</a>, and it is also available in the <a href="https://azure.microsoft.com/en-us/features/cloud-shell/" target="_blank">Azure Cloud Shell with no installation</a>. 

A <a href="https://kubernetes.io/docs/reference/kubectl/cheatsheet/" target="_blank">full list of the **kubectl** commands is here</a>. You can <a href="https://docs.microsoft.com/en-us/sql/big-data-cluster/cluster-troubleshooting-commands?view=sqlallproducts-allversions 
" target="_blank">use these commands for troubleshooting the SQL Server BDC as well</a>. 
 
You'll explore further operations with these tools in the rest of the course.

<h4>Azure Data Studio</h4>

*Azure Data Studio* is a cross-platform database tool to manage and program on-premises and cloud data platforms on Windows, MacOS, and Linux. It is extensible, and one of these extensions is how you work with Azure Data Studio code and Jupyter Notebooks. It is built on the Visual Studio Code shell. The editor in Azure Data Studio has Intellisense, code snippets, source control integration, and an integrated terminal. 

If you have not completed the prerequisites for this workshop you can <a href="https://docs.microsoft.com/en-us/sql/azure-data-studio/download?view=sql-server-2017
" target="_blank">install Azure Data Studio from this location</a>, and you will install the Extension to work with SQL Server big data clusters in a future module</a>.

You can <a href="https://docs.microsoft.com/en-us/sql/azure-data-studio/what-is?view=sql-server-2017" target="_blank">learn more about Azure Data Studio here</a>.

<br>
<p><img style="height: 300; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);"  src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/ads.png?raw=true"></p> 	 	
<br>

You'll explore further operations with the Azure Data Studio in the final module of this course.

<br>
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: Practice with Notebooks</b></p>

<p><b>Steps</b></p>
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><a href="https://notebooks.azure.com/BuckWoodyNoteBooks/projects/AzureNotebooks" target="_blank">Open this reference, and review the instructions you see there</a>. You can clone this Notebook to work with it later.</p>

<br>
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: Azure Data Studio Notebooks Overview</b></p>

<p><b>Steps</b></p>
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><a href="https://docs.microsoft.com/en-us/sql/azure-data-studio/sql-notebooks?view=sql-server-2017" target="_blank">Open this reference, and read the tutorial - you do not have to follow the steps, but you can if time permits.</p>

<br>
<p style="border-bottom: 1px solid lightgrey;"></p>
<br>

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/owl.png?raw=true"><b>For Further Study</b></p>
<br>

<ul>
    <li><a href = "https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-what-is?view=sql-server-2017" target="_blank">Official Documentation for this section - Wide World Importers Data Dictionary and company description</a></li>
    <li><a href = "https://www.simplilearn.com/data-science-vs-big-data-vs-data-analytics-article" target="_blank">Understanding the Big Data Landscape</a></li>
    <li><a href = "http://www.admin-magazine.com/Articles/Linux-Essentials-for-Windows-Admins-Part-1" target="_blank">Linux for the Windows Admin</a></li>
    <li><a href = "https://docs.docker.com/v17.09/engine/userguide/" target="_blank">Container Runtimes (Such as Docker) Guide</a></li>
    <li><a href = "https://www.youtube.com/playlist?list=PLLasX02E8BPCrIhFrc_ZiINhbRkYMKdPT" target="_blank">Video introduction to Kubernetes</a></li>
    <li><a href = "https://github.com/vlele/k8onazure" target="_blank">Complete course on the Azure Kubernetes Service (AKS)</a></li>
     <li><a href = "https://www.kdnuggets.com/2019/01/practical-apache-spark-10-minutes.html" target="_blank">Working with Spark</a></li>
    <li><a href="https://realpython.com/jupyter-notebook-introduction/" target="_blank">Full tutorial on Jupyter Notebooks</a></li>
</ul>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/geopin.png?raw=true"><b >Next Steps</b></p>

Next, Continue to <a href="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/KubernetesToBDC/02-hardware.md" target="_blank"><i> 02 - Hardware and Virtualization environment for Kubernetes	</i></a>.
