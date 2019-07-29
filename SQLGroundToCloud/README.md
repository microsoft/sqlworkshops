![](graphics/microsoftlogo.png)

# Workshop: SQL Ground-to-Cloud

#### <i>A Microsoft Workshop from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/textbubble.png"> <h2>About this Workshop</h2>

Welcome to this Microsoft solutions workshop on SQL Server in on-premise, in-cloud and hybrid solutions. In this one-day workshop, you'll gain a deep understanding on the latest SQL Server engine and how you can use it to solve real-world challenges. 

The modules in this workshop lead you through conceptual and hands-on topics ranging from the newest technical features in SQL Server to its implementation in all platforms it runs on. You'll learn not only specific technologies, but how to assemble them into a complete solution based on customer needs and requests.   

You'll start by learning about the latest improvements to SQL Server, move on to the Big Data Clusters configuration, and then learn about the ways you can leverage SQL in Microsoft Azure - all with a focus on how to extrapolate what you have learned to create other solutions for your organization. You'll end the day with a "What to Use When" module explaining how to create your own solutions. 

This README.MD file explains how the workshop is laid out, what you will learn, and the technologies you will use in this solution.

(You can view all of the [source files for this workshop on this github site, along with other workshops as well. Open this link in a new tab to find out more.](https://github.com/BuckWoody/workshops))

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/checkmark.png"> <h3>Abstract</h3>

Many organizations are faced with an aging or under-engineered data platform strategy. You need a plan for how to decide if, when, and how you should upgrade your systems, when to extend them to the cloud, what to keep on and what can work in a hybrid fashion.

Members from the Azure SQL Product Group will lead you through the data estate options from Microsoft, from on-premises SQL Server (including some of the new features in SQL Server) to Relational Database options in Azure. You'll how to evaluate the benefits/costs of each technology option, and give you multiple tools that you can take home to inventory, evaluate, and migrate your current data platform environment to the best configuration.

This course contains lecture and hands on lab work, and is particularly useful for Solution Architects, Data Architects, Application Architects, Technical Sellers, and Application Developers. BYOD and experience with SQL is considered a prerequisite.

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/checkmark.png"> <h3>Learning Objectives</h3>

In this day-long, hands-on workshop you’ll learn how to:

<br>

 - Articulate the key differentiators between SQL Server on-prem, in Azure VM, in Azure SQL DB, and hybrid
 - Explain the different service tiers within Azure SQL DB, and what to choose when
 - Understand how Azure SQL DB is secured and address security concerns
 - Learn what hybrid entails for Azure SQL DB and SQL Server in some common examples
 - Get hands on with some of the features in SQL Server and Azure SQL DB
 - Understand "other" Azure platform features 
 - Understand what services are available to migrate and modernize your entire SQL Server stack
 - Make informed decisions about how your business or customers should modernize their data estate

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/checkmark.png"> <h3>Role Applications</h3>

The concepts and skills taught in this workshop form the starting points for:

- Solution Architects and Developers, to understand how to put together an end to end solution.
- Data Professionals and DevOps teams, to implement and operate a SQL Server systems on premises and in the cloud.
- Solution Architects and Developers, to understand how to put together an end-to-end solution.
- Data Scientists, to understand the environment used to analyze and solve specific predictive problems.

<p style="border-bottom: 1px solid lightgrey;"></p>
<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/building1.png"> <h2>Business Applications of this Workshop</h2>

Businesses require near real-time insights from ever-larger sets of data from a variety of sources. Many have not explored teh improvements made in the latest versions of SQL Server, and some are only now exploring the cloud as a computing platform. As time has progressed, a more dramatic upgrade process may be required.

In addition to traditional Online Transaction Processing (OLTP) and Online Analytic Processing (OLAP) workloads, some industry examples of data processing from multiple sources of data at scale are in Retail (Demand Prediction, Market-Basket Analysis), Finance (Fraud detection, customer segmentation), Healthcare (Fiscal control analytics, Disease Prevention prediction and classification, Clinical Trials optimization), Public Sector (Revenue prediction, Education effectiveness analysis), Manufacturing (Predictive Maintenance, Anomaly Detection) and Agriculture (Food Safety analysis, Crop forecasting) to name just a few.

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/listcheck.png"> <h2><a name="technologies">Technologies and Topics covered in this Workshop</a></h2>

The information coverecd in this workshop includes the following technologies and topics - although you are not limited to these, they form the basis of the workshop. At the end of the workshop you will learn how to extrapolate these components into other solutions. You will cover these at an overview level, with references to much deeper training provided.

 <table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 2px; border-color: gray;">

  <tr><th style="background-color: #1b20a1; color: white;">Technology</th> <th style="background-color: #1b20a1; color: white;">Description</th></tr>
  <tr><td style="vertical-align: top">SQL Server 2019 improvements (on-prem and in-cloud)</i></td><td style="vertical-align: top">SQL Server in on-premises installations, containers, Kubernetes, and on the Microsoft Azure platform and in hybrid configurations</td></tr>
  <tr><td style="vertical-align: top">Big Data Clusters for SQL Server (on-prem and in-cloud)</i></td><td style="vertical-align: top">Big Data Clusters for SQL Server in on-premises installations, containers, Kubernetes, and on the Microsoft Azure platform and in hybrid configurations</td></tr>
  <tr><td style="vertical-align: top">SQL Server Virtual Machines in Microsoft Azure </i></td><td style="vertical-align: top">SQL Server Virtual Machines on the Microsoft Azure platform </td></tr>
  <tr><td style="vertical-align: top"Microsoft Azure Security for SQL Server Installations </i></td><td style="vertical-align: top">Networking and Securituy for Microsoft Azure as it relates to SQL Server installations </td></tr>
  <tr><td style="vertical-align: top">Migrating SQL Server installations to Microsoft Azure </i></td><td style="vertical-align: top">Tools and processes to migrate on-premises SQL Server installations to the Microsoft Azure platform </td></tr>
  <tr><td style="vertical-align: top">"What to Use When" </i></td><td style="vertical-align: top">Tools and processes to determine the best architecture for a given customer requirement on the Microsoft Azure platform </td></tr>

</table>

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

This workshop uses Azure Data Studio, Microsoft Azure, and SQL Server (2019 and higher) with a focus on architecture and implementation.

<table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 5px; border-color: gray;">

  <tr><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Primary Audience:</td><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">System Architects and Data Professionals tasked with implementing modern Data Systems, Big Data, Machine Learning and AI solutions</td></tr>
  <tr><td>Secondary Audience:</td><td> Security Architects, Developers, and Data Scientists</td></tr>
  <tr><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Level: </td><td style="background-color: Cornsilk; color: black; padding: 5px 5px0;"> 300</td></tr>
  <tr><td>Type:</td><td>In-Person</td></tr>
  <tr><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Length: </td><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">8-9 hours</td></tr>

</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/bulletlist.png"> <h3>Setup</h3>

<a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/00-Pre-Requisites.md" target="_blank">A full prerequisites document is located here</a>. These instructions should be completed before the workshop starts, since you will not have time to cover these in class. <i>Remember to turn off any Virtual Machines from the Azure Portal when not taking the class so that you do incur charges (shutting down the machine in the VM itself is not sufficient)</i>.

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

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/pinmap.png"> <h2>Related Workshops</h2>

 - [TODO: Enter any other workshops that help in this area](url)

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/bookpencil.png"> <h2>Workshop Modules and Agenda</h2>

This is a modular workshop, and in each section, you'll learn concepts, technologies and processes to help you complete the solution.

<table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 5px; border-color: gray;">

  <tr><td style="background-color: AliceBlue; color: black;"><b>Module</b></td><td style="background-color: AliceBlue; color: black;"><b>Topics</b></td></tr>

  <tr><td style="vertical-align: top;"><a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/01-IntroductionAndWorkshopMethodology.md" target="_blank">01 - Introduction and Workshop Methodology </a></td><td> Workshop introduction, logistics, setup check </td></tr>
  
  <tr><td style="vertical-align: top;background-color: AliceBlue; color: black;"><a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/02-ModernizingYourDataEstateWithSQLServer2019.md" target="_blank">02 - Modernizing Your Data Estate with SQL Server 2019 </a> </td><td style="vertical-align: top;background-color: AliceBlue; color: black;"> This module covers the improvements made to the latest version of SQL Server, and has information on: 
    <ul style="list-style-type:disc;">
        <li>Intelligent Performance</li>
        <li>What's New in Security</li>
        <li>Mission Critical Availability</li>
        <li>Data Virtualization</li>
        <li>SQL Server Linux and Containers</li>
        <li>Migration</li>
    </ul>
  </td></tr>

  <tr><td style="vertical-align: top;"><a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/03-WorkingWithBigDataAndDataScienceBigDataClustersForSQLServer2019.md" target="_blank"> 03 - Working with Big Data and Data Science (Big Data Clusters for SQL Server 2019) </a></td><td style="vertical-align: top;"> Abstraction levels, frameworks, architectures and components within SQL Server big data clusters</td></tr>

  <tr><td style="vertical-align: top;background-color: AliceBlue; color: black;"><a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/04-SQLServerOnTheMicrosoftAzurePlatform.md" target="_blank">04 - SQL Server on the Microsoft Azure Platform </a> </td><td td style="background-color: AliceBlue; color: black;"> Covers the multiple ways to use SQL Server technologies on the Microsoft Azure Platform, from Managed Instance to Azure SQL DB, and also migration strategies and tools you can use to move on-cloud or hybrid workloads.</td></tr>  

  <tr><td style="vertical-align: top;"><a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/05-WhatToUseWhen.md" target="_blank"> 05 - What to use When </a></td><td style="vertical-align: top;"> Covers the decision process and provides tools for deciding on the proper technologies on-premises and in-cloud for a solution based on requirements and constraints.</td></tr>

  <tr><td style="vertical-align: top;background-color: AliceBlue; color: black;"><a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/06-ReviewAndApplication.md" target="_blank"> 06 - Review and Application </a> </td><td td style="background-color: AliceBlue; color: black;"> Reviewing what you have learned in the course and a capstone discussion on how to apply it to your organization's needs.</td></tr>

</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/geopin.png"><b>Next Steps</b></p>

Next, Continue to <a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/00-Pre-Requisites.md" target="_blank"><i> Pre-Requisites</i></a>
