# SQL Server demo with Polybase with HDFS (using Azure Blog Storage)

This demo is an example of creating and using an external table for HDFS using Azure Blog Storage.

## Requirements

- Install SQL Server 2019 Polybase.
- Choose to install the Java option.
- Enable Polybase using the following T-SQL statement:

    exec sp_configure @configname = 'polybase enabled', @configvalue = 1;
RECONFIGURE [ WITH OVERRIDE ]  ;
- Create an Azure Storage container to hold the hdfs data.
- For further information look at the documentation at https://docs.microsoft.com/en-us/sql/relational-databases/polybase/polybase-configure-azure-blob-storage.

## Demo Steps

 - Run all the T-SQL commands in **hdfs_external_table.sql**. You will need to edit the appropriate details to point to your Azure storage container including the credential and location for the data source.