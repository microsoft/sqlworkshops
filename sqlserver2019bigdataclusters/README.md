![](graphics/microsoftlogo.png)

# Workshop: SQL Server Big Data Clusters - Architecture (CTP 3.2)

#### <i>A Microsoft Course from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<dl style="text-align: left;">

  <dt><a href="#about">About this Workshop</a></dt>
  <dt><a href="#businessapplications">Business Applications of this Workshop</a></dt>
  <dt><a href="#technologies">Technologies used in this Workshop</a></dt>
  <dt><a href="#prereqs">Before Taking this Workshop</a></dt>
  <dt><a href="#details">Workshop Details</a></dt>
  <dt><a href="#related">Related Workshops</a></dt>
  <dt><a href="#modules">Workshop Modules</a></dt>
  <dt><a href="#nextsteps">Next Steps</a></dt>

</dl>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/textbubble.png"> <h2><a name="about">About this Workshop</a></h2>

Welcome to this Microsoft solutions workshop on the architecture on *SQL Server Big Data Clusters*. In this workshop, you'll learn how SQL Server Big Data Clusters (BDC) implements large-scale data processing and machine learning, and how to select and plan for the proper architecture to enable machine learning to train your models using Python, R, Java or SparkML to operationalize these models, and how to deploy your intelligent apps side-by-side with their data.

The focus of this workshop is to understand how to deploy an on-premise, hybrid or local environment of a big data cluster, and understand the components of the big data solution architecture.

You'll start by understanding the concepts of big data analytics, and you'll get an overview of the technologies (such as containers, Kubernetes, Spark and HDFS, machine learning, and other technologies) that you will use throughout the workshop. Next, you'll understand the architecture of a BDC. You'll learn how to create external tables over other data sources to unify your data, and how to use Spark to run big queries over your data in HDFS or do data preparation. You'll review a complete solution for an end-to-end scenario, with a focus on how to extrapolate what you have learned to create other solutions for your organization.

This README.MD file explains how the workshop is laid out, what you will learn, and the technologies you will use in this solution.

