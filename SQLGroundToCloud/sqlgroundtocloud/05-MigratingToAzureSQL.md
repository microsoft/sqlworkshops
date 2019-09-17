![](https://github.com/microsoft/sqlworkshops/blob/master/graphics/microsoftlogo.png?raw=true)

# Workshop: SQL Ground-to-Cloud

#### <i>A Microsoft workshop from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=true"> <h2> 05 - Migrate to Azure SQL </h2>

In the previous module, you learned about Azure SQL, the benefits, the options, and how to get there. You reviewed how to assess your on-premises estate, and in this module you'll actually migrate to [Azure SQL Database Managed Instance](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-managed-instance).  


(<a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/00-prerequisites.md" target="_blank">Make sure you check out the <b>Prerequisites</b> page before you start</a>. You'll need all of the items loaded there before you can proceed with the workshop.)

In this module, you will use the [Azure Database Migration Service](https://azure.microsoft.com/services/database-migration/) (DMS) to migrate the `TailspinToys` database from the on-premises SQL 2008 R2 database to SQL MI. At the end of the module, you'll also explore some of the security and performance features available. The activities in this module include:  
  
[5.1](#5.1): Migrate the database to SQL Managed instance   
[5.2](#5.2): Improve database security with Advanced Data Security (*Bonus*)   
[5.3](#5.3): Use online secondary for read-only queries (*Bonus*)   
[5.4](#5.4): After the Migration  

> **Note**:  
> This module is mainly guided labs. Proceed as instructed in each section. You may not have the time or desire to complete 5.2 and 5.3. They are optional, supplementary sections you can review at the end or at a later time.     


<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><a name="5.1">5.1 Migrate the database to SQL Managed instance</h2></a>

In this section, you will use the [Azure Database Migration Service](https://azure.microsoft.com/services/database-migration/) (DMS) to migrate the `TailspinToys` database from the on-premises SQL 2008 R2 database to SQL MI. Tailspin Toys mentioned the importance of their gamer information web application in driving revenue, so for this migration you will target the [Business Critical service tier](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-service-tier-business-critical).  

> The Business Critical service tier is designed for business applications with the highest performance and high-availability (HA) requirements. To learn more, read the [Managed Instance service tiers documentation](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance#managed-instance-service-tiers).  

This is the longest exercise in the module, so take your time (estimate about 30-45 minutes).  

First, you will create a new SMB network share on the SqlServer2008 VM. This will be the folder used by DMS for retrieving backups of the `TailspinToys` database during the database migration process. Next, you will use the SQL Server Configuration Manager to update the service account used by the SQL Server (MSSQLSERVER) to the `sqlmiuser` account. This is done to ensure the SQL Server service has the appropriate permissions to write backups to the shared folder.  

You'll then use the Azure Cloud shell to retrieve the information necessary to connect to your SQL MI and SqlServer2008 VM from DMS. You will also use the Azure Cloud Shell to create an Azure Active Directory (Azure AD) application and service principal (SP) that will provide DMS access to Azure SQL MI. You will grant the SP permissions to the hands-on-lab-SUFFIX resource group.  

Now that your environment is prepared, you can create a new online data migration project in DMS and migrate the `TailspinToys` database. Since you perform the migration as an "online data migration," the migration wizard will continue to monitor the SMB network share for newly added log files. This allows for any updates that happen on the source database to be captured until you cut over to the SQL MI database. You'll then add a record to one of the database tables, backup the logs, and complete the migration of the `TailspinToys` database by cutting over to the SQL MI database. You will then be able to connect to the SQL MI database using SSMS, and quickly verify the migration.  

With the `TailspinToys` database now running on SQL MI in Azure, the next step is to make the required modifications to the TailspinToys gamer information web application.  




<h3><p><img style="float: left; margin: 0px 5px 5px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><a name="5.1.1"><a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/Lab-MigratingToAzureSQLManagedInstance.md#Activity-1">Activities</h3></p></a>

Complete activities 1-9 by following the links below. Once you're in Activity 1, you can continue to the next activity through Activity 9 (the links below all point to different parts of the same overall lab). When are you done with activities 1-9, come back here for the next section (5.2).   

> **Note**:  
> If you were provided an environment to do this workshop, you should review Activities 4 and 5, but a service principal has already been created (no action required).   
  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a name="5.1.1"><a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/Lab-MigratingToAzureSQLManagedInstance.md#Activity-1">Activity 1</a>: Create an SMB network share on the SQLServer2008VM  

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a name="5.1.2"><a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/Lab-MigratingToAzureSQLManagedInstance.md#Activity-2">Activity 2</a>: Change MSSQLSERVER service to run under sqlmiuser account  

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a name="5.1.3"><a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/Lab-MigratingToAzureSQLManagedInstance.md#Activity-3">Activity 3</a>: Create a backup of TailspinToys database  

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a name="5.1.4"><a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/Lab-MigratingToAzureSQLManagedInstance.md#Activity-4">Activity 4</a>: Retrieve SQL MI, SQL Server 2008 VM, and service principal connection information **(review only - no action needed)**   

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a name="5.1.5"><a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/Lab-MigratingToAzureSQLManagedInstance.md#Activity-5">Activity 5</a>: Create a service principal **(review only - no action needed)**  

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a name="5.1.6"><a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/Lab-MigratingToAzureSQLManagedInstance.md#Activity-6">Activity 6</a>: Create and run an online data migration project   

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a name="5.1.7"><a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/Lab-MigratingToAzureSQLManagedInstance.md#Activity-7">Activity 7</a>: Perform migration cutover  

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a name="5.1.8"><a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/Lab-MigratingToAzureSQLManagedInstance.md#Activity-8">Activity 8</a>: Verify database and transaction log migration  

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a name="5.1.9"><a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/Lab-MigratingToAzureSQLManagedInstance.md#Activity-9">Activity 9</a>: Update the application  
 


<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><a name="5.2">5.2 Improve database security with Advanced Data Security (<i>Bonus</i>)</h2></a>

[Advanced Data Security](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-advanced-data-security) is a unified package for advanced SQL security capabilities. It includes functionality for discovering and classifying sensitive data, surfacing and mitigating potential database vulnerabilities, and detecting anomalous activities that could indicate a threat to your database. It provides a single go-to location for enabling and managing these capabilities.  

In this exercise, you'll enable Advanced Data Security, configure Data Discovery and Classification, and review the Vulnerability Assessment. At the end, you'll also receive a pointer to a Dynamic Data Masking lab extension.
  

<h3><p><img style="float: left; margin: 0px 5px 5px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><a name="5.1.1"><a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/Lab-MigratingToAzureSQLManagedInstance.md#Activity-1">Activities</h3></p></a> 

Complete activities 1-3 by following the links below. Once you're in Activity 1, you can continue to the next activity through Activity 3 (the links below all point to different parts of the same overall lab). When are you done with activities 1-3, come back here for the next section (5.3).   


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a name="5.2.1"><a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/Lab-MigratingToAzureSQLManagedInstance.md#Activity-2-1">Activity 1</a>: Enable Advanced Data Security  

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a name="5.2.2"><a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/Lab-MigratingToAzureSQLManagedInstance.md#Activity-2-2">Activity 2</a>: Configure SQL Data Discovery and Classification  

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a name="5.2.3"><a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/Lab-MigratingToAzureSQLManagedInstance.md#Activity-2-3">Activity 3</a>: Review Advanced Data Security Vulnerability Assessment  

<p style="border-bottom: 1px solid lightgrey;"></p>
<h2><a name="5.3">5.3 Use online secondary for read-only queries (<i>Bonus</i>)</h2></a>

In this exercise, you will look at how you can use the automatically created online secondary for reporting, without feeling the impacts of a heavy transactional load on the primary database. Each database in the SQL MI Business Critical tier is automatically provisioned with several AlwaysON replicas to support the availability SLA. Using [**Read Scale-Out**](https://docs.microsoft.com/azure/sql-database/sql-database-read-scale-out) allows you to load balance Azure SQL Database read-only workloads using the capacity of one read-only replica.  

<h3><p><img style="float: left; margin: 0px 5px 5px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><a name="5.1.1"><a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/Lab-MigratingToAzureSQLManagedInstance.md#Activity-3-1">Activities</h3></p></a>

Complete activities 1-3 by following the links below. Once you're in Activity 1, you can continue to the next activity through Activity 3 (the links below all point to different parts of the same overall lab). When are you done with activities 1-3, come back here for the next section (5.4).   

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a name="5.3.1"><a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/Lab-MigratingToAzureSQLManagedInstance.md#Activity-3-1">Activity 1</a>: View Leaderboard report in Tailspin Toys web application  

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a name="5.3.2"><a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/Lab-MigratingToAzureSQLManagedInstance.md#Activity-3-2">Activity 2</a>: Update read only connection string  

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a name="5.3.3"><a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/Lab-MigratingToAzureSQLManagedInstance.md#Activity-3-3">Activity 3</a>: Reload leaderboard report in the Tailspin Toys web application  

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><a name="5.4">5.4 After the Migration</a></h2>

In this module, you used the [Azure Database Migration Service](https://azure.microsoft.com/services/database-migration/) (DMS) to migrate the `TailspinToys` database from the on-premises SQL 2008 R2 database to SQL MI. You then updated the web application to use the SQL MI created, and enabled [advanced security features](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-advanced-data-security). Finally, you set up your application to leverage the [online secondary replica](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-read-scale-out) to handle heavy read workloads.  

Now that Tailspin Toys has completed a migration for their gaming database. They'll want to leverage the [post-migration validation and optimization guide](https://docs.microsoft.com/en-us/sql/relational-databases/post-migration-validation-and-optimization-guide?view=sql-server-2017) to ensure data completeness and uncover and resolve performance issues.  

If and when Tailspin Toys chooses to scale their migration to other instances and databases, they can leverage the same process you've seen in Modules 4 and 5, but should also refer to the guidance Microsoft provides on [scaling a migration to Azure](https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/migrate/azure-best-practices/contoso-migration-scale). 

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/owl.png?raw=true"><b>For Further Study</b></p>
<ul>
    <li><a href="https://www.microsoft.com/handsonlabs" target="_blank">Microsoft Hands On Labs</a> offers free self-paced lab environments as well as a request form for instructor led lab environments. As of last update, there are about eight labs available around Azure SQL (assessment, migration, app innovation, row level security, managed instance, and more).</li>
    <li><a href="https://www.microsoft.com/handsondemos" target="_blank">Microsoft Demos</a> is similar to Hands On Labs, but offers easy to set up demos that are free for certain internals and partners. As of last update, there are about seven demos available around Azure SQL.</li>
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