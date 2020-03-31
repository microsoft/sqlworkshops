![](https://github.com/microsoft/sqlworkshops-k8stobdc/blob/master/graphics/microsoftlogo.png?raw=true)

# Workshop: Kubernetes - From Bare Metal to SQL Server Big Data Clusters

#### <i>A Microsoft Course from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=true"><b>     About this Workshop</b></h2>

Welcome to this Microsoft solutions workshop on *Kubernetes - From Bare Metal to SQL Server Big Data Clusters*. In this workshop, you'll learn about setting up a production-grade SQL Server 2019 big data cluster environment on Kubernetes. Topics covered include: hardware, virtualization, and Kubernetes, with a full deployment of SQL Server's Big Data Cluster on the environment that you will use in the class. You'll then walk through a set of [Jupyter Notebooks](https://jupyter-notebook-beginner-guide.readthedocs.io/en/latest/what_is_jupyter.html) in Microsoft's [Azure Data Studio](https://docs.microsoft.com/en-us/sql/azure-data-studio/what-is?view=sql-server-ver15) tool to run T-SQL, Spark, and Machine Learning workloads on the cluster. You'll also receive valuable resources to learn more and go deeper on Linux, Containers, Kubernetes and SQL Server big data clusters.

The focus of this workshop is to understand the hardware, software, and environment you need to work with [SQL Server 2019's big data clusters](https://docs.microsoft.com/en-us/sql/big-data-cluster/big-data-cluster-overview?view=sql-server-ver15) on a Kubernetes platform.

You'll start by understanding Containers and Kubernetes, moving on to a discussion of the hardware and software environment for Kubernetes, and then to more in-depth Kubernetes concepts. You'll follow-on with the SQL Server 2019 big data clusters architecture, and then how to use the entire system in a practical application, all with a focus on how to extrapolate what you have learned to create other solutions for your organization.

> NOTE: This course is designed to be taught in-person with hardware or virtual environments provided by the instructional team. You will also get details for setting up your own hardware, virtual or Cloud environments for Kubernetes for a workshop backup or if you are not attending in-person. 

This [github README.MD file](https://lab.github.com/githubtraining/introduction-to-github) explains how the workshop is laid out, what you will learn, and the technologies you will use in this solution.

(You can view all of the [source files for this workshop on this github site, along with other workshops as well. Open this link in a new tab to find out more.](https://github.com/microsoft/sqlworkshops-k8stobdc))

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>     Learning Objectives</b></h2>

In this workshop you'll learn:
<br>

- How Containers and Kubernetes work and when and where you can use them
- Hardware considerations for setting up a production Kubernetes Cluster on-premises
- Considerations for Virtual and Cloud-based environments for production Kubernetes Cluster

The concepts and skills taught in this workshop form the starting points for:
   
   Solution Architects, to understand how to design an end-to-end solution.
   System Administrators, Database Administrators, or Data Engineers, to understand how to put together an end-to-end solution.

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/building1.png?raw=true"><b>     Business Applications of this Workshop</b></h2>

Businesses require stable, secure environments at scale, which work in secure on-premises and in-cloud configurations. Using Kubernetes and Containers allows for manifest-driven DevOps practices, which further streamline IT processes.

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/listcheck.png?raw=true"><b>     Technologies used in this Workshop</b></h2>

The solution includes the following technologies - although you are not limited to these, they form the basis of the workshop. At the end of the workshop you will learn how to extrapolate these components into other solutions. You will cover these at an overview level, with references to much deeper training provided.

 <table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 2px; border-color: gray;">

  <tr><th style="background-color: #1b20a1; color: white;">Technology</th> <th style="background-color: #1b20a1; color: white;">Description</th></tr>

<tr><td><i>Linux</i></td><td>The primary operating system used in and by Containers and Kubernetes</td></tr>
<tr><td><i>Containers</i></td><td>The atomic layer of a Kubernetes Cluster</td></tr>
<tr><td><i>Kubernetes</i></td><td>The primary clustering technology for manifest-driven environments</td></tr>
  <tr><td>SQL Server Big Data Clusters</td><td>Relational and non-relational data at scale with Spark, HDFS and application deployment capabilities</td></tr>

</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/owl.png?raw=true"><b>     Before Taking this Workshop</b></h2>

There are a few requirements for attending the workshop, listed below: 
- You'll need a local system that you are able to install software on. The workshop demonstrations use Microsoft Windows as an operating system and all examples use Windows for the workshop. Optionally, you can use a Microsoft Azure Virtual Machine (VM) to install the software on and work with the solution.
- You must have a Microsoft Azure account with the ability to create assets for the "backup" or self-taught path.
- This workshop expects that you understand computer technologies, networking, the basics of SQL Server, HDFS, Spark, and general use of Hypervisors. 
- The **Setup** section below explains the steps you should take prior to coming to the workshop

If you are new to any of these, here are a few references you can complete prior to class:

-  [Microsoft SQL Server Administration and Use](https://www.microsoft.com/en-us/learning/course.aspx?cid=OD20764)
-  [HDFS](https://data-flair.training/blogs/hadoop-hdfs-tutorial/)
-  [Spark](https://www.edx.org/course/implementing-predictive-analytics-with-spark-in-az)
-  [Hypervisor Technologies - Hyper-V](https://docs.microsoft.com/en-us/windows-server/virtualization/hyper-v/hyper-v-technology-overview)
or
-  [Hypervisor Technologies - VMWare](https://tsmith.co/free-vmware-training/)

<h3><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/bulletlist.png?raw=true"><b>     Setup</b></h3>

<a href="https://github.com/microsoft/sqlworkshops-k8stobdc/blob/master/KubernetesToBDC/00-prerequisites.md" target="_blank">A full pre-requisites document is located here</a>. These instructions should be completed before the workshop starts, since you will not have time to cover these in class. <i>Remember to turn off any Virtual Machines from the Azure Portal when not taking the class so that you do incur charges (shutting down the machine in the VM itself is not sufficient)</i>.

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/education1.png?raw=true"><b>     Workshop Details</b></h2>

This workshop uses Kubernetes to deploy a workload, with a focus on Microsoft SQL Server's big data clusters deployment for advanced analytics over large sets of data and Data Science workloads.

<table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 5px; border-color: gray;">

  <tr><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Primary Audience:</td><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Technical processionals  tasked with configuring, deploying and managing large-scale clustering systems</td></tr>
  <tr><td>Secondary Audience:</td><td> Data professionals tasked with working with data at scale</td></tr>
  <tr><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Level: </td><td style="background-color: Cornsilk; color: black; padding: 5px 5px0;"> 300 </td></tr>
  <tr><td>Type:</td><td> In-Person (self-guided possible)</td></tr>
  <tr><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Length: </td><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">8</td></tr>

</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pinmap.png?raw=true"><b>     Related Workshops</b></h2>

 - [50 days from zero to hero with Kubernetes](https://azure.microsoft.com/mediahandler/files/resourcefiles/kubernetes-learning-path/Kubernetes%20Learning%20Path%20version%201.0.pdf)

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/bookpencil.png?raw=true"><b>     Workshop Modules</b></h2>

This is a modular workshop, and in each section, you'll learn concepts, technologies and processes to help you complete the solution.

<table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 5px; border-color: gray;">

  <tr><td style="background-color: AliceBlue; color: black;"><b>Module</b></td><td style="background-color: AliceBlue; color: black;"><b>Topics</b></td></tr>

  <tr><td><a href="https://github.com/microsoft/sqlworkshops-k8stobdc/blob/master/KubernetesToBDC/01-introduction.md" target="_blank">01 - An introduction to Linux, Containers and Kubernetes </a></td><td> This module covers Container technologies and how they are different than Virtual Machines. You'll learn about the need for container orchestration using Kubernetes.</td></tr>
  <tr><td style="background-color: AliceBlue; color: black;"><a href="https://github.com/microsoft/sqlworkshops-k8stobdc/blob/master/KubernetesToBDC/02-hardware.md" target="_blank">02 - Hardware and Virtualization environment for Kubernetes</a> </td><td td style="background-color: AliceBlue; color: black;"> This module explains how to make a production-grade environment using "bare metal" computer hardware or with a virtualized platform, and most importantly the storage hardware aspects.</td></tr>
  <tr><td><a href="https://github.com/microsoft/sqlworkshops-k8stobdc/blob/master/KubernetesToBDC/03-kubernetes.md" target="_blank">03 - Kubernetes Concepts and Implementation</a></td><td> Covers deploying Kubernetes, Kubernetes contexts, cluster troubleshooting and management, services: load balancing versus node ports, understanding storage from a Kubernetes perspective and making your cluster secure.</td></tr>
  <tr><td style="background-color: AliceBlue; color: black;"><a href="https://github.com/microsoft/sqlworkshops-k8stobdc/blob/master/KubernetesToBDC/04-bdc.md" target="_blank">04 - SQL Server Big Data Clusters Architecture</a> </td><td td style="background-color: AliceBlue; color: black;"> This module will dig deep into the anatomy of a big data cluster by covering topics that include: the data pool, storage pool, compute pool and cluster control plane, active directory integration, development versus production configurations and the tools required for deploying and managing a big data cluster.</td></tr>  <tr><td><a href="https://github.com/microsoft/sqlworkshops-k8stobdc/blob/master/KubernetesToBDC/05-datascience.md" target="_blank">05 - Using the SQL Server big data cluster on Kubernetes for Data Science</a></td><td> Now that your big data cluster is up, it's ready for data science workloads. This Jupyter Notebook and Azure Data Studio based module will cover the use of python and PySpark, T-SQL and the execution of Spark and Machine Learning workloads.</td></tr>

</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/geopin.png?raw=true"><b>     Next Steps</b></h2>


Next, Continue to <a href="https://github.com/microsoft/sqlworkshops-k8stobdc/blob/master/KubernetesToBDC/00-prerequisites.md" target="_blank"><i> Pre-Requisites</i></a>

**Workshop Authors and Contributors**

- [The Microsoft SQL Server Team](http://microsoft.com/sql)
- [Chris Adkin](https://www.linkedin.com/in/wollatondba/), Pure Storage

**Legal Notice**

*Kubernetes and the Kubernetes logo are trademarks or registered trademarks of The Linux Foundation. in the United States and/or other countries. The Linux Foundation and other parties may also have trademark rights in other terms used herein. This Workshop is not certified, accredited, affiliated with, nor endorsed by Kubernetes or The Linux Foundation.*