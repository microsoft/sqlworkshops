![](../graphics/microsoftlogo.png)

# Module 4 - Performance

#### <i>The Azure SQL Workshop</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=true"> <h2>Overview</h2>

> You must complete the [prerequisites](../azuresqlworkshop/00-Prerequisites.md) before completing these activities. You can also choose to audit the materials if you cannot complete the prerequisites. If you were provided an environment to use for the workshop, then you **do not need** to complete the prerequisites.     

You’ve been responsible for getting your SQL fast, keeping it fast, and making it fast again when something is wrong. In this module, we’ll show you how to leverage your existing performance skills, processes, and tools and apply them to Azure SQL, including taking advantage of the intelligence in Azure to keep your database tuned.

In each module you'll get more references, which you should follow up on to learn more. Also watch for links within the text - click on each one to explore that topic.

(<a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLWorkshop/azuresqlworkshop/00-Prerequisites.md" target="_blank">Make sure you check out the <b>Prerequisites</b> page before you start</a>. You'll need all of the items loaded there before you can proceed with the workshop.)

In this module, you'll cover these topics:  
[4.1](#4.1): Azure SQL performance capabilities and Tasks<br>
[4.2](#4.2): Monitoring performance in Azure SQL<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Activity 1](#1): How to monitor performance in Azure SQL Database  
[4.3](#4.3): Improving Performance in Azure SQL<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Activity 2](#2): Scaling your workload performance in Azure SQL Database  

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="4.1">4.1  Azure SQL performance capabilities and Tasks</h2></a>

In this section you will learn how to monitor the performance of a SQL workload using tools and techniques both familiar to the SQL Server professional along with differences with Azure SQL.

**TODO:** Here is where we would put in more details comparing the performance capabilities and tasks of SQL Server with Azure SQL including Database and MI. This includes performance features and tools to get fast, stay fast, and get faster.

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="4.2">4.2 Monitoring performance in Azure SQL</h2></a>

In this section you will learn how to monitor the performance of a SQL workload using tools and techniques both familiar to the SQL Server professional along with differences with Azure SQL.

**TODO:** Put in text here that talks about the process to monitor performance with Azure SQL comparing this to SQL Server.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><a name="1"><b>Activity 1</a>: How to monitor performance in Azure SQL Database</b></p>

>**IMPORTANT**: This activity assumes you have completed all the activities in Module 2.

In this activity, you will take a typical workload based on SQL queries and learn how to monitor performance for Azure SQL Database. You will learn how to identify a potential performance bottleneck using familiar tools and techniques to SQL Server. You will also learn differences with Azure SQL Database for performance monitoring.

Using the Azure SQL Database based on the AdventureWorksLT sample, you are given an example workload and need to observe its performance. You are told there appears to be a performance bottleneck. Your goal is to identify the possible bottleneck and identify solutions.

**Step 1: Setup to monitor Azure SQL Database**

- Launch SSMS and load queries to monitor dm_exec_requests and dm_db_resource_stats.
- Setup an XEvent trace for queries

**Step 2: Run the workload and observe performance**

- Run the ostress script to run the SQL workload. Look at the query text
- Run DMV queries to observe performance
- Use opportunity to describe differences in using dm_exec_requests at the db level
- Describe what dm_db_resource_stats provides
- Take note of overall workload duration (about 1 minute)

**Step 3: Use Query Store to do further performance analysis**

- Look at Top Resource Report. Look at query plan and performance stats
- Look at Waits Report. Observe CPU waits and look at waits for CPU for query

**Step 4: Observe query performance with Extended Events**

- Load up XEvent file and observe information in the query trace.

**Step 5: Observe performance using the Azure Portal**

- Observe performance in the portal for the resource graph for the db
- Observe performance with Performance Insights from the portal

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="4.3">4.3 Improving Performance in Azure SQL</h2></a>

In this section you will learn how to improve the performance of a SQL workload in Azure SQL using your knowledge of SQL Server and gained knowledge from Module 4.2.

**TODO:** Put in text here about various ways to improve performance in SQL Server and how that compares to Azure SQL including Database and MI. A discussion of Hyperscale is fine here as well although we won't use that in the Activity.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><a name="2"><b>Activity 2</a>: Scaling your workload performance in Azure SQL Database</b></p>

>**IMPORTANT**: This activity assumes you have completed all the steps in Activity 1 in Module 4.

In this activity you will take the results of your monitoring in Module 4.2 and learn how to scale your workload in Azure to see improved results.

**Step 1: Decide options on how to scale performance**

Since workload is CPU bound one way to improve performance is to increase CPU capacity or speed. A SQL Server user would have to move to a different machine or reconfigure a VM to get more CPU capacity.

For Azure, we can use ALTER DATABASE, az cli, or the portal to increase CPU capacity.

Look at the portal for options.

**Step 2: Increase capacity of your Azure SQL Database**

Use ALTER DATABASE to move up to 8vcores for General Purpose.

**Step 3: Run the workload again**

Re-run the ostress workload.

**Step 4: Observe new performance of the workload**

- Observe DMV queries
- Observe query store reports
- Observe azure portal
- Observe differences with XEvents.

**Step 5: Advanced: Observe performance using a Serverless Azure SQL Database**

- Change service tier to Serverless with min 2 CPUs and max 8 CPUs
- Re-run workload and observe performance the same as when you manually scaled to 8
- **TODO:** - Why does dm_db_resource_stats show lower overall CPU% on serverless? 

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="../graphics/owl.png"><b>For Further Study</b></p>
<ul>
    <li><a href="url" target="_blank">TODO: Enter courses, books, posts, whatever the student needs to extend their study</a></li>
</ul>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/geopin.png"><b >Next Steps</b></p>

Next, Continue to <a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLWorkshop/azuresqlworkshop/05-Availability.md" target="_blank"><i> 05 - Availability</i></a>.