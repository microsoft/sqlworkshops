
![](graphics/microsoftlogo.png)

# Workshop: SQL Server 2019 on OpenShift (CTP 2.5)

#### <i>A Microsoft Course from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="graphics/textbubble.png"> <h2>About this Workshop</h2>

Welcome to this Microsoft solutions workshop on *SQL Server 2019 on OpenShift*.

Red Hat OpenShift Container Platform brings together Docker and Kubernetes, and provides an API to manage these services. OpenShift Container Platform allows you to create and manage containers. From a perspective of SQL Server, OpenShift provides:

- A scalable architecture to deploy containerized applications and data platforms such as SQL Server
- Persistent storage for stateful containers like SQL Server
- Built-in load balancers to abstract application connections to SQL Server
- Built-in high availability for stateful containers like SQL Server
- An ecosystem for Operators to simplify application deployment and manage high availability

In this course you will learn the basics of deployment, connection, query execution, performance, high availability, operators, and Always On Availability Groups in SQL Server 2019 with OpenShift.

You will interact with an OpenShift cluster using the OpenShift CLI program `oc` and use the concepts of projects, deployments, pods, labels, PersistentVolumeClaims, and LoadBalancer services as you deploy and use SQL Server on OpenShift. 

This README.MD file explains how the workshop is structured, what you will learn, and the technologies you will use in this solution.

The workshop is currently built to support SQL Server on OpenShift 3.11 and uses SQL Server 2019 Preview components. A future version of the course will support OpenShift 4.0 with updates for SQL Server 2019 when it becomes generally available.

**NOTE**: *You're able to complete this workshop without having a prior knowledge of OpenShift, but if you would like to learn more about 
its features, architecture and management, these materials are available*:

- [Getting Started with OpenShift](https://docs.openshift.com/container-platform/3.11/getting_started/index.html)
- [The OpenShift Architecture](https://docs.openshift.com/container-platform/3.11/architecture/index.html)
- [Try OpenShift for Free with OpenShift Online](https://www.openshift.com/trial/)

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/checkmark.png"> <h3>Learning Objectives</h3>
<br>

When you complete this course, you will be able to:

- Understand the basics of deploying SQL Server on an OpenShift cluster.
- Connect and run queries against SQL Server deployed on OpenShift.
- Understand performance capabilities of SQL Server deployed on OpenShift
- Implement High Availability capabilities of SQL Server deployed on OpenShift
- Use an operator to deploy and manage an Always On Availability Group on OpenShift.

<p style="border-bottom: 1px solid lightgrey;"></p>
<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/building1.png"> <h2>Business Applications of this Workshop</h2>

<br>

- Developers looking to deploy a database container for their applications on OpenShift
- Database Administrators looking to understand how to deploy database platforms like SQL Server in a Kubernetes cluster using OpenShift.<br>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/listcheck.png"> <h2>Technologies used in this Workshop</h2>

<br>

 <table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 2px; border-color: gray;">

  <tr><th style="background-color: #1b20a1; color: white;">Technology</th> <th style="background-color: #1b20a1; color: white;">Description</th></tr>

  <tr><td><i>SQL Server</i></td><td>Database Platform produced by Microsoft</td></tr>
  <tr><td><i>SQL Server 2019</i></td><td>Most current release of SQL Server currently in preview</td></tr>
  <tr><td><i>Intelligent Query Processing</i></td><td>Automated query processing enhancements in SQL Server 2019</td></tr>
 <tr><td><i>Always On Availability Group</i></td><td>SQL Server High Availability Disaster Recovery capabilities based on replicas</i></td></tr>
  <tr><td><i>Linux</i></td><td>Operating system used in Containers and Container Orchestration</td></tr>
  <tr><td><i>Docker</i></td><td>Engine for running and manage containers</td></tr>
  <tr><td><i>Kubernetes</i></td><td>Orchestration and Management platform for Containers</td></tr>
  <tr><td><i>OpenShift<i></td><td>Family of containerization software developed by Red Hat</td></tr>
  <tr><td><i>OpenShift Platform<i></td><td>Kubernetes-based platform for containers</td></tr>
  <tr><td><i>oc</i></td><td>OpenShift CLI program. (Similar to the kubectl command)</td></tr>
  <tr><td><i>project</i></td><td>Equivalent to Kubernetes namespace</td></tr>
  <tr><td><i>Azure Data Studio<i></td><td>Graphical User Interface to execute T-SQL queries and manage SQL Server</td></tr>
  <tr><td><i>SQL Server Command Line Tools<i></td><td>Utilities to connect and query SQL Server such as sqlcmd</td></tr>

</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/owl.png"> <h2>Before Taking this Workshop</h2>

<br>

To complete this workshop you will need the following:

- A client computer connected to the Internet that has a Linux shell and can run SQL Server command line tools.
- Access to a OpenShift 3.11 cluster
- Access to all the scripts provided from this workshop from the GitHub repo.

The Prerequisites module in this workshop provides all the details of tools and software required to take this workshop.

You might be taking this workshop from an instructor who will provide access to an OpenShift cluster and possibly a client workstation with all the tools and files installed.

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/bulletlist.png"> 
<h3>Setup</h3>

A complete Prerequisites [document](sqlonopenshift/00_Prereqs.md) exists as part of this workshop. You will be guided to go through Prerequisites in the Next Steps at the bottom of this page.

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/education1.png"> <h2>Workshop Details</h2>

This workshop uses OpenShift, SQL Server 2019, Azure Data Studio, SQL Command Line Tools, and the OpenShift CLI (oc).

<table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 5px; border-color: gray;">

  <tr><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Primary Audience:</td><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Administrators looking to learn how to deploy, use, and manage SQL Server on OpenShift</td></tr>
  <tr><td>Secondary Audience:</td><td> Developers, Architects, and IT Pros</td></tr>
  <tr><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Level: </td><td style="background-color: Cornsilk; color: black; padding: 5px 5px0;"> 300</td></tr>
  <tr><td>Type:</td><td>Self-Paced or In-Person</td></tr>
  <tr><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">Length: </td><td style="background-color: Cornsilk; color: black; padding: 5px 5px;">2 hours (self-paced) 4 hours (In-Person)</td></tr>

</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/pinmap.png"> <h2>Related Workshops</h2><br>

- [Modernize your Database with SQL Server 2019](https://github.com/Microsoft/sqlworkshops/tree/master/ModernizeYourDatabases2019)
- [The OpenShift Interactive Learning Portal](https://learn.openshift.com/)

<br>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/bookpencil.png"> <h2>Workshop Modules</h2>

This is a modular workshop, and in each section, you'll learn concepts, technologies, and processes to help you complete the solution. 

**Proceed to Next Steps below to start the workhop.**
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
