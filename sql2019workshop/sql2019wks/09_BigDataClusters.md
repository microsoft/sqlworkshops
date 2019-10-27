![](../graphics/microsoftlogo.png)

# Workshop: SQL Server 2019 Workshop

#### <i>A Microsoft workshop from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=true"><b>     Big Data Clusters</b></h2>

SQL Server Big Data Clusters provide a solution for Intelligence over all of your Data through Data Virtualization with Polybase, buit-in HDFS and Spark, and a end-to-end Machine Learning Platform.

![BDC Intelligence](./graphics/bdc_intelligence_over_your_data.png)

Big Data Clusters are deployed using Kubernetes nodes, pods, and services. Big Data Clusters is complete built-in solution providing:

- A **SQL Server Master Instance** with HADR built-in using Always On Availability Groups
- A **Compute Pool** of pods to deploy a Polybase scale-out group
- A **Storage Pool** of pods with a deployed HDFS cluster with Spark installed. The SQL Server engine is deployed to provide optimized access to HDFS files.
- A **Data Pool** of pods implementing a data mart to store cached or offline results
- Access to **external data sources** such as Oracle, SQL Server (including Azure), MongoDB (including CosmosDB), and Teradata through Polybase.
- Access to the **language of your choice** including T-SQL, Spark, R, Python, Scala, and Java.
- An **Application Deploy pool** of pods to deploy your Machine Learning application or SSIS package.
- TODO: Control Plane
- TODO: HDFS Tiering

Balzano is a company using SQL Server 2019 Big Data Clusters to transform and effectively use machine learning.

![SQL 2019 BDC](./graphics/sql2019_bdc_components.png)

You can read more SQL Server Big Data Clusters at https://docs.microsoft.com/en-us/sql/big-data-cluster/big-data-cluster-overview.

This module provides a fundamental look and usage of SQL Server 2019 Big Data Clusters as part of the overall SQL Server 2019 product. Use the following workshop for a detailed look at SQL Server 2019 Big Data Clusters at https://github.com/Microsoft/sqlworkshops/tree/master/sqlserver2019bigdataclusters.

You will cover the following topics in this Module:

<dl>

  <dt><a href="#9-0">9.0 Big Data Cluster Deployment</a></dt>
  <dt><a href="#9-1">9.1 Data Virtualization and Big Data Clusters</a></dt>
  <dt><a href="#9-2">9.2 Spark and Machine Learning</a></dt>
  <dt><a href="#9-3">9.3 Advanced: Exploring and Monitoring Big Data Clusters</a></dt>
    
</dl>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><b><a name="9-0">     9.0 Big Data Cluster Deployment</a></b></h2>

SQL Server provides simple methods to deploy an entire Big Data Cluster on the Kubernetes deployment of your choice.

<h3><b><a name="challenge">The Challenge</a></b></h3>

Deploying a set of software components on Kubernetes that includes SQL Server, HDFS, Spark, and a suite of services for control, management, and monitoring can be a complex task.

<h3><b><a name="solution">The Solution</a></b></h3>

SQL Server 2019 Big Data Clusters come with tools such as the **azdata** command line interface (CLI) to help simplify the deployment of a Big Data Cluster on Kubernetes

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="activity9.0">     Activity: Deploying a Big Data Cluster</a></b></h2>

Azure Kuberentes Service (AKS) provides a managed platform to deploy a Kubernetes cluster. Kubernetes can also be deployed on the platform of your choice using tools like **kubeadm**.

SQL Server 2019 Big Data Clusters provide guidance for deployment on AKS or your Kuberentes cluster at https://docs.microsoft.com/en-us/sql/big-data-cluster/deployment-guidance

<h3><img style="margin: 0px 15px 15px 0px;" ****src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b><a name="actvitysteps9.0">Activity Steps</a></b></h3>

