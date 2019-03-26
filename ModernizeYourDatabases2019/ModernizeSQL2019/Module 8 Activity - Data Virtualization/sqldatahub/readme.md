# SQL Server Data Hub Polybase demos

In this demo I show you how to use SQL Server as a hub for data virtualization. Consider the example company WideWorldImporters (read more at https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-what-is?view=sql-server-2017 )

This demo will cover scenarios where this company has data in other sources but would like to avoid building complex and expensive ETL programs to move the data into SQL Server 2019. In some cases, they are going to migrate their data but they would first like access to the data so applications and reports can seamlessly run while just connecting to SQL Server 2019.

They have identified the following data sources and business scenarios:

**SQL Server 2008R2** - This is the legacy SQL Server which contains a list of Suppliers the company no longer uses but they want to access for historical reasons.

**Azure SQL Database** - A new cloud based application is prototyping data for StockItems in Azure

**CosmosDB** - A research team is experimenting with a mobile based application to take orders from customers using a noSQL data store like Azure CosmosDB

**Oracle** - The company's accounting system is in Oracle but will be migrated soon to SQL Server. For now, the company wants to be able to access accounts receivable data which lines up with transactions in WideWorldImporters database.

**Hadoop** - The company's website ordering system now has a new feature for customers to review the ordering process. The developers find it very convenient to stream a large amount of data for these reviews in the form of files in Hadoop. The system today just streams this in Azure Blog Storage.

**SAPHana** - The company just acquired a new company and would like to start reviewing the customer profiles the new acquired company brings. The new company has a data warehouse stored in SAPHana that can be queried.

All of these data sources will become external data sources and tables. For the purposes of this demo, all of the examples will use resources in Azure. The hub for SQL Server 2019 will be based on the Polybase configuration installed and configured in the **Fundamentals** folder.


1. If you have not restored the backup already, download and restore the WideWorldImporters backup from https://github.com/Microsoft/sql-server-samples/tree/master/samples/databases/wide-world-importers

2. First, run the scenario for SQL2008r2 by going to the **SQL2008r2** folder and following the instructions in the readme.md file.

3. 