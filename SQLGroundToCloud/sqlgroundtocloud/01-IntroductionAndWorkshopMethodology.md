![](https://github.com/microsoft/sqlworkshops/blob/master/graphics/microsoftlogo.png?raw=true)

# Workshop: SQL Ground-to-Cloud

#### <i>A Microsoft workshop from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=true"> <h2>01 - Introduction and Workshop Methodology</h2>

In this workshop you'll cover using the latest SQL Server features, from on-premises to the cloud, for various solutions. You'll work through a series of modules that will lead you from working with the latest improvements in SQL Server, working with large sets of data (in on-premises, cloud, and hybrid configurations), to working with the SQL options in the Microsoft Azure cloud platform. You'll close out the workshop with a set of scenarios to discover "what to use when", with a complete set of resources to help you in your real-world implementations. Along the way you'll have Lab exercises walking you through a complete assessment and migration of an on-premises database to Azure SQL.

In each module you'll get more references, which you should follow up on to learn more. Also watch for links within the text - click on each one to explore that topic.

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">Workshop Scenario</h2>

The Workshop follows the process of evaluating a solution from "Ground To Cloud" - using various phases in a defined process:

 - 01 **Discovery**: The original statement of the problem from the customer 
 - 02 **Envisioning**: A "blue-sky" description of what success in the project would look like. Often phrased as *"I can..."* statements
 - 03 **Architecture Design Session** (ADS): An initial layout of the technology options and choices for a preliminary solution
 - 04 **Proof-Of-Concept** (POC): After the optimal solution technologies and processes are selected, a POC is set up with a small representative example of what a solution might look like, as much as possible. If available, a currently-running solution in a parallel example can be used
 - 05 **Implementation**: Implementing a phased-in rollout of the completed solution based on findings from the previous phases
 - 06 **Handoff**: A post-mortem on the project with a discussion of future enhancements

 In these modules you'll work through each of these phases for a fictional company called [Wide World Importers](https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-what-is?view=sql-server-2017) (WWI)  - a wholesale novelty goods importer and distributor operating from the San Francisco bay area in the United States. WWI will need to integrate their operations with other companies, such as [The Contoso company](https://docs.microsoft.com/en-us/microsoft-365/enterprise/contoso-overview), a multi-national business with headquarters in Paris, France, and [Adventure Works Cycles](https://docs.microsoft.com/en-us/previous-versions/sql/sql-server-2008/ms124825(v=sql.100) ) - a large, multinational company that manufactures and sells metal and composite bicycles to North American, European and Asian commercial markets. Another company, [Tailspin Toys](http://tailspintoys.azurewebsites.net/), is the developer of several popular toys and online video games. Founded in 2010, and acquired shortly after by Wide World Importers, the company has experienced exponential growth since releasing the first installment of their most popular game franchise to include online multiplayer gameplay. They have since built upon this success by adding online capabilities to the majority of their game portfolio.

 Each of these companies have different challenges, and you'll get hands-on experience in the Labs with each of them.

 At the end of the Workshop, you'll be presented with additional needs from each of these companies, and get tools, processes and other assets that you can use to design your own unique solution. By the end of this Workshop, you'll have everything you need to repeat this process in real-world production scenarios. 

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">Workshop Methodolgy</h2>

This is a modular workshop, designed to be used in a linear fashion - you'll start at Module 1 and work your way through to the last one. You can, however, use these modules independently in many cases, and the Workshop exercises point off to Labs, which can often be taken independently as well. 

If you are working through the Workshop with an instructor, you'll get additional instructions on the Workshop and you may be provided with a special environment for the class. You'll be notified if that's the case when you sign up for the Workshop. Otherwise, if you are following along on your own, <a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/00-prerequisites.md" target="_blank">Make sure you check out the <b>prerequisite</b> page before you start</a>. You'll need all of the items loaded there before you can proceed with the Workshop Labs. If you plan to just read through the Workshop, the Labs are optional.

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">Workshop Modules and Agenda</h2>

This is a modular workshop, and in each section, you'll learn concepts, technologies and processes to help you complete the solution. The times shown below are for an instructor-led course, you may also take the modules in a self-paced fashion.

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

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/geopin.png?raw=true"><b>  Next Steps</b></h2>

Next, Continue to <a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/02-ModernizingYourDataEstateWithSQLServer2019.md" target="_blank"><i> 02 - Modernizing Your Data Estate with SQL Server 2019</i></a>.

<br>
<img style="height: 400; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/Data.png?raw=true">
<br>