Follow the instructions at https://docs.microsoft.com/en-us/sql/big-data-cluster/deploy-on-aks to deploy SQL Server 2019 Big Data Clusters on AKS.

>**NOTE**: If you would like to deploy a Big Data Cluster that includes built-in HA for the SQL Server Master Instance with Always-On Availability Groups, consult the documentaiton at https://docs.microsoft.com/en-us/sql/big-data-cluster/deployment-high-availability.

When using **azdata** for deployment, your results should look something like this from the command line (you will have responded to prompts for passwords)

<pre>
The privacy statement can be viewed at:
https://go.microsoft.com/fwlink/?LinkId=853010

The license terms for SQL Server Big Data Cluster can be viewed at:
https://go.microsoft.com/fwlink/?LinkId=2002534


Cluster deployment documentation can be viewed at:
https://aka.ms/bdc-deploy

Please provide a value for CONTROLLER_USERNAME:admin
Please provide a value for CONTROLLER_PASSWORD:
Please provide a value for MSSQL_SA_PASSWORD:
Please provide a value for KNOX_PASSWORD:

NOTE: Cluster creation can take a significant amount of time depending on
configuration, network speed, and the number of nodes in the cluster.

Starting cluster deployment.
Waiting for cluster controller to start.
Waiting for cluster controller to start.
Waiting for cluster controller to start.
Waiting for cluster controller to start.
Waiting for cluster controller to start.
Waiting for cluster controller to start.
Waiting for cluster controller to start.
Cluster controller endpoint is available at 40.76.88.178:30080.
Cluster control plane is ready.
Compute pool is ready.
Storage pool is ready.
Data pool is ready.
Master pool is ready.
Cluster deployed successfully.</pre>

The statement "Cluster deployed successfully" show mean the BDC cluster is ready to use. An additional step to verify cluster health can be done with **azdata**.

Login to the the cluster using the following command:

`azdata login`

You will be prompted for the controller login and password (which you supplied when creating the cluster) and the name of the cluster (which the default is mssql-cluster). If the login succeeds, you will be returned the value of the controller endpoint (which you can retrieve later in other ways)

<pre>Controller Username: admin
Controller Password:
Cluster Name: mssql-cluster
Logged in successfully to `https://[ip address]:30080`</pre>

You can now do a quick check of BDC health using the following command:

`azdata bdc status show`

The results should look like the following showing a State of Healthy on all *Services* (Services is a term for BDC components not a Kubernetes Service even though BDC does deploy several Kubernetes Services such as Load Balancers):

>***NOTE**: There was an issue in SQL Server 2019 RC1 where the health of some components might not correctly show as Healthy even though the true state is Healthy Most of these issues were with **Control Services**.

