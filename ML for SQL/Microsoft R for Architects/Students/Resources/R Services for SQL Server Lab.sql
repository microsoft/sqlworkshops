/* R Services for SQL Server Lab.sql
Author: Buck Woody, Microsoft
Last Updated: 10 April 2017

1. Using SQL Server Data from R with an ODBC-Like call
https://msdn.microsoft.com/en-us/library/mt629161.aspx


2. Using SQL Server Data with R in SQL Server

Prepare your system:
*/

/* Check to see if R is Installed and available */
EXEC sp_execute_external_script
@language =N'R',
-- SQL Part
@input_data_1 =N'SELECT 1 as Installed'  ,
-- R Part
@script=N'OutputDataSet<-InputDataSet'
-- Return R Results to SQL
WITH RESULT SETS
(([Installed] int not null));
GO
/* If 0 or error: https://docs.microsoft.com/en-us/sql/advanced-analytics/r/set-up-sql-server-r-services-in-database
NOTE: LaunchPad Windows Service must be running
*/

/* Simple Example using internal R Data
https://msdn.microsoft.com/en-us/library/mt591996.aspx
 */
EXEC sp_execute_external_script
  @language = N'R'
, @input_data_1 = N'SELECT 1 as Col'
, @script = N'OutputDataSet <- subset(iris, select=-Species);'
WITH RESULT SETS
	(("Sepal.Length" float not null
	, "Sepal.Width" float not null
	, "Petal.Length" float not null
	, "Petal.Width" float not null));
-- SELECT INTO could go here
GO

/* Using T-SQL to explore data:
https://docs.microsoft.com/en-us/sql/advanced-analytics/tutorials/rtsql-using-r-code-in-transact-sql-quickstart
 */

 /* EOF: R Services for SQL Server Lab.sql */