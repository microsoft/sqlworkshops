# SQL Server 2019 Polybase example with CosmosDB (using MongoDB)

This demo shows you how to setup a CosmosDB external data source and table with examples of how to query the data source and join data to local SQL Server 2019 data.

## Requirements

- Create a new database, collection, and document with CosmosDB in Azure. I used the Azure portal to create a new cosmosdb database in the same resource group as my polybase head node (bwpolybase). When I used the portal to create a new cosmosdb instance, I chose the Azure CosmosDB Database for Mongo API for the API selection. I used the Data Explorer tool from the portal to create my database called WideWorldImporters with a collection called Orders. Then I created a new document with field names and values like the following (Note: the _id field was created by Data Explorer and the id field was a default value already provided by the tool)


```json
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
```
- If you have not done so already install and enable Polybase. You can use a single instance or scale out group. You do NOT need to choose the Java option when using this data source.
- Enable Polybase using the following T-SQL statement:

    exec sp_configure @configname = 'polybase enabled', @configvalue = 1;
RECONFIGURE [ WITH OVERRIDE ]  ;

## Demo Steps

- Follow the steps in the **cosmosdb_external_table.sql** script to create the data source, external table, and use the external table for queries.