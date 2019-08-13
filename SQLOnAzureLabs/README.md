![](graphics/microsoftlogo.png?raw=true)

# Labs: SQL on the Microsoft Azure Platform

#### <i>A Microsoft Lab from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=true"> <h2>About these  Labs</h2>

Welcome to these Microsoft solutions Labs on SQL using the Microsoft Azure Platform. Using these Labs, you'll gain a deep understanding on options for the latest SQL Server engine in Microsoft Azure and how you can use it to solve real-world challenges. 

This README.MD file explains how the Labs are laid out, what you will learn, and the technologies you will use to get hands-on experience.

(You can view all of the [source files for this workshop on this GitHub site, along with other workshops as well. Open this link in a new tab to find out more.](https://github.com/BuckWoody/workshops))

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/listcheck.png?raw=true"> <h2><a name="technologies">Technologies and Topics covered in these Labs</a></h2>

The information covered in this workshop includes the following technologies and topics - although you are not limited to these, they form the basis of the workshop. At the end of the workshop you will learn how to extrapolate these components into other solutions. You will cover these at an overview level, with references to much deeper training provided.

 <table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 2px; border-color: gray;">

  <tr><th style="background-color: #1b20a1; color: white;">Technology/Concept</th> <th style="background-color: #1b20a1; color: white;">Description</th></tr>
  <tr><td style="vertical-align: top">Azure SQL Database </i></td><td style="vertical-align: top">Covers the tools, processes and procedures for Azure SQL Database (Managed Instance, Singleton, and Elastic Pools)</td></tr>
  <tr><td style="vertical-align: top">Migrating SQL Server installations to Microsoft Azure </i></td><td style="vertical-align: top">Explains the tools and processes to migrate on-premises SQL Server installations to the Microsoft Azure platform </td></tr>
  <tr><td style="vertical-align: top">"What to Use When" </i></td><td style="vertical-align: top">Teaches a complete set of tools and processes used to determine the best architecture for a given customer scenario on the Microsoft Azure platform </td></tr>

</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/owl.png?raw=true"> <h2><a name="prereqs">Before Taking these Labs</a></h2>

You'll need a local system that you are able to install software on. The workshop demonstrations use Microsoft Windows as an operating system and all examples use Windows for the workshop. Optionally, you can use a Microsoft Azure Virtual Machine (VM) to install the software on and work with the solution.

You must also have a Microsoft Azure account with the ability to create assets.

These Labs expect that you understand data structures and working with SQL Server and computer networks. These Labs not expect you to have any prior data science knowledge, but a basic knowledge of statistics and data science is helpful in the Data Science sections. Knowledge of SQL Server, Azure Data and AI services, Python, and Jupyter Notebooks is recommended. AI techniques are implemented in Python packages. Solution templates are implemented using Azure services, development tools, and SDKs. You should have experience working with the Microsoft Azure Platform.

If you are new to these, here are a few references you can complete prior to class:

-  [Microsoft SQL Server](https://docs.microsoft.com/en-us/sql/relational-databases/database-engine-tutorials?view=sql-server-ver15)
-  [Microsoft Azure](https://docs.microsoft.com/en-us/learn/paths/azure-fundamentals/)

<a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/00-Pre-Requisites.md" target="_blank">A full prerequisites document is located here</a>. These instructions should be completed before the Labs start, since you will not have time to cover these in class if you are taking them in person. <i>Remember to turn off any Virtual Machines from the Azure Portal when not taking the class so that you do incur charges (shutting down the machine in the VM itself is not sufficient)</i>.

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/bulletlist.png?raw=true"> <h3>Intended Audience</h3>

<p>The following roles will find this workshop useful. Others may also attend, as described in the Secondary Audience section.</p>

<table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 5px; border-color: gray;">

  <tr><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Primary Audience:</td><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Solution Architects and Data Professionals tasked with implementing modern Data Systems, Big Data, Machine Learning and AI solutions</td></tr>
  <tr><td>Secondary Audience:</td><td> Security Architects, Developers, and Data Scientists</td></tr>
  <tr><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Level: </td><td style="background-color: Cornsilk; color: black; padding: 5px 5px0;"> 300</td></tr>
  <tr><td>Type:</td><td>In-Person</td></tr>
  <tr><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Length: </td><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">2 hours for all labs</td></tr>

</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/bulletlist.png?raw=true"> <h3>Setup</h3>

<a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/00-Pre-Requisites.md" target="_blank">A full prerequisites document is located here</a>. These instructions should be completed before you start the Labs, since you will not have time to cover these in class if you are taking them in-person. <i>Remember to turn off any Virtual Machines from the Azure Portal when not taking the class so that you do incur charges (shutting down the machine in the VM itself is not sufficient)</i>.

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/bookpencil.png?raw=true"> <h3>Lab Details</h3>

This is a modular set of Labs, and in each section, you'll learn concepts, technologies and processes to help you complete the solution. The times shown below are for an instructor-led Lab, although you may also take the modules in a self-paced fashion.

<table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 5px; border-color: gray;">

  <tr><td style="background-color: AliceBlue; color: black;"><b>Module</b></td>
  <td style="background-color: AliceBlue; color: black;"><b>Time</b></td>
  <td style="background-color: AliceBlue; color: black;"><b>Topics</b></td></tr>

  <tr><td style="vertical-align: top;"><a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/01-IntroductionAndWorkshopMethodology.md" target="_blank">01 - Introduction and Workshop Methodology </a></td><td>9:00AM-9:15AM</td><td> Workshop introduction, logistics, setup check </td></tr>
  
  <tr><td style="vertical-align: top;background-color: AliceBlue; color: black;"><a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/02-ModernizingYourDataEstateWithSQLServer2019.md" target="_blank">02 - Modernizing Your Data Estate with SQL Server 2019 </a> </td><td style="vertical-align: top;background-color: AliceBlue; color: black;">9:15AM-11:15AM</td><td style="vertical-align: top;background-color: AliceBlue; color: black;"> This module covers challenges and solutions using the latest version of SQL Server including:<br>
    <ul style="list-style-type:disc;">
        <li>Overall SQL Server 2019</li> 
        <li>Intelligent Performance</li>
        <li>What's New in Security</li>
        <li>Mission Critical Availability</li>
        <li>Data Virtualization</li>
        <li>SQL Server Linux and Containers</li>
        <li>What Else, Migration and Next Steps</li>
    </ul>
  </td></tr>

  <tr><td style="vertical-align: top;"><a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/03-WorkingWithBigDataAndDataScienceBigDataClustersForSQLServer2019.md" target="_blank"> 03 - Working with Big Data and Data Science (Big Data Clusters for SQL Server 2019) </a></td><td>11:30AM-12:30PM</td><td style="vertical-align: top;"> Abstraction levels, frameworks, architectures and components within SQL Server big data clusters</td></tr>

  <tr><td style="vertical-align: top;background-color: AliceBlue; color: black;"><a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/04-SQLServerOnTheMicrosoftAzurePlatform.md" target="_blank">04 - SQL Server on the Microsoft Azure Platform </a> </td><td style="vertical-align: top;background-color: AliceBlue; color: black;">1:30PM-2:30PM<td td style="background-color: AliceBlue; color: black;"> Covers the multiple ways to use SQL Server technologies on the Microsoft Azure Platform, along with the fundamentals of SQL in Azure with additional deeper resources provided. Topics covered include:
      <ul style="list-style-type:disc;">
        <li>Azure SQL: SQL VMs, Single instance, Single database, Elastic pools</li>
        <li>Fundamentals of SQL in Azure</li>
        <li>Migration process</li>
    </ul>
  </td></tr>  

  <tr><td style="vertical-align: top;"><a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/05-MigratingToAzureSQL.md
" target="_blank"> 05 - Migrating SQL Server to Azure </a></td><td>2:45PM-3:45PM</td><td style="vertical-align: top;"> Covers the migration workflow and tools for assessing, planning, and migrating SQL workloads to Azure that meets the business requirements. Some of the tools and topics (not exhaustive) covered are:
        <ul style="list-style-type:disc;">
        <li>Azure Migrate</li>
        <li>Data Migration Assistant</li>
        <li>Azure Database Migration Service</li>
        <li>Post-migration operations</li>
    </ul>
  </td></tr>

  <tr><td style="vertical-align: top;background-color: AliceBlue; color: black;"><a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/06-WhatToUseWhen.md" target="_blank"> 06 - What to use When </a> </td><td style="vertical-align: top;background-color: AliceBlue; color: black;">3:45PM-5:00PM<td td style="background-color: AliceBlue; color: black;"> Covers the decision process and provides tools for deciding on the proper technologies on-premises and in-cloud for a solution based on requirements and constraints.</td></tr>

</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pinmap.png?raw=true"> <h2>Related Workshops</h2>

 - [Other SQL Workshops by Microsoft](https://aka.ms/sqlworkshops)