<pre>


 Mssql-cluster: ready                                                                    Health Status:  healthy
 ===============================================================================================================
 Services: ready                                                                         Health Status:  healthy
 ---------------------------------------------------------------------------------------------------------------
 Servicename    State    Healthstatus    Details

 sql            ready    healthy         -
 hdfs           ready    healthy         -
 spark          ready    healthy         -
 control        ready    healthy         -
 gateway        ready    healthy         -
 app            ready    healthy         -


 Sql Services: ready                                                                     Health Status:  healthy
 ---------------------------------------------------------------------------------------------------------------
 Resourcename    State    Healthstatus    Details

 master          ready    healthy         StatefulSet master is healthy
 compute-0       ready    healthy         StatefulSet compute-0 is healthy
 data-0          ready    healthy         StatefulSet data-0 is healthy
 storage-0       ready    healthy         StatefulSet storage-0 is healthy

  Hdfs Services: ready                                                                    Health Status:  healthy
 ---------------------------------------------------------------------------------------------------------------
 Resourcename    State    Healthstatus    Details

 nmnode-0        ready    healthy         StatefulSet nmnode-0 is healthy
 storage-0       ready    healthy         StatefulSet storage-0 is healthy
 sparkhead       ready    healthy         StatefulSet sparkhead is healthy

 Spark Services: ready                                                                   Health Status:  healthy
 ---------------------------------------------------------------------------------------------------------------
 Resourcename    State    Healthstatus    Details

 sparkhead       ready    healthy         StatefulSet sparkhead is healthy
 storage-0       ready    healthy         StatefulSet storage-0 is healthy

 Control Services: ready                                                                 Health Status:  healthy
 ---------------------------------------------------------------------------------------------------------------
 Resourcename    State    Healthstatus    Details

 controldb       ready    healthy         -
 control         ready    healthy         -
 metricsdc       ready    healthy         DaemonSet metricsdc is healthy
 metricsui       ready    healthy         ReplicaSet metricsui is healthy
 metricsdb       ready    healthy         StatefulSet metricsdb is healthy
 logsui          ready    healthy         ReplicaSet logsui is healthy
 logsdb          ready    healthy         StatefulSet logsdb is healthy
 mgmtproxy       ready    healthy         ReplicaSet mgmtproxy is healthy


 Gateway Services: ready                                                                 Health Status:  healthy
 ---------------------------------------------------------------------------------------------------------------
 Resourcename    State    Healthstatus    Details

 gateway         ready    healthy         StatefulSet gateway is healthy


 App Services: ready                                                                     Health Status:  healthy
 ---------------------------------------------------------------------------------------------------------------
 Resourcename    State    Healthstatus    Details

 appproxy        ready    healthy         ReplicaSet appproxy is healthy</pre>

When you are done proceed to the **Activity Summary** section for the Activity below.

<h3><b><a name="activitysummary">Activity Summary</a></b></h3>

SQL Server 2019 Big Data Clusters can be deployed on managed Kubernetes platforms like Azure Kubernetes Service with a single Command Line Interface (CLI) like **azdata**.

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><b><a name="9-1">     9.1 Data Virtualization and Big Data Clusters</a></b></h2>

Once you have deployed a SQL Server 2019 Big Data Cluster, one of the first usage scenarios is to access data stored within the cluster both in the Storage Pool with HDFS and the Data Pool through a cached or offline result set.

<h3><b><a name="challenge">The Challenge</a></b></h3>

Some data is naturally stored as unstructured or semi-structured in the form of files. HDFS provides a standard mechanism to stored a distributed set of large files with this type of data. Deploying and managing a Hadoop cluster with HDFS can be an expensive and complex problem.

Accessing data of all types through *ad-hoc* queries or applications to relational, noSQL, or HDFS stores can provide near real-time results but may not yield maximum performance. Some users and applications only need data refreshed at fixed time intervals.

<h3><b><a name="solution">The Solution</a></b></h3>

SQL Server 2019 Big Data Clusters solve challenges of HDFS deployment and maximum performance data access through a **Storage and Data Pool**.

A **Storage Pool** is a pre-deployed HDFS cluster using Kubernetes pods that can be accessed through standard HDFS interfaces (WebHDFS) or through the SQL Server Master Instance with Polybase using a special built-in **connector**. A Storage Pool uses the SQL Server engine for optimized access to HDFS files. You can read more about storage pools at https://docs.microsoft.com/en-us/sql/big-data-cluster/concept-storage-pool.

A **Data Pool** is a pre-deployed set of pods using SQL Server instances to store shards of data optimized with columnstore indexes. Data Pools are accessed with Polybase from the SQL Server Master Instance through a special built-in connector. You can use T-SQL statements like INSERT, SELECT, TRUNCATE, and EXECUTE AS with data pools. You can read more about data pools at https://docs.microsoft.com/en-us/sql/big-data-cluster/concept-data-pool.

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="activity9.1">     Activity: Analyzing data using the Storage and Data Pool</a></b></h2>

In this activity, ingest data into the Storage Pool in HDFS and access this data through the SQL Server Master Instance through Polybase. 

