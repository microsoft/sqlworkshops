
![](graphics/microsoftlogo.png)

# Workshop: SQL Server on OpenShift (Draft)

#### <i>A Microsoft Course from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/textbubble.png"> <h2>About this Workshop</h2>

Welcome to this Microsoft solutions workshop on *SQL Server on OpenShift*. In this workshop, you'll learn how deploy and use SQL Server on an OpenShift cluster.

This README.MD file explains how the workshop is laid out, what you will learn, and the technologies you will use in this solution.

The workshop is currently built to support SQL Server on OpenShift 3.11. A future version of the course will support OpenShift 4.0

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/checkmark.png"> <h3>Learning Objectives</h3>

- Learn the basics of deploying SQL Server on an OpenShift cluster.
- Learn how to connect and run queries aginst SQL Server deployed on OpenShift.
- Learn performance capabilities of SQL Server deployed on OpenShift
- Learn basic High Availability capabilties of SQL Server deployed on OpenShift
- Learn how to use an operator to deploy an Availability Group on OpenShift.

<p style="border-bottom: 1px solid lightgrey;"></p>
<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/building1.png"> <h2>Business Applications of this Workshop</h2>

- Developers looking to deploy a database container for their applications on OpenShift
- Database Administrators looking to understand how to deploy database platforms like SQL Server in a Kubernetes cluser using OpenShift.

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/listcheck.png"> <h2>Technologies used in this Workshop</h2>

- SQL Server
- Containers
- Docker
- Kubernetes
- SQL Server Tools
- Linux
- OpenShift
<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/owl.png"> <h2>Before Taking this Workshop</h2>

To complete this workshop you will need the following:

- A client computer connected to the Internet that has a Linux shell and can run SQL Server command line tools.
- Access to a OpenShift 3.11 cluster
- Access to all the scripts provided from this workshop from the GitHub repo.

You might be taking this workshop from an instructor who will provide access to an existing OpenShift cluster.

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/bulletlist.png"> 
<h3>Setup</h3>

A complete Prerequisites [document](sqlonopenshift/00_Prereqs.md) exists as part of this workshop.

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/education1.png"> <h2>Workshop Details</h2>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/pinmap.png"> <h2>Related Workshops</h2>


<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/bookpencil.png"> <h2>Workshop Modules</h2>

This is a modular workshop, and in each section, you'll learn concepts, technologies, and processes to help you complete the solution.

<table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 5px; border-color: gray;">

  <tr><td style="background-color: AliceBlue; color: black;"><b>Module</b></td><td style="background-color: AliceBlue; color: black;"><b>Topics</b></td></tr>

  <tr><td><a href="sqlonopenshift/01_Deploy.md" target="_blank">01 - Deploy SQL Server on OpenShift</a></td><td> Learn the fundamentals of deploying SQL Server container on OpenShift</td></tr>
  <tr><td style="background-color: AliceBlue; color: black;"><a href="sqlonopenshift/02_Query.md" target="_blank">02 - Connect and Query SQL Server</a> </td><td td style="background-color: AliceBlue; color: black;"> Learn the basics of connecting and running queries to a SQL Server container on OpenShift</td></tr>
  <tr><td><a href="sqlonopenshift/03_Performance.md" target="_blank">03 - Performance Capabilities of SQL Server</a></td><td> Learn how to boost query performance and take advantage of intelligent query processing</td></tr>
  <tr><td style="background-color: AliceBlue; color: black;"><a href="sqlonopenshift/04_HA.md" target="_blank">04 - High Availability of SQL Server on OpenShift</a> </td><td td style="background-color: AliceBlue; color: black;"> Learn the fundamentals of high availability for SQL Server on OpenShift</td></tr>  
  <tr><td><a href="sqlonopenshift/05_Operator.md" target="_blank">05 - Using an Operator with SQL Server </a></td><td> Learn how to deploy, configure, and setup Always On Availability Groups with an Operator on OpenShift</td></tr>
  <tr></tr>
  <tr></tr>

</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/geopin.png"><b>Next Steps</b></p>
Next, Continue to <a href="sqlonopenshift/00_Prereqs.md" target="_blank"><i> PreRequisites</i></a>
