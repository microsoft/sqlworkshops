![](https://github.com/microsoft/sqlworkshops/blob/master/graphics/microsoftlogo.png?raw=true)

# Workshop: Kubernetes - From Bare Metal to SQL Server Big Data Clusters

#### <i>A Microsoft Course from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=true"> 05 - Using the SQL Server big data cluster on Kubernetes for Data Science </h2>

In this workshop you have covered concepts and processes for using Kubernetes, and how to set up a SQL Server big data cluster on a Kubernetes Cluster. The end of this Module contains several helpful references you can use in these exercises and in production.

This module covers a complete workflow for this environment, focusing on a Data Science application. 

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><a name="4-0">4.0 End-To-End Solution with BDC</a></h2>

 <a href="https://azure-scenarios-experience.azurewebsites.net/big-data.html" target="_blank">Wide World Importers </a> (WWI) is a traditional brick and mortar business with a long track record of success, generating profits through strong retail store sales of their unique offering of affordable products from around the world. They have a traditional N-tier application that uses a front-end (mobile, web and installed) that interacts with a scale-out middle-tier software product, which in turn stores data in a large SQL Server database that has been scaled-up to meet demand.  

<br>
<img style="height: 150; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/WWI-002.png?raw=true">
<br>

WWI has now added web and mobile commerce to their platform, which has generated a significant amount of additional data, and data formats. These new platforms were added without integrating into the OLTP system data or Business Intelligence infrastructures. As a result, "silos" of data stores have developed, and ingesting all of this data exceeds the scale of their current RDBMS server:

<br>
<img style="height: 300; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/WWI-003.png?raw=true">
<br>

This presented the following four challenges - the IT team at WWI needs to:

 - Scale data systems to reach more consumers
 - Unlock business insights from multiple sources of structured and unstructured data
 - Apply deep analytics with high-performance responses
 - Enable AI into apps to actively engage with customers

<br>
<p style="border-bottom: 1px solid lightgrey;"></p>
<br>

<h3>Solution - <i>Challenge 1: Scale Data System</i></h3>

To meet these challenges, the following solution is proposed. Using the BDC platform you learned about in the <i>02 - BDC Components</i> Module, the solution allows the company to keep it's current codebase, while enabling a flexible scale-out architecture. This answers the first challenge of working with a scale-out system for larger data environments.

The following diagram illustrates the complete solution that you can use to brief your audience with: 

<br>
<img style="height: 400; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/bdcsolution1.png?raw=true">
<br>

In the following sections you'll dive deeper into how this scale is used to solve the rest of the challenges.

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><a name="4-1">4.1 Data Virtualization - <i>Challenge 2: Multiple Data Sources</i></a></h2>

The next challenge the IT team must solve is to enable a single data query to work across multiple disparate systems, optionally joining to internal SQL Server Tables, and also at scale. 

Using the Data Virtualization capability you saw in the <i>02 - SQL Server BDC Components</i> Module, the IT team creates External Tables using the PolyBase feature. These External Table definitions are stored in the database on the SQL Server Master Instance within the cluster. When queried by the user, the queries are engaged from the SQL Server Master Instance through the Compute Pool in the SQL Server BDC, which holds Kubernetes Nodes containing the Pods running SQL Server Instances. These Instances send the query to the PolyBase Connector at the target data system, which processes the query based on the type of target system. The results are processed and returned through the PolyBase Connector to the Compute Pool and then on to the Master Instance, and then on to the user.

<br>
<img style="height: 250; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/bdcsolution2.png?raw=true">
<br>

This process allows not only a query to disparate systems, but also those remote systems can hold extremely large sets of data. Normally you are querying a subset of that data, so the results are all that are sent back over the network. These results can be joined with internal tables for a single view, and all from within the same Transact-SQL statements. 

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: Load and query data in an External Table</b></p>

In this activity, you will load the sample data into your big data cluster environment, and then create and use an External table to query the data in HDFS. This process is similar to connecting to any PolyBase target.

<b>Steps</b>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><a href="https://docs.microsoft.com/en-us/sql/big-data-cluster/tutorial-load-sample-data?view=sqlallproducts-allversions" target="_blank">Open this reference, and perform all of the instructions you see there</a>. This loads your data in preparation for the next Activity.</p>
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><a href="https://docs.microsoft.com/en-us/sql/big-data-cluster/tutorial-query-hdfs-storage-pool?view=sqlallproducts-allversions" target="_blank">Open this reference, and perform all of the instructions you see there</a>. This step shows you how to create and query an External table.</p>
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><a href="https://docs.microsoft.com/en-us/sql/big-data-cluster/tutorial-query-oracle?view=sqlallproducts-allversions" target="_blank">(Optional) Open this reference, and review the instructions you see there</a>. (You You must have an Oracle server that your BDC can reach to perform these steps, although you can review them if you do not)</p>

<br>
<p style="border-bottom: 1px solid lightgrey;"></p>
<br>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><a name="4-2">4.2 Creating a Distributed Data solution using big data cluster - <i>Challenge 3: Deep Analytics</i></a></h2>

Ad-hoc queries are very useful for many scenarios. There are times when you would like to bring the data into storage, so that you can create denormalized representations of datasets, aggregated data, and other purpose-specific data tasks. 

<br>
<img style="height: 250; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/bdcsolution3.png?raw=true">
<br>

Using the Data Virtualization capability you saw in the <i>02 - BDC Components</i> Module, the IT team creates External Tables using PolyBase statements. These External Table definitions are stored in the database on the SQL Server Master Instance within the cluster. When queried by the user, the queries are engaged from the SQL Server Master Instance through the Compute Pool in the SQL Server BDC, which holds Kubernetes Nodes containing the Pods running SQL Server Instances. These Instances send the query to the PolyBase Connector at the target data system, which processes the query based on the type of target system. The results are processed and returned through the PolyBase Connector to the Compute Pool and then on to the Master Instance, and the PolyBase statements can specify the target of the Data Pool. The SQL Server Instances in the Data Pool store the data in a distributed fashion across multiple databases, called <i>Shards</i>.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: Load and query data into the Data Pool</b></p>

In this activity, you will load the sample data into your big data cluster environment, and then create and use an External table to load data into the Data Pool.

<b>Steps</b>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><a href="https://docs.microsoft.com/en-us/sql/big-data-cluster/tutorial-data-pool-ingest-sql?view=sqlallproducts-allversions" target="_blank">Open this reference, and perform the instructions you see there</a>. This loads data into the Data Pool.</p>
<br>
<p style="border-bottom: 1px solid lightgrey;"></p>
<br>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><a name="4-3">4.3 Querying HDFS Data using big data cluster - <i>Challenge 4: Enable AI</i></a></h2>

There are three primary uses for a large cluster of data processing systems for Machine Learning and AI applications. The first is that the users will involved in the creation of the <a href="https://www.codeingschool.com/2018/09/what-are-features-and-labels-in-machine-learning.html" target="_blank">Features used in various ML and AI algorithms, and are often tasked to Label</a> the data. These users can access the Data Pool and Data Storage data stores directly to query and assist with this task. 

The SQL Server Master Instance in the BDC installs with <a href="https://docs.microsoft.com/en-us/sql/advanced-analytics/what-is-sql-server-machine-learning?view=sql-server-ver15" target="_blank">Machine Learning Services</a>, which allow creation, training, evaluation and persisting of Machine Learning Models. Data from all parts of the BDC are available, and Data Science oriented languages and libraries in R, Python and Java are enabled. In this scenario, the Data Scientist creates the R or Python code, and the Transact-SQL Developer wraps that code in a Stored Procedure. This code can be used to train, evaluate and create Machine Learning Models. The Models can be stored in the Master Instance for scoring, or sent on to the App Pool where the Machine Learning Server is running, waiting to accept REST-based calls from applications.

<br>
<img style="height: 400; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/bdcsolution4.png?raw=true">
<br>

The Data Scientist has another option to create and train ML and AI models. The Spark platform within the Storage Pool is accessible through the Knox gateway, using Livy to send Spark Jobs as you learned about in the <i>02 - SQL Server BDC Components</i> Module. This gives access to the full Spark platform, using Jupyter Notebooks (included in <i>Azure Data Studio</i>) or any other standard tools that can access Spark through REST calls. 


<br>
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: Load data with Spark, run a Spark Notebook</b></p>
<br>

In this activity, you will load the sample data into your big data cluster environment using Spark, and use a Notebook in Azure Data Studio to work with it.

<b>Steps</b>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><a href="https://docs.microsoft.com/en-us/sql/big-data-cluster/tutorial-data-pool-ingest-spark?view=sqlallproducts-allversions" target="_blank">Open this reference, and follow the instructions you see there</a>. This loads the data in preparation for the Notebook operations.</p>
<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkbox.png?raw=true"><a href="https://docs.microsoft.com/en-us/sql/big-data-cluster/tutorial-notebook-spark?view=sqlallproducts-allversions" target="_blank">Open this reference, and follow the instructions you see there</a>. This simple example shows you how to work with the data you ingested into the Storage Pool using Spark.</p>

<br>
<p style="border-bottom: 1px solid lightgrey;"></p>
<br>

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/owl.png?raw=true"><b>For Further Study</b></p>
<ul>
    <li><a href="https://docs.microsoft.com/en-us/sql/big-data-cluster/big-data-cluster-overview?view=sqlallproducts-allversions" target="_blank">Official Documentation for this section</a></li>
    <li><a href="https://docs.microsoft.com/en-us/sql/big-data-cluster/data-ingestion-curl?view=sqlallproducts-allversions" target="_blank">Use curl to load data into HDFS on SQL Server 2019 big data clusters</a></li>
    <li><a href="https://docs.microsoft.com/en-us/sql/big-data-cluster/train-and-create-machinelearning-models-with-spark?view=sqlallproducts-allversions" target="_blank">Train and Create machine learning models with Spark</a></li>
    <li><a href="https://docs.microsoft.com/en-us/sql/big-data-cluster/big-data-cluster-create-apps?view=sqlallproducts-allversions" target="_blank">How to deploy an app on BDC</a></li>
    <li><a href="https://docs.microsoft.com/en-us/sql/big-data-cluster/notebooks-guidance?view=sqlallproducts-allversions" target="_blank">How to use notebooks in SQL Server 2019 preview</a></li>
</ul>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/geopin.png?raw=true"><b >Next Steps</b></p>

Congratulations! You have completed this course. Review the "For Further Study" links in each Module to go deeper into each topic. 