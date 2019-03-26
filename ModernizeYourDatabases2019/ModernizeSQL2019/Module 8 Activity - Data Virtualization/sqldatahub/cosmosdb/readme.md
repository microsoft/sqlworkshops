# SQL Server 2019 Polybase example connecting to CosmosDB

This demo shows you how to setup a CosmosDB external data source and table with examples of how to query the data source and join data to local SQL Server 2019 data. The demo assumes you have installed a SQL Server 2019 Polybase scale out group as documented in the **fundamentals** folder of this overall demo.

## Requirements

1. Create a new database, collection, and document with CosmosDB in Azure. I used the Azure portal to create a new cosmosdb database in the same resource group as my polybase head node (bwpolybase). When I used the portal to create a new cosmosdb instance, I chose the Azure CosmosDB Database for Mongo API for the API selection. I used the Data Explorer tool from the portal to create my database called WideWorldImporters with a collection called Orders. Then I created a new document with field names and values like the following (Note: the _id field was created by Data Explorer and the id field was a default value already provided by the tool)

{
	"_id" : ObjectId("5c54aa72dd13c70f445745bf"),
	"id" : "1",
	"OrderID" : 1,
	"SalesPersonPersonID" : 2,
	"CustomerName" : "Vandelay Industries",
	"CustomerContact" : "Art Vandelay",
	"OrderDate" : "2018-05-14",
	"CustomerPO" : "20180514",
	"ExpectedDeliveryDate" : "2018-05-21"
}

## Demo Steps

1. On my SQL Server 2019 head node (bwpolybase), I used the **cosmosdb_external_table.sql** script to create the database scoped credential, externaL data source, external table, and sample SELECT statements to query the external table and join it with local SQL Server 2019 tables in the WideWorldImporters database. The **Connection String** option from the portal of the instance shows you the username and password to use. It also has HOST and PORT fields which are used to build the LOCATION sytnax for the data source.