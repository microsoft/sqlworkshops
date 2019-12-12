![](https://github.com/microsoft/sqlworkshops/blob/master/graphics/microsoftlogo.png?raw=true)

# Workshop: Kubernetes - From Bare Metal to SQL Server Big Data Clusters

#### <i>A Microsoft Course from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=true"><b>     About this Workshop</b></h2>

Welcome to this Microsoft solutions workshop on *<TODO: Enter workshop name>*. In this workshop, you'll learn about setting up a production grade SQL Server 2019 big data cluster environment on Kubernetes. Topics covered will include: hardware, virtualization, and Kubernetes, with a full deployment of SQL Server's Big Data Cluster on the environment that you will use in the class. You'll then walk through a set of Jupyter Notebooks in Azure Data Studio to run T-SQL, Spark, and Machine Learning workloads on the cluster. You'll also receive valuable resources to learn more and go deeper on Linux, Containers, Kubernetes and SQL Server big data clusters.

The focus of this workshop is to understand <TODO: Describe the workshop's primary focus in one sentence>

You'll start by <TODO: Describe what the flow of the workshop will be>, with a focus on how to extrapolate what you have learned to create other solutions for your organization.

This README.MD file explains how the workshop is laid out, what you will learn, and the technologies you will use in this solution.

(You can view all of the [source files for this workshop on this github site, along with other workshops as well. Open this link in a new tab to find out more.](https://github.com/BuckWoody/workshops))

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>     Learning Objectives</b></h2>

In this workshop you'll learn:
<br>

- <TODO: Bullet-point on learning objective>
- <TODO: Bullet-point on learning objective>
- <TODO: Bullet-point on learning objective>

<TODO: Enter the text you use when you submit the description for this course to a presentation, or advertising>

The goal of this workshop is to train <TODO: Describe who you would train for this and why>.

The concepts and skills taught in this workshop form the starting points for:

    <TODO: Job Description and level of person who is the primary that should attend and the reason>.
    For instance: Solution Architects and Developers, to understand how to put together an end to end solution.
    <TODO: Job Description and level of person who is the secondary that should attend and the reason>.
    <TODO: Job Description and level of person who is the third-level of who might want to attend and the reason>.

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/building1.png?raw=true"><b>     Business Applications of this Workshop</b></h2>

Businesses require <TODO: Describe the reason the student's business or organization would be interested in the information. Be detailed about the solutions it addresses> 

Some industry examples of <TODO: Workshop Topic> are <TODO: Enter Sectors and use briefly>, to name just a few.

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/listcheck.png?raw=true"><b>     Technologies used in this Workshop</b></h2>

The solution includes the following technologies - although you are not limited to these, they form the basis of the workshop. At the end of the workshop you will learn how to extrapolate these components into other solutions. You will cover these at an overview level, with references to much deeper training provided.

 <table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 2px; border-color: gray;">

  <tr><th style="background-color: #1b20a1; color: white;">Technology</th> <th style="background-color: #1b20a1; color: white;">Description</th></tr>

  <tr><td><i>TODO: Technology name not owned by Microsoft that you will cover</i></td><td>TODO: Reason the student needs to learn it</td></tr>
  <tr><td>TODO: Technology name owned by Microsoft that you will cover</td><td>TODO: Reason the student needs to learn it</td></tr>

</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/owl.png?raw=true"><b>     Before Taking this Workshop</b></h2>

You'll need a local system that you are able to install software on. The workshop demonstrations use Microsoft Windows as an operating system and all examples use Windows for the workshop. Optionally, you can use a Microsoft Azure Virtual Machine (VM) to install the software on and work with the solution.

You must have a Microsoft Azure account with the ability to create assets.

This workshop expects that you understand <TODO: Enter a brief solution for what a student should know before taking the workshop>.

If you are new to these, here are a few references you can complete prior to class:

-  [Microsoft SQL Server Administration and Use](https://url)
-  [Machine Learning](https://url)
-  [HDFS](https://url)
-  [Spark](https://url)
-  [Hypervisor Technologies - Hyper-V](https://url)
or
-  [Hypervisor Technologies - VMWare](https://url)

<h3><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/bulletlist.png?raw=true"><b>     Setup</b></h3>

<a href="url" target="_blank">A full pre-requisites document is located here</a>. These instructions should be completed before the workshop starts, since you will not have time to cover these in class. <i>Remember to turn off any Virtual Machines from the Azure Portal when not taking the class so that you do incur charges (shutting down the machine in the VM itself is not sufficient)</i>.

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/education1.png?raw=true"><b>     Workshop Details</b></h2>

This workshop uses <TODO: enter main technologies used to solve the sceanrio>, with a focus on <TODO: architecture and implementation, development and use, etc>.

<table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 5px; border-color: gray;">

  <tr><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Primary Audience:</td><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">TODO: Enter the technical people who will take the workshop> tasked with TODO: Enter what they are tasked to do</td></tr>
  <tr><td>Secondary Audience:</td><td> TODO: Secondary Audience</td></tr>
  <tr><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Level: </td><td style="background-color: Cornsilk; color: black; padding: 5px 5px0;"> TODO: 100, 200, 300, 400 </td></tr>
  <tr><td>Type:</td><td>TODO: In-Person, On-Line, or from github</td></tr>
  <tr><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Length: </td><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">TODO: Number of hours</td></tr>

</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pinmap.png?raw=true"><b>     Related Workshops</b></h2>

 - [TODO: Enter any other workshops that help in this area](url)

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/bookpencil.png?raw=true"><b>     Workshop Modules</b></h2>

This is a modular workshop, and in each section, you'll learn concepts, technologies and processes to help you complete the solution.

<table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 5px; border-color: gray;">

  <tr><td style="background-color: AliceBlue; color: black;"><b>Module</b></td><td style="background-color: AliceBlue; color: black;"><b>Topics</b></td></tr>

  <tr><td><a href="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/KubernetesToBDC/01-introduction.md" target="_blank">01 - An introduction to Linux, Containers and Kubernetes </a></td><td> This module covers Container technologies and how they are different than Virtual Machines. You'll learn about the need for container orchestration using Kubernetes.</td></tr>
  <tr><td style="background-color: AliceBlue; color: black;"><a href="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/KubernetesToBDC/02-hardware.md" target="_blank">02 - Hardware and Virtualization environment for Kubernetes</a> </td><td td style="background-color: AliceBlue; color: black;"> This module explains how to make a production-grade environment using "bare metal" computer hardware or with a virtualized platform, and most importantly the storage hardware aspects.</td></tr>
  <tr><td><a href="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/KubernetesToBDC/03-kubernetes.md" target="_blank">03 - Kubernetes Concepts and Implementation</a></td><td> Covers deploying Kubernetes, Kubernetes contexts, cluster troubleshooting and management, services: load balancing versus node ports, understanding storage from a Kubernetes perspective and making your cluster secure.</td></tr>
  <tr><td style="background-color: AliceBlue; color: black;"><a href="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/KubernetesToBDC/04-bdc.md" target="_blank">04 - SQL Server Big Data Clusters Architecture</a> </td><td td style="background-color: AliceBlue; color: black;"> This module will dig deep into the anatomy of a big data cluster by covering topics that include: the data pool, storage pool, compute pool and cluster control plane, active directory integration, development versus production configurations and the tools required for deploying and managing a big data cluster.</td></tr>  <tr><td><a href="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/KubernetesToBDC/05-datascience.md" target="_blank">05 - Using the SQL Server big data cluster on Kubernetes for Data Science</a></td><td> Now that your big data cluster is up, it's ready for data science workloads. This Jupyter Notebook and Azure Data Studio based module will cover the use of python and PySpark, T-SQL and the execution of Spark and Machine Learning workloads.</td></tr>

</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/geopin.png?raw=true"><b>     Next Steps</b></h2>


Next, Continue to <a href="00-prerequisites.md" target="_blank"><i> Pre-Requisites</i></a>