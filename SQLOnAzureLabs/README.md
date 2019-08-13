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

  <tr><td style="vertical-align: top;"><a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLOnAzureLabs/Lab-DatabaseDiscoveryAndAssessementForMigratingToAzure.md" target="_blank"> Lab: Database Discovery and Assessment for Migrating to the Microsoft Azure SQL Platform </a></td><td>30 Minutes</td><td style="vertical-align: top;"> In this hands-on Lab, you will set up your environment with SQL Server 2008 R2 and Azure SQL, and perform assessments to reveal any feature parity and compatibility issues between the on-premises SQL Server 2008 R2 database and the managed database offerings in Azure. At the end of of this Lab, you will be better able to implement a cloud migration solution for business-critical applications and databases.</td></tr>
  
  <tr><td style="vertical-align: top;background-color: AliceBlue; color: black;"><a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/02-ModernizingYourDataEstateWithSQLServer2019.md" target="_blank">Lab: Migrating to Microsoft Azure SQL Managed Instance </a> </td><td style="vertical-align: top;background-color: AliceBlue; color: black;">1.5 Hours</td><td style="vertical-align: top;background-color: AliceBlue; color: black;"> In this hands-on Lab, you will use the <a href="https://azure.microsoft.com/services/database-migration/" target="_blank">Azure Database Migration Service</a> (DMS) to migrate the `TailspinToys` database from the on-premises SQL 2008 R2 database to SQL MI. At the end of the Lab, you'll also explore some of the security and performance features available.
  </td></tr>

</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pinmap.png?raw=true"> <h2>Related Workshops</h2>

 - [Other SQL Workshops by Microsoft](https://aka.ms/sqlworkshops)


