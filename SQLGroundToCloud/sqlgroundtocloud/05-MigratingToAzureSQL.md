![](https://github.com/microsoft/sqlworkshops/blob/master/graphics/microsoftlogo.png?raw=true)

# Workshop: SQL Ground-to-Cloud

#### <i>A Microsoft workshop from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=true"> <h2> 05 - Migrate to Azure SQL </h2>

In the previous module, you learned about Azure SQL, the benefits, the options, and how to get there. You reviewed how to assess your on-premises estate, and in this module you'll actually migrate to [Azure SQL Database Managed Instance](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-managed-instance).  


(<a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/00-Pre-Requisites.md" target="_blank">Make sure you check out the <b>Prerequisites</b> page before you start</a>. You'll need all of the items loaded there before you can proceed with the workshop.)

In this module, you will use the [Azure Database Migration Service](https://azure.microsoft.com/services/database-migration/) (DMS) to migrate the `TailspinToys` database from the on-premises SQL 2008 R2 database to SQL MI. At the end of the module, you'll also explore some of the security and performance features available. The activities in this module include:  
  
[5.1](#5.1): Migrate the database to SQL Managed instance (30 minutes)  
&ensp;&ensp;&ensp;[Activity 1](#5.1.1): Create an SMB network share on the SQLServer2008VM  
&ensp;&ensp;&ensp;[Activity 2](#5.1.2): Change MSSQLSERVER service to run under sqlmiuser account  
&ensp;&ensp;&ensp;[Activity 3](#5.1.3): Create a backup of TailspinToys database  
&ensp;&ensp;&ensp;[Activity 4](#5.1.4): Retrieve SQL MI, SQL Server 2008 VM, and service principal connection information  
&ensp;&ensp;&ensp;[Activity 5](#5.1.5): Create a service principal  
&ensp;&ensp;&ensp;[Activity 6](#5.1.6): Create and run an online data migration project  
&ensp;&ensp;&ensp;[Activity 7](#5.1.7): Perform migration cutover  
&ensp;&ensp;&ensp;[Activity 8](#5.1.8): Verify database and transaction log migration  
&ensp;&ensp;&ensp;[Activity 9](#5.1.9): Update the application  
[5.2](#5.2): Improve database security with Advanced Data Security (15 minutes)  
&ensp;&ensp;&ensp;[Activity 1](#5.2.1): Enable Advanced Data Security  
&ensp;&ensp;&ensp;[Activity 2](#5.2.2): Configure SQL Data Discovery and Classification  
&ensp;&ensp;&ensp;[Activity 3](#5.2.3): Review Advanced Data Security Vulnerability Assessment  
[5.3](#5.3): Use online secondary for read-only queries (15 minutes)  
&ensp;&ensp;&ensp;[Activity 1](#5.3.1): View Leaderboard report in Tailspin Toys web application  
&ensp;&ensp;&ensp;[Activity 2](#5.3.2): Update read only connection string  
&ensp;&ensp;&ensp;[Activity 3](#5.3.3): Reload leaderboard report in the Tailspin Toys web application  
[5.4](#5.4): After the Migration

SELF-PACED USERS ONLY: If you are using this module self-paced, carefully read through Module 4 of this workshop, complete the assessment lab in Module 4.4 first. Then, read carefully and complete the labs in this module.  


<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><a name="5.1">5.1 Migrate the database to SQL Managed instance (30 minutes)</h2></a>

In this section, you will use the [Azure Database Migration Service](https://azure.microsoft.com/services/database-migration/) (DMS) to migrate the `TailspinToys` database from the on-premises SQL 2008 R2 database to SQL MI. Tailspin Toys mentioned the importance of their gamer information web application in driving revenue, so for this migration you will target the [Business Critical service tier](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance#managed-instance-service-tiers).  

> The Business Critical service tier is designed for business applications with the highest performance and high-availability (HA) requirements. To learn more, read the [Managed Instance service tiers documentation](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance#managed-instance-service-tiers).  



<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="5.1.1">Activity 1: Create an SMB network share on the SQLServer2008VM</b></p></a>

In this task, you will create a new SMB network share on the SqlServer2008 VM. This will be the folder used by DMS for retrieving backups of the `TailspinToys` database during the database migration process.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="5.1.2">Activity 2: Change MSSQLSERVER service to run under sqlmiuser account</b></p></a>

In this task, you will use the SQL Server Configuration Manager to update the service account used by the SQL Server (MSSQLSERVER) to the `sqlmiuser` account. This is done to ensure the SQL Server service has the appropriate permissions to write backups to the shared folder.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="5.1.3">Activity 3: Create a backup of TailspinToys database</b></p></a>

To perform online data migrations, DMS looks for backups and logs in the SMB shared backup folder on the source database server. In this task, you will create a backup of the `TailspinToys` database using SSMS, and write it to the SMB network share you created in the previous task. The backup file needs to include a checksum, so you will add that during the backup steps.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="5.1.4">Activity 4: Retrieve SQL MI, SQL Server 2008 VM, and service principal connection information</b></p></a>

In this task, you will use the Azure Cloud shell to retrieve the information necessary to connect to your SQL MI and SqlServer2008 VM from DMS.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="5.1.5">Activity 5: Create a service principal</b></p></a>

> **Note**:  
> If you're doing this lab as part of a workshop and were provided an environment to use, this step has already been completed. You can review, but there is nothing you need to do. Please refer to instructor guidance.  

In this task, you will use the Azure Cloud Shell to create an Azure Active Directory (Azure AD) application and service principal (SP) that will provide DMS access to Azure SQL MI. You will grant the SP permissions to the hands-on-lab-SUFFIX resource group.

> **Note**:  
> You must have rights within your Azure AD tenant to create applications and assign roles to complete this task. If you are blocked by this, but still want to do a migration with Azure Database Migration Services, you can perform an offline migration. In Activity 6, select offline instead of online migration in Step 3, and instead of Step 7, you can refer to [this section of a migrating to Azure SQL Database Managed Instance offline tutorial](https://docs.microsoft.com/en-us/azure/dms/tutorial-sql-server-to-managed-instance#specify-target-details).


<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="5.1.6">Activity 6: Create and run an online data migration project </b></p></a>

In this task, you will create a new online data migration project in DMS for the `TailspinToys` database.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="5.1.7">Activity 7: Perform migration cutover</b></p></a>

Since you performed the migration as an "online data migration," the migration wizard will continue to monitor the SMB network share for newly added log files. This allows for any updates that happen on the source database to be captured until you cut over to the SQL MI database. In this task, you will add a record to one of the database tables, backup the logs, and complete the migration of the `TailspinToys` database by cutting over to the SQL MI database.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="5.1.8">Activity 8: Verify database and transaction log migration</b></p></a>

In this task, you will connect to the SQL MI database using SSMS, and quickly verify the migration.



<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="5.1.9">Activity 9: Update the application</b></p></a>


With the `TailspinToys` database now running on SQL MI in Azure, the next step is to make the required modifications to the TailspinToys gamer information web application.

>**Note**: SQL Managed Instance has a private IP address in its own VNet, so to connect an application you need to configure access to the VNet where Managed Instance is deployed. To learn more, read [Connect your application to Azure SQL Database Managed Instance](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance-connect-app).

>**Note**: The architecture diagram from Module 4 explains a web app being deployed to Azure. Due to time restraints, the lab will deal with switching the app running on the VM locally to using SQL MI (not the deployment to Azure or integrating the App Service with the Virtual Network). In the [extended version of these labs](https://github.com/microsoft/MCW-Migrating-SQL-databases-to-Azure/blob/master/Hands-on%20lab/HOL%20step-by-step%20-%20Migrating%20SQL%20databases%20to%20Azure.md#exercise-3-update-the-web-application-to-use-the-new-sql-mi-database), or if you have time at the end of the day, you can do that.


In this activity, you will create an RDP connection to the JumpBox VM, and then using Visual Studio on the JumpBox, run the `TailspinToysWeb` application on the VM.  


> **Note**: If you want to complete an extension of this lab where you deploy the web app to Azure and integrate the App Service within the virtual network using point-to-site and VNet integration, see exercises 3 and 4 in the non-abbreviated lab [here](https://github.com/microsoft/MCW-Migrating-SQL-databases-to-Azure/blob/master/Hands-on%20lab/HOL%20step-by-step%20-%20Migrating%20SQL%20databases%20to%20Azure.md).


<br>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><a name="5.2">5.2 Improve database security with Advanced Data Security</h2></a>

[Advanced Data Security](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-advanced-data-security) is a unified package for advanced SQL security capabilities. It includes functionality for discovering and classifying sensitive data, surfacing and mitigating potential database vulnerabilities, and detecting anomalous activities that could indicate a threat to your database. It provides a single go-to location for enabling and managing these capabilities.  

In this exercise, you'll enable Advanced Data Security, configure Data Discovery and Classification, and review the Vulnerability Assessment. At the end, you'll also receive a pointer to a Dynamic Data Masking lab extension.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="5.2.1">Activity 1: Enable Advanced Data Security</b></p></a>

In this task, you will enable Advanced Data Security (ADS) for all databases on the Managed Instance.


<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="5.2.2">Activity 2: Configure SQL Data Discovery and Classification</b></p></a>

In this task, you will look at the [SQL Data Discovery and Classification](https://docs.microsoft.com/sql/relational-databases/security/sql-data-discovery-and-classification?view=sql-server-2017) feature of Advanced Data Security. Data Discovery & Classification introduces a new tool for discovering, classifying, labeling & reporting the sensitive data in your databases. It introduces a set of advanced services, forming a new SQL Information Protection paradigm aimed at protecting the data in your database, not just the database. Discovering and classifying your most sensitive data (business, financial, healthcare, etc.) can play a pivotal role in your organizational information protection stature.

>**Note**: This functionality is currently available *in Preview* for SQL MI through the Azure portal.



<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="5.2.3">Activity 3: Review Advanced Data Security Vulnerability Assessment</b></p></a>

In this task, you will review an assessment report generated by ADS for the `TailspinToys` database and take action to remediate one of the findings in the `TailspinToys` database. The [SQL Vulnerability Assessment service](https://docs.microsoft.com/azure/sql-database/sql-vulnerability-assessment) is a service that provides visibility into your security state, and includes actionable steps to resolve security issues, and enhance your database security.



> **Note**: If you want to complete an extension of this lab where you  also explore the capabilities of [Dynamic Data Masking](https://docs.microsoft.com/en-us/sql/relational-databases/security/dynamic-data-masking?view=sql-server-2017), see exercise 6 and 4 in the non-abbreviated lab [here](https://github.com/microsoft/MCW-Migrating-SQL-databases-to-Azure/blob/master/Hands-on%20lab/HOL%20step-by-step%20-%20Migrating%20SQL%20databases%20to%20Azure.md).

<br>
<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><a name="5.3">5.3 Use online secondary for read-only queries (15 minutes)</h2></a>

In this exercise, you will look at how you can use the automatically created online secondary for reporting, without feeling the impacts of a heavy transactional load on the primary database. Each database in the SQL MI Business Critical tier is automatically provisioned with several AlwaysON replicas to support the availability SLA. Using [**Read Scale-Out**](https://docs.microsoft.com/azure/sql-database/sql-database-read-scale-out) allows you to load balance Azure SQL Database read-only workloads using the capacity of one read-only replica.

<br>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="5.3.1">Activity 1: View Leaderboard report in Tailspin Toys web application</b></p></a>

In this task, you will open a web report using the web application you deployed to your App Service.


<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="5.3.2">Activity 2: Update read only connection string</b></p></a>

In this task, you will enable Read Scale-Out for the `TailspinToys` database, using the `ApplicationIntent` option in the connection string. This option dictates whether the connection is routed to the write replica or to a read-only replica. Specifically, if the `ApplicationIntent` value is `ReadWrite` (the default value), the connection will be directed to the database’s read-write replica. If the `ApplicationIntent` value is `ReadOnly`, the connection is routed to a read-only replica.


<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="5.3.3">Activity 3: Reload leaderboard report in the Tailspin Toys web application</b></p></a>

In this task, you will refresh the Leaderboard report in the Tailspin Toys web app, and observe the results.



<br>
<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><a name="5.4">5.4 After the Migration</a></h2>

In this module, you used the [Azure Database Migration Service](https://azure.microsoft.com/services/database-migration/) (DMS) to migrate the `TailspinToys` database from the on-premises SQL 2008 R2 database to SQL MI. You then updated the web application to use the SQL MI created, and enabled [advanced security features](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-advanced-data-security). Finally, you set up your application to leverage the [online secondary replica](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-read-scale-out) to handle heavy read workloads.  

Now that Tailspin Toys has completed a migration for their gaming database. They'll want to leverage the [post-migration validation and optimization guide](https://docs.microsoft.com/en-us/sql/relational-databases/post-migration-validation-and-optimization-guide?view=sql-server-2017) to ensure data completeness and uncover and resolve performance issues.  

If and when Tailspin Toys chooses to scale their migration to other instances and databases, they can leverage the same process you've seen in Modules 4 and 5, but should also refer to the guidance Microsoft provides on [scaling a migration to Azure](https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/migrate/azure-best-practices/contoso-migration-scale). 

<br>


<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/owl.png?raw=true"><b>For Further Study</b></p>
<ul>
    <li><a href="https://www.microsoft.com/handsonlabs" target="_blank">Microsoft Hands On Labs</a> offers free self-paced lab environments as well as a request form for instructor led lab environments. As of last update, there are about eight labs available around Azure SQL (assessment, migration, app innovation, row level security, managed instance, and more).</li>
    <li><a href="https://www.microsoft.com/handsondemos" target="_blank">Microsoft Hands On Demos</a> is similar to Hands On Labs, but offers easy to set up demos that are free for certain internals and partners. As of last update, there are about seven demos available around Azure SQL.</li>
    <li><a href="https://datamigration.microsoft.com/
    " target="_blank">Azure Database Migration Guide</a> contains lots of resources that will help in guiding and supporting database migrations to Azure.</li>
    <li><a href="https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/migrate/azure-best-practices/contoso-migration-overview
    " target="_blank">The Azure Architecture Documentation</a> contains many migration patterns as well as full code samples, scenarios, and guidance about how to migrate on-prem estates. There are useful, detailed scenarios about rehosting to SQL MI and SQL VMs, as well as guidance of how to scale a migration, after you've done a PoC.</li>
    <li><a href="https://github.com/microsoft/MCW-Migrating-SQL-databases-to-Azure
    " target="_blank">MCW: Migrating SQL Databases to Azure</a> contains extended labs from what you've seen in Modules 4 and 5. There is an opportunity to see how the networking was configured, and deeper dives around the network and setup. </li>
    <li><a href="https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/migrate/azure-best-practices/contoso-migration-infrastructure
    " target="_blank">How to Deploy an Azure Infrastructure</a> and <a href="(https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/migrate/azure-best-practices/migrate-best-practices-networking
    " target="_blank">Best Practices for setting up networking</a> are also two very useful resources when moving to Azure.</li>
    <li><a href="https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/migrate/azure-best-practices/migrate-best-practices-costs
    " target="_blank">Best practices for costing and sizing workloads migrated to Azure</a></li>
    <li><a href="https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/migrate/azure-best-practices/migrate-best-practices-security-management
    " target="_blank">Best practices for securing and managing workloads migrated to Azure</a></li>

    


    

    


    
</ul>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/geopin.png?raw=true"><b >Next Steps</b></p>

Next, Continue to <a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/06-WhatToUseWhen.md" target="_blank"><i> 06 - What to Use When</i></a>.