(You can view all of the [source files for this workshop on this GitHub site, along with other workshops as well. Open this link in a new tab to find out more.](https://github.com/BuckWoody/workshops))

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/checkmark.png"> <h3>Learning Objectives</h3>

In this workshop you'll learn:
<br>

- When to use Big Data technology
- The components and technologies of Big Data processing
- Abstractions such as Containers and Container Management as they relate to SQL Server and Big Data
- Planning and architecting an on-premises, in-cloud, or hybrid big data solution with SQL Server
- How to install SQL Server big data clusters on-premises and in the Azure Kubernetes Service (AKS)
- How to work with Apache Spark
- The Data Science Process to create an end-to-end solution
- How to work with the tooling for BDC (Azure Data Studio)
- Monitoring and managing the BDC
- Security considerations

Starting in SQL Server 2019, big data clusters allows for large-scale, near real-time processing of data over the HDFS file system and other data sources. It also leverages the Apache Spark framework which is integrated into one environment for management, monitoring, and security of your environment. This means that organizations can implement everything from queries to analysis to Machine Learning and Artificial Intelligence within SQL Server, over large-scale, heterogeneous data. SQL Server big data clusters can be implemented fully on-premises, in the cloud using a Kubernetes service such as Azure's AKS, and in a hybrid fashion. This allows for full, partial, and mixed security and control as desired.

The goal of this workshop is to train the team tasked with architecting and implementing SQL Server big data clusters in the planning, creation, and delivery of a system designed to be used for large-scale data analytics. Since there are multiple technologies and concepts within this solution, the workshop uses multiple types of exercises to prepare the students for this implementation.

The concepts and skills taught in this workshop form the starting points for:

  * Data Professionals and DevOps teams, to implement and operate a SQL Server big data cluster system.
  * Solution Architects and Developers, to understand how to put together an end-to-end solution.
  * Data Scientists, to understand the environment used to analyze and solve specific predictive problems.

<p style="border-bottom: 1px solid lightgrey;"></p>
<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/building1.png"> <h2><a name="businessapplications">Business Applications of this Workshop</a></h2>

Businesses require near real-time insights from ever-larger sets of data from a variety of sources. Large-scale data ingestion requires scale-out storage and processing in ways that allow fast response times. In addition to simply querying this data, organizations want full analysis and even predictive capabilities over their data. 

Some industry examples of big data processing are in Retail (*Demand Prediction, Market-Basket Analysis*), Finance (*Fraud detection, customer segmentation*), Healthcare (*Fiscal control analytics, Disease Prevention prediction and classification, Clinical Trials optimization*), Public Sector (*Revenue prediction, Education effectiveness analysis*), Manufacturing (*Predictive Maintenance, Anomaly Detection*) and Agriculture (*Food Safety analysis, Crop forecasting*) to name just a few.

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/listcheck.png"> <h2><a name="technologies">Technologies used in this Workshop</a></h2>

The solution includes the following technologies - although you are not limited to these, they form the basis of the workshop. At the end of the workshop you will learn how to extrapolate these components into other solutions. You will cover these at an overview level, with references to much deeper training provided.

 <table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 2px; border-color: gray;">

  <tr><th style="background-color: #1b20a1; color: white;">Technology</th> <th style="background-color: #1b20a1; color: white;">Description</th></tr>

  <tr><td><i>Linux</i></td><td>Operating system used in Containers and Container Orchestration</td></tr>
  <tr><td><i>Docker</i></td><td>Encapsulation level for the SQL Server big data cluster architecture</td></tr>
  <tr><td><i>Kubernetes</i></td><td>Management, control plane for Containers</td></tr>
  <tr><td>Microsoft Azure</td><td>Cloud environment for services</td></tr>
  <tr><td>Azure Kubernetes Service (AKS)</td><td>Kubernetes as a Service</td></tr>
  <tr><td><i>Apache HDFS</i></td><td>Scale-out storage subsystem</td></tr>
  <tr><td><i>Apache Knox</i></td><td>The Knox Gateway provides a single access point for all REST interactions, used for security</td></tr>
  <tr><td><i>Apache Livy</i></td><td>Job submission system for Apache Spark</td></tr>
  <tr><td><i>Apache Spark</i></td><td>In-memory large-scale, scale-out data processing architecture used by SQL Server </i></td></tr>
  <tr><td><i>Python, R, Java, SparkML</i></td><td><i>ML/AI programming languages used for Machine Learning and AI Model creation</i></td></tr>
  <tr><td>Azure Data Studio</td><td>Tooling for SQL Server, HDFS, Kubernetes cluster management, T-SQL, R, Python, and SparkML languages</td></tr>
  <tr><td>SQL Server Machine Learning Services</td><td>R, Python and Java extensions for SQL Server</td></tr>
  <tr><td>Microsoft Data Science Process (TDSP)</td><td>Project, Development, Control and Management framework</td></tr>
  <tr><td><i>Monitoring and Management</i></td><td>Dashboards, logs, API's and other constructs to manage and monitor the solution</td></tr>
  <tr><td><i>Security</i></td><td>RBAC, Keys, Secrets, VNETs and Compliance for the solution</td></tr>

</table>

<p style="background:#ccc; color:#000;padding: 25px 25px 25px 25px;">

<b>Condensed Lab:</b>
If you have already completed the pre-requisites for this course and are familiar with the technologies listed above, <a href="https://github.com/microsoft/sqlworkshops/tree/master/sqlserver2019bigdataclusters/SQL2019BDC/notebooks" target="_blank">you can jump to a Jupyter Notebooks-based tutorial located here</a>. Load these with Azure Data Studio, starting with <b>bdc_tutorial_00.ipynb</b>.
</p>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/owl.png"> <h2><a name="prereqs">Before Taking this Workshop</a></h2>

You'll need a local system that you are able to install software on. The workshop demonstrations use Microsoft Windows as an operating system and all examples use Windows for the workshop. Optionally, you can use a Microsoft Azure Virtual Machine (VM) to install the software on and work with the solution.

You must have a Microsoft Azure account with the ability to create assets, specifically the Azure Kubernetes Service (AKS).

This workshop expects that you understand data structures and working with SQL Server and computer networks. This workshop does not expect you to have any prior data science knowledge, but a basic knowledge of statistics and data science is helpful in the Data Science sections. Knowledge of SQL Server, Azure Data and AI services, Python, and Jupyter Notebooks is recommended. AI techniques are implemented in Python packages. Solution templates are implemented using Azure services, development tools, and SDKs. You should have a basic understanding of working with the Microsoft Azure Platform.

If you are new to these, here are a few references you can complete prior to class:

-  [Microsoft SQL Server](https://docs.microsoft.com/en-us/sql/relational-databases/database-engine-tutorials?view=sql-server-ver15)
-  [Microsoft Azure](https://docs.microsoft.com/en-us/learn/paths/azure-fundamentals/)


<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/bulletlist.png"> <h3>Setup</h3>

<a href="SQL2019BDC/00%20-%20Prerequisites.md" target="_blank">A full prerequisites document is located here</a>. These instructions should be completed before the workshop starts, since you will not have time to cover these in class. <i>Remember to turn off any Virtual Machines from the Azure Portal when not taking the class so that you do incur charges (shutting down the machine in the VM itself is not sufficient)</i>.

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/education1.png"> <h2><a name="details">Workshop Details</a></h2>

This workshop uses Azure Data Studio, Microsoft Azure AKS, and SQL Server (2019 and higher) with a focus on architecture and implementation.

<table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 5px; border-color: gray;">

  <tr><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Primary Audience:</td><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">System Architects and Data Professionals tasked with implementing Big Data, Machine Learning and AI solutions</td></tr>
  <tr><td>Secondary Audience:</td><td> Security Architects, Developers, and Data Scientists</td></tr>
  <tr><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Level: </td><td style="background-color: Cornsilk; color: black; padding: 5px 5px0;"> 300</td></tr>
  <tr><td>Type:</td><td>In-Person</td></tr>
  <tr><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Length: </td><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">8-9 hours</td></tr>

</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/pinmap.png"> <h2><a name="related">Related Workshops</a></h2>

 - [Technical guide to the Cortana Intelligence Solution Template for predictive maintenance in aerospace and other businesses](https://docs.microsoft.com/en-us/azure/machine-learning/team-data-science-process/cortana-analytics-technical-guide-predictive-maintenance)

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/bookpencil.png"> <h2><a name="modules">Workshop Modules</a></h2>

This is a modular workshop, and in each section, you'll learn concepts, technologies and processes to help you complete the solution.

<table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 5px; border-color: gray;">

  <tr><td style="background-color: AliceBlue; color: black;"><b>Module</b></td><td style="background-color: AliceBlue; color: black;"><b>Topics</b></td></tr>

  <tr><td><a href="SQL2019BDC/01%20-%20The%20Big%20Data%20Landscape.md" target="_blank">01 - The Big Data Landscape </a></td><td> Overview of the workshop, problem space, solution options and architectures</td></tr>
  <tr><td style="background-color: AliceBlue; color: black;"><a href="SQL2019BDC/02%20-%20SQL%20Server%20BDC%20Components.md" target="_blank">02 - SQL Server BDC Components</a> </td><td td style="background-color: AliceBlue; color: black;"> Abstraction levels, frameworks, architectures and components within SQL Server big data clusters</td></tr>
  <tr><td><a href="SQL2019BDC/03%20-%20Planning,%20Installation%20and%20Configuration.md" target="_blank">03 - Planning, Installation<br> and Configuration</a> </td><td> Mapping the requirements to the architecture design, constraints, and diagrams</td></tr>
  <tr><td style="background-color: AliceBlue; color: black;"><a href="SQL2019BDC/04%20-%20Operationalization.md" target="_blank">04 - Operationalization</a> </td><td style="background-color: AliceBlue; color: black;"> Connecting applications to the solution; DDL, DML, DCL</td></tr>
  <tr><td><a href="SQL2019BDC/05%20-%20Management%20and%20Monitoring.md" target="_blank">05 - Management and <br> Monitoring</a> </td><td> Tools and processes to manage the big data cluster</td></tr>
  <tr><td style="background-color: AliceBlue; color: black;"><a href="SQL2019BDC/06%20-%20Security.md" target="_blank">06 - Security</a> </td><td style="background-color: AliceBlue; color: black;"> Access and Authentication to the various levels of the solution</td></tr>

</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/geopin.png"><b><a name="nextsteps">Next Steps</a></b></p>

Next, Continue to <a href="SQL2019BDC/00%20-%20Prerequisites.md" target="_blank"><i> prerequisites</i></a>
