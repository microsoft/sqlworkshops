<img src="https://github.com/Microsoft/sqlworkshops/blob/master/graphics/solutions-microsoft-logo-small.png?raw=true" alt="Microsoft">
<br>

# Workshop: Microsoft SQL Server Machine Learning Services

#### <i>A Microsoft Course from the SQL Server team</i>

## 01 - SQL Server Machine Learning Services

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/Microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=true"> <h2>About this Workshop</h2>

Welcome to this Microsoft solutions workshop on *Machine Learning in SQL Server*. In this workshop, you'll learn how to use SQL Server to implement a complete Data Science solution using Machine Learning. You'll do this using a team-based process to implement your solution, and we provide a complete set of steps, project documents and more for this process. This course can be used as a template for a production-ready project.

The focus of this workshop is to understand how to create a machine learning solution completely within SQL Server.

You'll start by understanding the problem your organization wants to solve, collecting the data you need to solve problem, then creating an experiment, testing the experiment, and on to operationalizing the Machine Learning model - all with a focus on how to extrapolate what you have learned to create other solutions for your organization.

This README.MD file explains how the workshop is laid out, what you will learn, and the technologies you will use in this solution.

You can view all of the [source files for this workshop on this GitHub site, along with other workshops as well. Open this link in a new tab to find out more.](https://aka.ms/sqlworkshops)

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/Microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"> <h3>Learning Objectives</h3>

In this workshop you'll learn:
<br>

- The SQL Server Machine Learning Architecture
- What Machine Learning is and what problems it solves
- The process for creating a Data Science project
- A team process consisting of phases to create a prediction or classification
- How to configure and use Machine Learning Services in SQL Server
- How to call the predictions or classifications in SQL Server one at a time, or in a batch request mode

This Workshop uses SQL Server 2019 (although the instructions work with SQL Server 2017 as well), and uses the Notebook feature in Azure Data Studio to send commands in SQL, Python, R and Java to a SQL Server Instance to demonstrate an end-to-end solution using the Team Data Science Process.  

The goal of this workshop is to train data professionals to use Machine Learning in SQL Server for a secure on-premises, in-cloud, or hybrid approach to Data Science solutions.

The concepts and skills taught in this workshop form the starting points for:

    - Data Professionals who need to learn about Machine Learning, and implementing Data Science projects in SQL Server
    - Data Engineers who are or will be part of the Data Science Team
    - Data Scientists who need to learn about working with Machine Learning, Deep Learning, and AI projects in a secure SQL Server platform

<p style="border-bottom: 1px solid lightgrey;"></p>
<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/Microsoft/sqlworkshops/blob/master/graphics/building1.png?raw=true"> <h2>Business Applications of this Workshop</h2>

Businesses require deep information about their customers' behavior, and how they can leverage classification and predictive algorithms to maximize their value to the customer.  Using Machine Learning algorithms over the data they already collect in an RDBMS, they can make more intelligent decisions about their actions.

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/Microsoft/sqlworkshops/blob/master/graphics/listcheck.png?raw=true"> <h2>Technologies used in this Workshop</h2>

The solution includes the following technologies - although you are not limited to these, they form the basis of the workshop. At the end of the workshop you will learn how to extrapolate these components into other solutions. You will cover these at an overview level, with references to much deeper training provided.

 <table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 2px; border-color: gray;">

  <tr><th style="background-color: #1b20a1; color: white;">Technology</th> <th style="background-color: #1b20a1; color: white;">Description</th></tr>

  <tr><td>R</td><td>For Machine Learning, several languages are available for SQL Server. This course will focus on the data language called `R`, which is used for deep analysis, Machine Learning, and much more.</td></tr>
  <tr><td>SQL Server Machine Learning Services</td><td>Microsoft's SQL Server provides a complete data platform from sourcing, ingesting, processing and learning from data at scale, all with the highest levels of security and integration.</td></tr>

</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/Microsoft/sqlworkshops/blob/master/graphics/owl.png?raw=true"> <h2>Before Taking this Workshop</h2>

You'll need a local system that you are able to install software on. The workshop exercises use Microsoft Windows as an operating system and all examples use Windows for the workshop. Optionally, you can use a Microsoft Azure Virtual Machine (VM) to install the software on and work with the solution. If you plan to simply audit the course, the files have the results of the exercises already completed for you.

This workshop expects that you understand Relational Database systems (RDBMS) and the basics of working with data and datatypes.

If you are new to any of these topics, here are a few references you can complete prior to class:

-  [The Microsoft SQL Server Platform](https://www.microsoft.com/en-us/learning/sql-training.aspx)
-  [R for Machine Learning](https://www.edx.org/course/introduction-to-r-for-data-science-2)

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/Microsoft/sqlworkshops/blob/master/graphics/bulletlist.png?raw=true"> <h3>Setup</h3>

A full pre-requisites document is located below in the <b>Next Steps</b> area. These instructions should be completed before the workshop starts, since you will not have time to cover these in class. <i>Remember to turn off any Virtual Machines from the Azure Portal when not taking the class so that you do incur charges (shutting down the machine in the VM itself is not sufficient)</i>.

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/Microsoft/sqlworkshops/blob/master/graphics/education1.png?raw=true"> <h2>Workshop Details</h2>

This workshop uses Machine Learning with R in SQL Server, with a focus on a clustering algorithm to solve a real-world problem.

<table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 5px; border-color: gray;">

  <tr><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Primary Audience:</td><td style="background-color: Cornsilk; color: black; padding: 5px 5px;"> Data Professionals tasked with Data Science Projects</td></tr>
  <tr><td>Secondary Audience:</td><td> Data Scientists interested in a single platform for Data Science and a complete project/phase approach</td></tr>
  <tr><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Level: </td><td style="background-color: Cornsilk; color: black; padding: 5px 5px0;"> 200 </td></tr>
  <tr><td>Type:</td><td>In-Person, Online, or from GitHub</td></tr>
  <tr><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Length: </td><td style="background-color: Cornsilk; color: black; padding: 5px 5px;"> 4 hours or less</td></tr>

</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/Microsoft/sqlworkshops/blob/master/graphics/pinmap.png?raw=true"> <h2>Related Workshops and Tutorials</h2>

 - [Using Machine Learning Services in SQL Server with Java and Microsoft Azure Cognitive Services](https://github.com/amthomas46/SQL/tree/master/sql-cs-icc)
 - [Microsoft R in SQL Server for Developers](https://docs.microsoft.com/en-us/sql/advanced-analytics/tutorials/sqldev-in-database-r-for-sql-developers?view=sql-server-2017)

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/Microsoft/sqlworkshops/blob/master/graphics/geopin.png?raw=true"><b>Next Steps</b></p>

Next, Continue to <a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLServerMLServices/00-Prerequisites.md" target="_blank"><i> Pre-Requisites</i></a>