Then, ingest query results from SQL Server joined with HDFS into the Data Pool.

<h3><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b><a name="actvitysteps9.1">Activity Steps</a></b></h3>

All scripts for this activity can be found in the **sql2019workshop\sql2019wks\09_BigDataClusters\storage_and_data_pool** folder.

>**NOTE:** Other external data sources such as Oracle, MongoDB, SQL Server (including Azure), and Teradata can be used in a big data cluster using the same techniques you learned in Module 08 Data Virtualization

**STEP 1: Ingest data into HDFS in the Storage Pool**

Follow the instructions to load sample data into HDFS in a Big Data cluster at https://docs.microsoft.com/en-us/sql/big-data-cluster/tutorial-load-sample-data.

**STEP 2: Query data in HDFS through Polybase in a Big Data Cluster**

Use the T-SQL notebook **datavirtualization_storagepool.ipynb** to query HDFS data in the storage pool based on files loaded in STEP 1.

**STEP 3: Ingest and access data in a Data Pool in a Big Data Cluster**

Use the T-SQL notebook **datavirtualization_datapool.ipynb** to ingest data based on queries from STEP 2 and query the cached results.

When you are done proceed to the **Activity Summary** section for the Activity below.

<h3><b><a name="activitysummary">Activity Summary</a></b></h3>

In this activity, you learned how to ingest data into HDFS in the Storage Pool of a Big Data Cluster. You also learned how to query HDFS data through Polybase deployed and built-in to Big Data Clusters. You then ingested data and queried cached results in the data pool using Polybase.

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><b><a name="9-2">     9.2 Spark and Machine Learning</a></b></h2>

xxxxxxxxxx

<h3><b><a name="challenge">The Challenge</a></b></h3>

xxxxx

<h3><b><a name="solution">The Solution</a></b></h3>

xxxxxx

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="activity9.2">     Activity: Using Spark for Machine Learning</a></b></h2>

XXXXXXXXX

<h3><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b><a name="actvitysteps9.2">Activity Steps</a></b></h3>

All scripts for this activity can be found in the **sql2019workshop\09_BigDataClusters\spark_and_ml** folder.

When you are done proceed to the **Activity Summary** section for the Activity below.

<h3><b><a name="activitysummary">Activity Summary</a></b></h3>

xxxxxxxxxxx

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><b><a name="9-3">     9.3 Advanced: Exploring and Monitoring Big Data Clusters</a></b></h2>

xxxxxxxxxx

<h3><b><a name="challenge">The Challenge</a></b></h3>

xxxxx

<h3><b><a name="solution">The Solution</a></b></h3>

xxxxxx

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="activity9.3">     Activity: Using tools to explore and monitor Big Data Clusters</a></b></h2>

XXXXXXXXX

<h3><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b><a name="actvitysteps9.3">Activity Steps</a></b></h3>

All scripts for this activity can be found in the **sql2019workshop\09_BigDataClusters\explore_and_monitor** folder.

When you are done proceed to the **Activity Summary** section for the Activity below.

<h3><b><a name="activitysummary">Activity Summary</a></b></h3>

xxxxxxxxxxx

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/owl.png?raw=true"><b>     For Further Study</b></h2>

- [Accelerated Databased Recovery](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-accelerated-database-recovery)

- [The Constant Time Recovery Paper](https://www.microsoft.com/en-us/research/publication/constant-time-recovery-in-azure-sql-database )

- [What is Azure Data Studio?](https://docs.microsoft.com/en-us/sql/azure-data-studio/what-is)

- [How to use Notebooks in Azure Data Studio](https://docs.microsoft.com/en-us/sql/azure-data-studio/sql-notebooks)

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/geopin.png?raw=true"><b>     Next Steps</b></h2>

Next, Continue to <a href="10_Additional_Migration.md" target="_blank"><i>Additional Capabilities, Migration, and Next Steps</i></a>.
