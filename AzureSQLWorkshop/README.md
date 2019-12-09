![](graphics/microsoftlogo.png)

# The Azure SQL Workshop

#### <i>A Microsoft Course from the SQL team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/textbubble.png"> <h2>About this Workshop</h2>

Welcome to this Microsoft solutions workshop on *Azure SQL*.  

In this one day, hands-on, scenario-driven workshop, you'll learn how to translate your existing SQL Server expertise to Azure SQL including Azure SQL Database and Azure SQL managed instance. At the end of the day, you should have a foundational knowledge of what to use when, as well as how to configure, monitor, and troubleshoot the “meat and potatoes” of SQL Server in Azure: security, performance, and availability. You will learn about not only the “what”, but also the “how” and the “why”. You’ll also walk away with resources and tools so you can go as deep as your scenario requires.  

This README.MD file explains how the workshop is laid out, what you will learn, and the technologies you will use in this solution.

(You can view all of the [source files for this workshop on this github site, along with other workshops as well. Open this link in a new tab to find out more.](https://github.com/BuckWoody/workshops))

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/checkmark.png"> <h3>Learning Objectives</h3>

After this workshop, you should be able to:
<br>

- Determine which Azure SQL deployment option (virtual machines, single databases, serverless databases, elastic pools of databases, hyperscale databases, and managed instances) and service tier should be used for scenarios that meet the needs of your application.
- Deploy, configure, monitor, and troubleshoot security, performance, and availability scenarios in Azure SQL using both familiar and new tools and techniques.
- Harness the “power of the cloud” including automation and intelligent capabilities of Azure SQL.
-	Translate your existing SQL Server expertise to Azure SQL expertise.


The goal of this workshop is to train experienced SQL Server professionals.  

<p style="border-bottom: 1px solid lightgrey;"></p>
<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/building1.png"> <h2>Business Applications of this Workshop</h2>

Many organizations are faced with an aging or under-engineered data platform strategy. There's been a big trend of moving existing systems to the cloud, building new applications quickly with the cloud, and off-loading some of the on-premises costs. You need a plan for how to move some workloads to the cloud, and you need to understand how to set your organization up for success. You also need to understand how the role of a DBA or Data professional stays the same, and what changes you'll have to make. This workshop will prepare you to be successful in Azure.  

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/listcheck.png"> <h2>Technologies used in this Workshop</h2>

The solution includes the following technologies - although you are not limited to these, they form the basis of the workshop. At the end of the workshop you will learn how to extrapolate these components into other solutions. You will also be provided with references to much deeper training provided.

 <table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 2px; border-color: gray;">

  <tr><th style="background-color: #1b20a1; color: white;">Technology</th> <th style="background-color: #1b20a1; color: white;">Description</th></tr>

  <tr><td>Azure SQL virtual machines</td><td>Use full versions of SQL Server in the cloud without having to manage any on-premises hardware</td></tr>
  <tr><td>Azure SQL Database</td><td>Managed SQL database service (includes single databases and elastic pools)</td></tr>
  <tr><td>Azure SQL managed instance</td><td>Managed SQL Server service (includes single instance and instance pools)</td></tr>
  <tr><td>SQL Server Management Studio (SSMS)</td><td>Graphical User Interface Management and Query Tool</td></tr>
  <tr><td>Azure Data Studio (ADS)</td><td>Graphical User Interface to execute T-SQL queries, notebooks, and manage Azure Data services</td></tr>

</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/owl.png"> <h2>Before Taking this Workshop</h2>

You'll need a local system that you are able to install software on. The workshop demonstrations use Microsoft Windows as an operating system and all examples use Windows for the workshop. Optionally, you can use a Microsoft Azure Virtual Machine (VM) to install the software on and work with the solution.

You must have a Microsoft Azure account with the ability to create assets.

This workshop expects that you understand and are experienced in working with, maintaining, and developing with SQL Server. Having some familiarity with the general structure of Azure will be helpful, but not required, before attending the workshop.

If you are new to these, here are a few references you may want to review prior to class:


-  [Pro SQL Server on Linux, Bob Ward: this book (available online) introduces SQL Server on Linux, but in the process walks through fundamental SQL Server topics](https://www.oreilly.com/library/view/pro-sql-server/9781484241288/)
-  [SQL Server 2019 Workshop: this workshop will help you get up to speed on the latest innovations available in SQL Server 2019. You'll be able to directly apply much of that knowledge in this workshop](https://github.com/microsoft/sqlworkshops/tree/master/sql2019workshop)
-  [Azure fundamentals learning path: this free, hands-on learning path will help you understand the fundamentals of Azure at a general level (not data focused)](https://docs.microsoft.com/en-us/learn/paths/azure-fundamentals/)  


<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/bulletlist.png"> <h3>Technical Setup</h3>

<a href="url" target="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLWorkshop/azuresqlworkshop/00-Prerequisites.md">A full prerequisites document is located here</a>. These instructions should be completed before the workshop starts, since you will not have time to cover these in class. <i>Remember to turn off any Virtual Machines from the Azure Portal when not taking the class so that you do incur charges (shutting down the machine in the VM itself is not sufficient)</i>.

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/education1.png"> <h2>Workshop Details</h2>

This workshop uses Azure SQL and the Azure platform, with a focus on Azure SQL Database and managed instance.

<table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 5px; border-color: gray;">

  <tr><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Primary Audience:</td><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">SQL Server professionals tasked with translating their SQL Server skills to the cloud</td></tr>
  <tr><td>Secondary Audience:</td><td> Data professionals, Architects, Developers, IT Pros, Data Engineers</td></tr>
  <tr><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Level:</td><td style="background-color: Cornsilk; color: black; padding: 5px 5px;"> 200-300 </td></tr>
  <tr><td>Type:</td><td>Self-Paced or Instructor Led</td></tr>
  <tr><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Length:</td><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">8 hours</td></tr>

</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/pinmap.png"> <h2>Related Workshops</h2>
  
    

 - [SQL Ground to Cloud](https://github.com/microsoft/sqlworkshops/tree/master/SQLGroundToCloud)
  - [Azure SQL Labs](https://github.com/microsoft/sqlworkshops/tree/master/AzureSQLLabs)

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/bookpencil.png"> <h2>Workshop Modules</h2>

This is a modular workshop, and in each section, you'll learn concepts, technologies and processes to help you complete the solution.

<table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 5px; border-color: gray;">

  <tr><td style="background-color: AliceBlue; color: black;"><b>Module</b></td><td style="background-color: AliceBlue; color: black;"><b>Topics</b></td></tr>

  <tr><td><a href="url" target="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLWorkshop/azuresqlworkshop/01-IntroToAzureSQL.md">01 - Introduction to Azure SQL</a></td><td>Starting with a brief history of why and how we built Azure SQL, you’ll then learn about the various deployment options and service tiers, including what to use when. This includes Azure SQL Database and Azure SQL managed instance. Understanding what Platform as a Service (PaaS) encompasses and how it compares to the SQL Server “box” will help level-set what you get (and don’t get) when you move to the cloud. We’ll cover deployment, configuration, and other getting started related tasks for Azure SQL (hands-on).  </td></tr>
  <tr><td style="background-color: AliceBlue; color: black;"><a href="url" target="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLWorkshop/azuresqlworkshop/02-Security.md">02 - Security</a> </td><td td style="background-color: AliceBlue; color: black;">Ensuring security and compliance of your data is always a top priority. You’ll learn how to use Azure SQL to secure your data, how to configure logins and users, how to use tools and techniques for monitoring security, how to ensure your data meets industry and regulatory compliance standards, and how to leverage the extra benefits and intelligence that is only available in Azure. We’ll also cover some of the networking considerations for securing SQL.</td></tr>
  <tr><td><a href="url" target="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLWorkshop/azuresqlworkshop/03-Performance.md">03 - Performance</a></td><td>You’ve been responsible for getting your SQL fast, keeping it fast, and making it fast again when something is wrong. We’ll show you how to leverage your existing performance skills, processes, and tools and apply them to Azure SQL, including taking advantage of the intelligence in Azure to keep your database tuned.</td></tr>
  <tr><td style="background-color: AliceBlue; color: black;"><a href="url" target="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLWorkshop/azuresqlworkshop/04-Availability.md">04 - Availability</a> </td><td td style="background-color: AliceBlue; color: black;">Depending on the SLA your business requires, Azure SQL has the options you need including built-in capabilities. You will learn how to translate your knowledge of backup/restore, Always on failover cluster instances, and Always On availability groups with the options for business continuity in Azure SQL.</td></tr>  <tr><td><a href="url" target="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLWorkshop/azuresqlworkshop/05-PuttingItTogether.md">05 - Putting it all together</a></td><td>In the final activity, we’ll validate your Azure SQL expertise with a challenging problem-solution exercise. We’ll then broaden your horizons to the many other opportunities and resources for personal and corporate growth that Azure offer.</td></tr>


</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/geopin.png"><b>Next Steps</b></p>

Next, Continue to <a href="url" target="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLWorkshop/azuresqlworkshop/00-Prerequisites.md"><i> Prerequisites</i></a>