![](graphics/solutions-microsoft-logo-small.png)

# Secure Machine Learning with SQL Server and Microsoft Azure AI

## 03 Data Acquisition and Understanding

<p style="border-bottom: 1px solid lightgrey;"></p> 
<dl>
  <dt>Course Outline</dt>
  <dt>1 Overview and Course Setup</dt>
  <dt>2 Business Understanding</dt>
  <dt>3 Data Acquisition and Understanding <i>(This section)</i></dt>
        <dd>3.1 Loading Data into the Solution</dd>
        <dd>3.2 Data Exploration and Profiling</dd>
  <dt>4 Modeling</dt>
  <dt>5 Deployment</dt>
  <dt>6 Customer Acceptance and Model Retraining</dt>
<dl>
<p style="border-bottom: 1px solid lightgrey;"></p> 

From Business Intelligence you're familiar with Extract, Transform and Load(ETL) to prepare data for historical, pre-aggregated storage for ad-hoc queries. For Machine Learning, it's more common to extract the data, load it ito a source, and then transform the data as late as possible in the process (ELT). This allows the most fidelity within the process. 

There are multiple ways to ingest data, depending on the intended location. For SQL Server, data is often generated within base tables by applications, and other data can be loaded via the bcp program or SQL Server Integration Services. 

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>3.1 Loading Data into the Solution</b></p>

In the Data Acquisition and Understanding phase of your process you ingest or access data from various locations to answer the questions the organization has asked. In most cases, this data will be in multiple locations. Once the data is ingested into the system, you’ll need to examine it to see what it holds. All data needs cleaning, so after the inspection phase, you’ll replace missing values, add and change columns. You’ll cover more extensive Data Wrangling tasks in other courses. In this section, you’ll use a single Database dataset to train your model.

### Goals for Data Acquisition and Understanding

- Produce a clean, high-quality data set whose relationship to the target variables is understood. Locate the data set in the appropriate analytics environment so you are ready to model.
- Develop a solution architecture of the data pipeline that refreshes and scores the data regularly.

### How to do it

- Ingest the data into the target analytic environment.
- Explore the data to determine if the data quality is adequate to answer the question.
- Set up a data pipeline to score new or regularly refreshed data.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity: Restore the Database</b></p>

- Run SSMS or Visual Studio, connect to your SQL Server Instance, and open a new query window. The dataset used in this course is hosted in a SQL Server table.The table contains rental data from previous years. The backup (.bak) file is in the `./assets` directory called **TutorialDB.bak**, and save it on a location that SQL Server can access, for example in the folder where SQL Server is installed. Example path: *C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Backup*

- Once you have the file saved, open SSMS and a new query window to run the following commands to restore the DB. Make sure to modify the file paths and server name in the script:

<pre>
USE master;
GO
RESTORE DATABASE TutorialDB
   FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\TutorialDB.bak'
   WITH
                MOVE 'TutorialDB' TO 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\TutorialDB.mdf'
                ,MOVE 'TutorialDB_log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\TutorialDB.ldf';
GO
</pre>

- A table named rental_data containing the dataset should exist in the restored SQL Server database. You can verify this by querying the table in SSMS:

<pre>
USE tutorialdb;
SELECT * FROM [dbo].[rental_data];
</pre>

You should see a row of data returned.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>3.2 Data Exploration and Profiling</b></p>

With the data located and loaded, you can now begin the exploration. You need to know the "shape" of the data, some basic statistics, and very importantly, any missing values.

You can use standard Transact-SQL statements for a majority of the exploration. The SQL language has a rich, declarative structure that will provide most of the information you need.

There are other options for for exploring your data, such as R or Python. R is a data-first language, and most Data Scientists are familiar with using it to explore data.

You can use SQL Server Stored Procedures to hold the R code and run it within SQL Server ML Services as you saw in the previous module. You can also use a series of R Library calls to query the data held in SQL Server and work with it locally to the Data Scientist's workstation in a traditional fashion.

In the graphic below, the Data Scientist works with R locally, and once they determine a good model, deploy that to SQL Server. Clients use the Model by calling a standard SQL Server Stored Procedure, no R client is needed on their machine or device:

<p>
<img src="./graphics/MLServerArchitecture.png" width="500">
<p>

You'll explore the data with this process next. 

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity: Explore SQL Server Data using R</b></p>

Step 2.2 Access the data from SQL Server using R

- Open a new R Interactive Window in Visual Studio and run the following R Code. Replace "MYSQLSERVER" with the name of your database instance:

<pre>
# Connection string to connect to SQL Server instance
connStr <- paste("Driver=SQL Server; Server=", "MYSQLSERVER", 
                ";Database=", "Tutorialdb", ";Trusted_Connection=true;", sep = "");

# Get the data from a SQL Server Table
SQL_rentaldata <- RxSqlServerData(table = "dbo.rental_data",
                              connectionString = connStr, returnDataFrame = TRUE);

# Import the data into a data frame
rentaldata <- rxImport(SQL_rentaldata);

# Let's see the structure of the data and the top rows
# Ski rental data, giving the number of ski rentals on a given date
head(rentaldata);
str(rentaldata);
</pre>

- What other explorations can you do? How can you leverage graphical outputs to further show the layout of the data? 

- Can you show the missing data?

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/thinking.jpg"><b>For Further Study</b></p>

- Data Acquisition and Understand Reference: https://docs.microsoft.com/en-us/azure/machine-learning/team-data-science-process/lifecycle-data 

Next, Continue to *04 - Environments and Deployment*