![](../graphics/microsoftlogo.png)

# Workshop: SQL Server 2019 Lab CTP 3.1

#### <i>A Microsoft workshop from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/textbubble.png"> <h2>SQL Server 2019 Linux and Containers</h2>

SQL Server 2017 introduced the world to SQL Server on Linux and Containers. SQL Server on Linux is completely compatible with SQL Server on Windows due to the unique design of the SQL Platform Abstraction Layer (SQLPAL)The core engine features of SQL Server on Linux work exactly was SQL Server on Windows because the engine codebase is the same on both platforms. 

However, there were some features that come with SQL Server that were not included in SQL Server 2017 on Linux. SQL Server 2019 shores up these gaps by including the following new enhancements for Linux:

- Replication
- Distributed Transactions
- Machine Learning Services and Extensibility
- Polybase
- Tempdb file auto-config

Containers were also introduced with SQL Server 2017. Containers provide portability, consistent, reduced footprint, and increased availability due to their unique ability for updates.

SQL Server 2019 introduces the following new enhancements for containers:

- Microsoft Container Registry
- RedHat Images
- Availability Groups on Kubernetes
- Windows Containers (Currently Private Preview)

For this module, we will join forces to show you how to implement SQL Server Replication with Linux Containers.
<dl>

  <dt><a href="#5-0">5.0 SQL Server 2019 Replication on Linux using Containers</a></dt>
   
</dl>

**NOTE**: *If at anytime during the Activities of this Module you need to "start over" you can go back to the first Activity in 5.0 and run through all the steps again.*

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/pencil2.png"><a name="5-0">5.0 SQL Server 2019 Replication on Linux using Containers</a></h2>

In this module you will learn how to deploy SQL Server Replication using Containers.

SQL Server 2019 on Linux now supports Replication. Since SQL Server supports containers on Linux, it is possible to create a SQL Server replication solution using containers.

SQL Server container images include SQL Server "pre-installed" with the SQL Server Engine, SQL Server Agent, and tools.

TODO: Explain how you can customize the SQL Server images by running scripts as part of building and running the image. This is called the "Vin Yu" method. 

Proceed to the Activity to learn how to deploy SQL Server Replication on Linux using Containers.

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/point1.png"><b><a name="activityadr">Activity: Deploying SQL Server on Linux using Containers</a></b></p>

In this activity, you will learn how to deploy a SQL Server replication solution with a publisher, distributor, and subscriber using two SQL Server Linux containers.

All scripts for this activity can be found in the **sql2019lab\05_Linux_and_Containers\replication** folder.

<p><b><a name="activitysteps">Activity Steps</a></b></p>

**Note**: This activity assumes the following:

- Docker is installed. You can use Docker on Windows, Linux, or MacOS to run this activity.
- You have internet access to pull SQL Server images from mcr.microsoft.com

**Step 1**: Explore the scripts to deploy the containers

**Step 2**: Deploy SQL Server Replication Containers with docker compose

**Step 3**: Verify the Replication Deployment

When you are done proceed to the **Activity Summary** section for the Activity below.

<p><b><a name="activitysummary">Activity Summary</a></b></p>

xxxxxxxxxxxxxxxx

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="./graphics/owl.png"><b>For Further Study</b></p>

- [What is Polybase?](https://docs.microsoft.com/en-us/sql/relational-databases/polybase/polybase-guide)

- [CREATE EXTERNAL TABLE](https://docs.microsoft.com/en-us/sql/t-sql/statements/create-external-table-transact-sql)
 
- [What are SQL Server Big Data Clusters?](https://docs.microsoft.com/en-us/sql/big-data-cluster/big-data-cluster-overview)

- [What is Azure Data Studio?](https://docs.microsoft.com/en-us/sql/azure-data-studio/what-is)

- [How to use Notebooks in Azure Data Studio](https://docs.microsoft.com/en-us/sql/azure-data-studio/sql-notebooks)

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/geopin.png"><b >Next Steps</b></p>

Next, Continue to <a href="05_Linux_and_Containers.md" target="_blank"><i>Linux and Containers</i></a>.
