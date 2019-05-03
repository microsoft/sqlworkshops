/* Now Join Those to show customers we currently have in a SQL Server Database 
and the Category they qre in the External Table */
USE WideWorldImporters;
GO

SELECT TOP 10 a.FullName
  , b.CustomerSource
  FROM Application.People a
  INNER JOIN partner_customers_hdfs b  ON a.FullName = b.CustomerName
  ORDER BY FullName ASC;
  GO