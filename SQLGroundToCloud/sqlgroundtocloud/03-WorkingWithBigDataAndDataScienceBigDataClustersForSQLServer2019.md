![](https://github.com/microsoft/sqlworkshops/blob/master/graphics/microsoftlogo.png?raw=true)

# Workshop: SQL Ground-to-Cloud

#### <i>A Microsoft workshop from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=true"> <h2>03 - Working with Big Data and Data Science - Big Data Clusters for SQL Server 2019</h2>

In this Module of the Workshop you'll cover using SQL Server on-premises and in-cloud configurations, as well as hybrid applications as a solution for data processing. In each section you'll get more references, which you should follow up on to learn more. Also watch for links within the text - click on each one to explore that topic. The end of this module contains several helpful references you can use in this course and in production.

(<a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/00-prerequisites.md" target="_blank">Make sure you check out the <b>prerequisite</b> page before you start</a>. You'll need all of the items loaded there before you can proceed with the workshop.)

In this module you'll cover working with Data Science workloads with a focus on larger sets of data. Starting in SQL Server 2019, big data clusters allows for large-scale, near real-time processing of data over the HDFS file system and other data sources. It also leverages the Apache Spark framework which is integrated into one environment for management, monitoring, and security of your environment. This means that organizations can implement everything from queries to analysis to Machine Learning and Artificial Intelligence within SQL Server, over large-scale, heterogeneous data. SQL Server big data clusters can be implemented fully on-premises, in the cloud using a Kubernetes service such as Azure's AKS, and in a hybrid fashion. This allows for full, partial, and mixed security and control as desired.

> Note: This is a complex topic, so you can find a <a href="https://github.com/microsoft/sqlworkshops/tree/master/sqlserver2019bigdataclusters
" target="_blank">complete workshop on this topic here</a>.

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">3.1 Data Science and Big Data Processing</h2>

Businesses require near real-time insights from ever-larger sets of data from a variety of sources. Large-scale data ingestion requires scale-out storage and processing in ways that allow fast response times. In addition to simply querying this data, organizations want full analysis and even predictive capabilities over their data. Machine Learning, Artificial Intelligence, and Deep Learning techniques all require large sets of data for training their models to be effective. Two technologies have emerged as the primary methods for processing large sets of data, using a scale-out paradigm - Hadoop and Spark. 

Hadoop uses a set of computing nodes that position the workload over distributed data nodes:

<p><img style="height: 150; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);"  src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/hdfs.png?raw=true"></p> 	 	

Spark is a technology that uses various libraries to make processing over distributed storage more efficient and faster:

<br>
<p><img style="height: 150; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);"  src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/spark3.png?raw=true"></p> 	 	
<br>

Both of these technologies assume many nodes (computers), and since you only need the computation elements (not all the drivers and other components of a full computer or Virtual Machine), Container technologies work well for this solution.

<br>
<img style="height: 150;" src="https://docs.docker.com/images/Container%402x.png"> 
<br>

To control containers, a technology called <i>Kubernetes</i> is used for deployment, management and storage of a grouping of containers, called a <i>Cluster</i>.

<br> 
<p><img style="height: 200; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);"  src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/KubernetesCluster.png?raw=true"></p> 		
<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">3.2 SQL Server 2019 Big Data Clusters Architecture</h2>

Using the technologies described above, SQL Server uses a Kubernetes Cluster to deploy multiple components for SQL Server processing, distributed queries using PolyBase, Spark, and Storage on HDFS for a complete environment to work with large sets of data, and includes Machine Learning, Artificial Intelligence and Deep Learning capabilities. 

<br>
<img style="height: 200; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/bdc.png?raw=true">
<br>

A SQL Server Big Data Cluster (BDC) can be deployed to multiple environments, in-cloud and on-premises:

 - In a Cloud Service (Such as the Azure Kubernetes Service or AKS)
 - On premises (using KubeADM)

These architectures are not mutually exclusive - you can install some components on-premises, and others as a service. Your connections can interconnect across these environments.

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">3.3 SQL Server 2019 Big Data Clusters Programming</h2>

In addition to traditional OLTP workloads, the SQL Server Big Data Cluster has three other uses that work with data at scale. 

<h3>Data Virtualization with SQL Server Big Data Clusters</h3>

Using the Data Virtualization capability of PolyBase in SQL Server Big Data Clusters you  create External Tables for data outside the Cluster. These External Table definitions are stored in the database on the SQL Server Master Instance within the cluster. When queried by the user, the queries are engaged from the SQL Server Master Instance through the Compute Pool in the SQL Server BDC, which holds Kubernetes Nodes containing the Pods running SQL Server Instances. These Instances send the query to the PolyBase Connector at the target data system, which processes the query based on the type of target system. The results are processed and returned through the PolyBase Connector to the Compute Pool and then on to the Master Instance, and then on to the user.

<br>
<img style="height: 150; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/bdcsolution2.png?raw=true">
<br>

This process allows not only a query to disparate systems, but also those remote systems can hold extremely large sets of data. Normally you are querying a subset of that data, so the results are all that are sent back over the network. These results can be joined with internal tables for a single view, and all from within the same Transact-SQL statements. 

<h3>Data Marts with SQL Server Big Data Clusters</h3>

Ad-hoc queries over larges sets of normalized data are very useful for many scenarios. There are times when you would like to bring the data into storage, so that you can create denormalized representations of datasets, aggregated data, and other purpose-specific data tasks. 

Using the Data Virtualization capability (PolyBase), the IT team creates External Tables using PolyBase statements. These External Table definitions are stored in the database on the SQL Server Master Instance within the cluster. When queried by the user, the queries are engaged from the SQL Server Master Instance through the Compute Pool in the SQL Server BDC, which holds Kubernetes Nodes containing the Pods running SQL Server Instances. These Instances send the query to the PolyBase Connector at the target data system, which processes the query based on the type of target system. The results are processed and returned through the PolyBase Connector to the Compute Pool and then on to the Master Instance, and the PolyBase statements can specify the target of the Data Pool. The SQL Server Instances in the Data Pool store the data in a distributed fashion across multiple databases, called <i>Shards</i>.

<br>
<img style="height: 150; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/bdcsolution3.png?raw=true">
<br>

<h3>Data Science and Apache Spark with SQL Server Big Data Clusters</h3>

There are various uses for a large cluster of data processing systems for Machine Learning and AI applications. One primary use-case is the creation of the <a href="https://www.codeingschool.com/2018/09/what-are-features-and-labels-in-machine-learning.html" target="_blank">Features and Labels used in various ML and AI algorithms</a>. Large sets of data stored in the Data Pool allow Python, R and Spark calls and libraries are available for this task in BDC. This process is often called <i>Data Engineering</i>. 

The SQL Server Master Instance in the BDC installs with <a href="https://docs.microsoft.com/en-us/sql/advanced-analytics/what-is-sql-server-machine-learning?view=sql-server-ver15" target="_blank">Machine Learning Services</a>, which allow creation, training, evaluation and persisting of Machine Learning Models. Data from all parts of the BDC are available, and Data Science oriented languages and libraries in R, Python and Java are enabled. In this scenario, the Data Scientist creates the R or Python code, and the Transact-SQL Developer wraps that code in a Stored Procedure. This code can be used to train, evaluate and create Machine Learning Models. The Models can be stored in the Master Instance for scoring, or sent on to the App Pool where the Machine Learning Server is running, waiting to accept REST-based calls from applications.

The Data Scientist has another option to create and train ML and AI models. The Spark platform within the Storage Pool is accessible through the Knox gateway, using Livy to send Spark Jobs. This gives access to the full Spark platform, using Jupyter Notebooks (included in <i>Azure Data Studio</i>) or any other standard tools that can access Spark through REST calls. 

<br>
<img style="height: 150; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/bdcsolution4.png?raw=true">
<br>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: Big Data Clusters for SQL Server Lab Review</b></p>

In this lab, you will review a series of Jupyter Notebooks you can open in Azure Data Studio to work with a Big Data Cluster. It demonstrates loading data, querying SQL Server databases, accessing HDFS using PolyBase, loading data into the Data Pool, working with Spark, and implementing a Data Science Machine Learning Model in Python. 

<i>Note: This lab assumes a completely installed and function SQL Server Big Data Cluster if you wish to run the Notebooks, otherwise review the completed Notebooks at the reference.</i>

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

<a href="https://github.com/microsoft/sqlworkshops/tree/master/sqlserver2019bigdataclusters/SQL2019BDC/notebooks
" target="_blank">Open this reference and review the notebooks you find there</a>. 

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/owl.png?raw=true"><b>For Further Study</b></p>
<ul>
    <li><a href = "https://www.simplilearn.com/data-science-vs-big-data-vs-data-analytics-article" target="_blank">Understanding the Big Data Landscape</a></li>
    <li><a href = "http://www.admin-magazine.com/Articles/Linux-Essentials-for-Windows-Admins-Part-1" target="_blank">Linux for the Windows Admin</a></li>
    <li><a href = "https://docs.docker.com/v17.09/engine/userguide/" target="_blank">Docker Guide</a></li>
    <li><a href = "https://www.youtube.com/playlist?list=PLLasX02E8BPCrIhFrc_ZiINhbRkYMKdPT" target="_blank">Video introduction to Kubernetes</a></li>
    <li><a href = "https://github.com/vlele/k8onazure" target="_blank">Complete course on Azure Kubernetes Service (AKS)</a></li>
     <li><a href = "https://www.kdnuggets.com/2019/01/practical-apache-spark-10-minutes.html" target="_blank">Working with Spark</a></li>
    <li><a href="https://realpython.com/jupyter-notebook-introduction/" target="_blank">Full tutorial on Jupyter Notebooks</a></li>
</ul>


<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/geopin.png?raw=true"><b >Next Steps</b></p>

Next, Continue to <a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/04-SQLServerOnTheMicrosoftAzurePlatform.md" target="_blank"><i> 04 - SQL Server on the Microsoft Azure Platform</i></a>.