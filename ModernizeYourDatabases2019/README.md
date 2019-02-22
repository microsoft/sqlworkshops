![](graphics/microsoftlogo.png)

# Workshop: Modernize Your Database with SQL Server 2019

#### <i>A Microsoft Course from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/textbubble.png"> <h2>About this Workshop</h2>

Welcome to this Microsoft solutions workshop on *Modernizing Your Database with SQL Server 2019*. In this workshop, you'll learn how SQL Server 2017 and SQL Server 2019 can help you in modernizing your database workloads.

The focus of this workshop is to understand some of the advancements included in SQL Server 2017 and SQL Server 2019 that can help provide:

- Performance
- Security
- Availability
- Modern development on a variety of systems

You'll dive deep into exploring the modern development platform on a variety of systems including Windows Server 2019, Linux, Containers, and Kubernetes. This course includes content, references to more content, hands-on labs, thinking activities, and slides. All resources are available for free for you to consume and share in any way that you need so you have the right resources to make smart decisions on modernizing your database and applications.

You'll start by learning about the new features associates with SQL Server 2019, with a focus on how to extrapolate what you have learned to create other solutions for your organization.

This README.MD file explains how the workshop is laid out, what you will learn, and the technologies you will use in this solution.

(You can view all of the [source files for this workshop on this github site, along with other workshops as well. Open this link in a new tab to find out more.](https://github.com/BuckWoody/workshops))

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/checkmark.png"> <h3>Learning Objectives</h3>

In this workshop you'll learn:
<br>

- How big data clusters and data virtualization in SQL Server 2019 can help in modernizing your data estate
- How new features in SQL Server 2019 can improve your security and availability models
- How to use tools, including Azure Data Studio and SQL Server Management Studio, as a canvas for your data projects
- How and why you may want to put SQL Server on Linux or in a container
- How to migrate from on-premises or competitors' services to Azure or SQL Server 2019  


This workshop will help build a foundation of knowledge around SQL Server to help you get the most out of your data.  

The goal of this workshop is to train the team tasked with architecting and implementing SQL Server 2017/2019 in the planning, creation, and delivery of a system designed to be used as the modern data platform. Since there are multiple technologies and concepts within this solution, the workshop uses multiple types of exercises to prepare the students for this implementation.

The concepts and skills taught in this workshop form the starting points for:

- Data Professionals and DevOps teams that will implement, update, or operate SQL Server
- Solution Architects and Developers, to understand how to put together an end to end solution
- Data Scientists, to understand the environment used to analyze and solve specific predictive problems

<p style="border-bottom: 1px solid lightgrey;"></p>
<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/building1.png"> <h2>Business Applications of this Workshop</h2>

Most businesses and applications run on data. Businesses require near real-time insights from data from a variety of sources. Large-scale data ingestion requires scale-out storage and processing in ways that allow fast response times. In addition to simply querying this data, organizations want full analysis and even predictive capabilities over their data.

Some industry examples of data processing are in Retail (Demand Prediction, Market-Basket Analysis), Finance (Fraud detection, customer segmentation), Healthcare (Fiscal control analytics, Disease Prevention prediction and classification, Clinical Trials optimization), Public Sector (Revenue prediction, Education effectiveness analysis), Manufacturing (Predictive Maintenance, Anomaly Detection) and Agriculture (Food Safety analysis, Crop forecasting) to name just a few.

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/listcheck.png"> <h2>Technologies used in this Workshop</h2>

The solution includes the following technologies - although you are not limited to these, they form the basis of the workshop. At the end of the workshop you will learn how to extrapolate these components into other solutions. You will cover these at an overview level, with references to much deeper training provided.

 <table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 2px; border-color: gray;">

  <tr><th style="background-color: #1b20a1; color: white;">Technology</th> <th style="background-color: #1b20a1; color: white;">Description</th></tr>

  <tr><td><i>Linux</i></td><td>Operating system used in Containers and Container Orchestration</td></tr>
  <tr><td><i>Docker</i></td><td>Encapsulation level for the SQL Server big data cluster architecture</td></tr>
  <tr><td><i>Kubernetes</i></td><td>Management, control plane for Containers</td></tr>
  <tr><td>Microsoft Azure</td><td>Cloud environment for services</td></tr>
  <tr><td>Azure Container Service (AKS)</td><td>Kubernetes as a Service</td></tr>
  <tr><td><i>Python, R, Java, SparkML</i></td><td><i>ML/AI programming languages used for Machine Learning and AI Model creation</i></td></tr>
  <tr><td>Azure Data Studio</td><td>Tooling for SQL Server, HDFS, Kubernetes cluster management, T-SQL, R, Python, and SparkML languages</td></tr>
  <tr><td>SQL Server Machine Learning Services</td><td>R, Python and Java extensions for SQL Server</td></tr>
  <tr><td><i>Monitoring and Management</i></td><td>Dashboards, logs, API's and other constructs to manage and monitor the solution<td><i></i></td></tr>
  <tr><td><i>Security</i></td><td>RBAC, Keys, Secrets, VNETs and Compliance for the solution<td><i></i></td></tr>

</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/owl.png"> <h2>Before Taking this Workshop</h2>

You'll need a local system that you are able to install software on. The workshop demonstrations use Microsoft Windows as an operating system and all examples use Windows for the workshop. Optionally, you can use a Microsoft Azure Virtual Machine (VM) to install the software on and work with the solution.

You must have a Microsoft Azure account with the ability to create assets.

This workshop expects that you understand data structures and working with SQL Server and computer networks. This workshop does not expect you to have any prior data science or Java knowledge. Knowledge of and experience with SQL Server, containers, and Linux is recommended but not required. Solution templates are implemented using Azure services, development tools, and SDKs. You should have a basic understanding of working with the Microsoft Azure Platform.

If you are new to these, here are a few references you can review/complete prior to class:

-  [Microsoft SQL Server](https://docs.microsoft.com/en-us/sql/relational-databases/database-engine-tutorials?view=sql-server-2017)
-  [Microsoft Azure](https://docs.microsoft.com/en-us/learn/paths/azure-fundamentals/)


<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/bulletlist.png"> <h3>Setup</h3>

<a href="url" target="_blank">A full pre-requisites document is located here</a>. These instructions should be completed before the workshop starts, since you will not have time to cover these in class. <i>Remember to turn off any Virtual Machines from the Azure Portal when not taking the class so that you do incur charges (shutting down the machine in the VM itself is not sufficient)</i>.

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/education1.png"> <h2>Workshop Details</h2>

This workshop uses Azure Data Studio, Microsoft Azure AKS, and SQL Server (2019 and higher) with a focus on architecture and implementation.

<table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 5px; border-color: gray;">

  <tr><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Primary Audience:</td><td style="background-color: Cornsilk; color: black; padding: 5px 5px0;">Data Professionals, System Architects, Developers</td></tr>
  <tr><td>Secondary Audience:</td><td> Security Architects, Data Scientists</td></tr>
  <tr><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Level: </td><td style="background-color: Cornsilk; color: black; padding: 5px 5px0;"> 300</td></tr>
  <tr><td>Type:</td><td>In-Person</td></tr>
  <tr><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Length: </td><td style="background-color: Cornsilk; color: black; padding: 5px 5px0;">8-9 hours</td></tr>

</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/pinmap.png"> <h2>Related Workshops</h2>

 - [TODO: Enter any other workshops that help in this area](url)

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/bookpencil.png"> <h2>Workshop Modules</h2>

This is a modular workshop, and in each section, you'll learn concepts, technologies, and processes to help you complete the solution.

<table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 5px; border-color: gray;">

  <tr><td style="background-color: AliceBlue; color: black;"><b>Module</b></td><td style="background-color: AliceBlue; color: black;"><b>Topics</b></td></tr>

  <tr><td><a href="url" target="_blank">01 - Why SQL Server 2019 </a></td><td> TODO: Module Description</td></tr>
  <tr><td style="background-color: AliceBlue; color: black;"><a href="url" target="_blank">02 - big data clusters and Data Virtualization</a> </td><td td style="background-color: AliceBlue; color: black;"> TODO: Module Description</td></tr>
  <tr><td><a href="url" target="_blank">03 - Intelligent Performance </a></td><td> TODO: Module Description</td></tr>
  <tr><td style="background-color: AliceBlue; color: black;"><a href="url" target="_blank">04 - New Security Capabilities</a> </td><td td style="background-color: AliceBlue; color: black;"> TODO: Module Description</td></tr>  
  <tr><td><a href="url" target="_blank">05 - Mission Critical Availability </a></td><td> TODO: Module Description</td></tr>
  <tr><td style="background-color: AliceBlue; color: black;"><a href="url" target="_blank">06 - The Modern Development Platform</a> </td><td td style="background-color: AliceBlue; color: black;"> TODO: Module Description</td></tr>
  <tr><td><a href="url" target="_blank">07 - SQL Server on Linux </a></td><td> TODO: Module Description</td></tr>
  <tr><td style="background-color: AliceBlue; color: black;"><a href="url" target="_blank">08 - SQL Server Containers and Kubernetes</a> </td><td td style="background-color: AliceBlue; color: black;"> TODO: Module Description</td></tr>  <tr><td><a href="url" target="_blank">09 - What Else is New </a></td><td> TODO: Module Description</td></tr>
  <tr><td style="background-color: AliceBlue; color: black;"><a href="url" target="_blank">10 - Migration and Next Steps</a> </td><td td style="background-color: AliceBlue; color: black;"> TODO: Module Description</td></tr>

</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/geopin.png"><b>Next Steps</b></p>

Next, Continue to <a href="ModernizeSQL2019/00-Pre-Requisites.md" target="_blank"><i> Pre-Requisites</i></a>