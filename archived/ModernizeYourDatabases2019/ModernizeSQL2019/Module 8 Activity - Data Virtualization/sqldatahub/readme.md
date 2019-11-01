# SQL Server Data Hub Polybase demos

In these examples I show you how to use SQL Server as a hub for data virtualization. Consider the example company WideWorldImporters (read more at https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-what-is?view=sql-server-2017 )

## The SQL Server Data Hub

These examples will cover scenarios where this company has data in other sources but would like to avoid building complex and expensive ETL programs to move the data into SQL Server 2019. In some cases, they are going to migrate their data but they would first like access to the data so applications and reports can seamlessly run while just connecting to SQL Server 2019.

They have identified the following data sources and business scenarios:

**SQL Server 2008R2** - This is the legacy SQL Server which contains a list of Suppliers the company no longer uses but they want to access for historical reasons. Use the **sql2008r2** folder for this example.

**Azure SQL Database** - A new cloud based application is prototyping data for StockItems in Azure. Use the **azuredb** folder for this exmaple.

**CosmosDB** - A research team is experimenting with a mobile based application to take orders from customers using a noSQL data store like Azure CosmosDB. Use the **cosmosdb** folder for this example.

**Oracle** - The company's accounting system is in Oracle but will be migrated soon to SQL Server. For now, the company wants to be able to access accounts receivable data which lines up with transactions in WideWorldImporters database. Use the **oracle** folder for this example.

**Hadoop** - The company's website ordering system now has a new feature for customers to review the ordering process. The developers find it very convenient to stream a large amount of data for these reviews in the form of files in Hadoop. The system today just streams this in Azure Blog Storage. Use the **hdfs** folder for this example.

**SAPHana** - The company just acquired a new company and would like to start reviewing the customer profiles the new acquired company brings. The new company has a data warehouse stored in SAPHana that can be queried. Use the **saphana** folder for his example.

## Using the examples and requirements

All of the examples can be used independently. Requirements specific to each example are in each folder. The common requirements for all examples are:

- SQL Server 2019. All the examples, except for saphana, will work on Windows or Linux.
- The Polybase feature installed and enabled. To use the Hadoop example you will need to ensure the Java option is enabled. You do not have to use a scale out group but the sql2008r2 example takes advantage of scale out with partitions if you enable a scale out group.
- If you have not restored the backup already, download and restore the WideWorldImporters backup from https://github.com/Microsoft/sql-server-samples/tree/master/samples/databases/wide-world-importers