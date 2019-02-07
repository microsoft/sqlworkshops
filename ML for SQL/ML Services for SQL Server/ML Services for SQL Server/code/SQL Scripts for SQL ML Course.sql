/* Course Setup and Configuration */

/* The dataset used in this course is hosted in a SQL Server table.The table contains rental data from previous years. 
The backup (.bak) file is in the  ./data  directory called TutorialDB.bak, and save it on a location that SQL Server 
can access, for example in the folder where SQL Server is installed. 
Example path: C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Backup */

USE master;
GO
RESTORE DATABASE TutorialDB
   FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\TutorialDB.bak'
   WITH
                MOVE 'TutorialDB' TO 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\TutorialDB.mdf'
                ,MOVE 'TutorialDB_log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\TutorialDB.ldf';
GO

USE tutorialdb;
SELECT * FROM [dbo].[rental_data];
GO

/* Operationalize the Model into SQL Server */
USE TutorialDB;
DROP TABLE IF EXISTS rental_rx_models;
GO
CREATE TABLE rental_rx_models (
                model_name VARCHAR(30) NOT NULL DEFAULT('default model') PRIMARY KEY,
                model VARBINARY(MAX) NOT NULL
);
GO
