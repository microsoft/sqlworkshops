/* SQL Scripts for Hybrid ML Course.sql
Purpose: Demonstrates predictions using a pre-trained model and SQL Server.

Requires: SQL Server 2017 or higher, with sp_executeexternal enabled.
Any additional Libraries you would like to include should be stored at:
C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\PYTHON_SERVICES\Lib\site-packages\microsoftml\mxLibs - see https://docs.microsoft.com/en-us/sql/advanced-analytics/install/sql-pretrained-models-install?view=sql-server-2017

Author: Buck Woody, Data Scientist, Microsoft.

Created, Edited: 11/01/2018
10/23/2018 - Buck Woody - Added restore scripts and cleanup.
11/01/2018 - David Peter Hansen - Cleaned up Operationalization to include prediction
11/07/2018 - Buck Woody - General style edits, file location updates

References: https://docs.microsoft.com/en-us/sql/advanced-analytics/tutorials/run-python-using-t-sql?view=sql-server-2017
*/


/* 01 - Project Methodology and Data Science */
/* Activity: Enable external script execution in SQL Server */

-- Check version to ensure 2017 or higher
SELECT @@VERSION;
GO

-- Try and run some Python. This just returns a library version
EXECUTE sp_execute_external_script
@language = N'Python',
@script = N'
import numpy as np
import pandas as pd
print(np.__version__)
print(pd.__version__)
',
@input_data_1 = N'SELECT 1 as Col1';
GO

-- If the above statement does not execute, try it again,
-- and then Enable Python
EXEC sp_configure 'external scripts enabled', 1;
GO

RECONFIGURE WITH OVERRIDE;
GO

-- Start and stop SQL Server and the Launchpad,
-- and then try the Python script again.
-- NOTE: The SQL Launchpad Service must be running!

/* End Activity: Enable external script execution in SQL Server */

/* 02 - Business Understanding */
/* Activity: Restore the Database
NOTE: This file must exit, and must be accessible by SQL Server.
Edit the locations below to your server's specifications.
*/
USE master;
GO
RESTORE DATABASE ContosoEngineering
   FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\ContosoEngineering.bak'
   WITH
        MOVE 'ContosoEngineering' TO 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\ContosoEngineering.mdf'
        , MOVE 'ContosoEngineering_log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\ContosoEngineering.ldf'
		, REPLACE;
GO

/* Database Python ML */
USE ContosoEngineering
GO

/* Check the Data */
USE ContosoEngineering;
GO
SELECT * FROM PdM_errors;
GO
SELECT * FROM PdM_failures;
GO
SELECT * FROM PdM_machines;
GO
SELECT * FROM PdM_maint;
GO
SELECT * FROM PdM_telemetry;
GO

/* End Activity: Restore the Database */

/* 05 Operationalization */

/* Activity: Import Model */

-- You're only doing this for class. In production, you would keep this table
-- and create versions for the model you want to select later.
DROP TABLE IF EXISTS pdm_models
GO

CREATE TABLE pdm_models (model_name VARCHAR(55), model VARBINARY(MAX));
GO

-- Bring the trained model in. Note that SQL Server must have permissions to the
-- directory where the model is stored, hence the reason we stored it in BACKUP.
INSERT INTO pdm_models (model_name, model)
SELECT 'pdm_model', * FROM OPENROWSET(BULK N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\model_2.pkl', SINGLE_BLOB) rs;
GO

-- Make sure the model made it.
SELECT * FROM pdm_models;
GO
/* End Activity: Import Model */

/* Activity: Generate Stored Procedure for predictions */

/* The completed data set that will be evaluated by the model
is in the table "FeaturesAndLabels.
These values would need to be created with Feature Engineering
either in Python or in SQL, or using
SQL Server Integration Services, in the database from the
production data. This has already been done for this course.
*/

SELECT [id]
,[voltmean_3h]
, [rotatemean_3h]
,[pressuremean_3h]
,[vibrationmean_3h]
,[voltsd_3h]
,[rotatesd_3h]
,[pressuresd_3h]
,[vibrationsd_3h]
,[voltmean_24h]
,[rotatemean_24h]
,[pressuremean_24h]
,[vibrationmean_24h]
,[voltsd_24h]
,[rotatesd_24h]
,[pressuresd_24h]
,[vibrationsd_24h]
,[error1count]
,[error2count]
,[error3count]
,[error4count]
,[error5count]
,[comp1]
,[comp2]
,[comp3]
,[comp4]
,[age]
,[model_model1]
,[model_model2]
,[model_model3]
,[model_model4]
 FROM [dbo].[FeaturesAndLabels];
 GO

CREATE PROCEDURE predict_failures (@model varchar(100))
AS
       BEGIN
              DECLARE @nb_model varbinary(max) = (SELECT model FROM pdm_models WHERE model_name = @model);
              EXEC sp_execute_external_script @language = N'Python',
                     @script = N'
import pickle
pdmmodel = pickle.loads(nb_model)
pdm_pred = pdmmodel.predict(pdm_data[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29]])
pdm_data["failure"] = pdm_pred
OutputDataSet = pdm_data[[0, 31]]
print(OutputDataSet)'
              , @input_data_1 = N'select [id],[voltmean_3h],[rotatemean_3h],[pressuremean_3h],[vibrationmean_3h],[voltsd_3h],[rotatesd_3h],[pressuresd_3h],[vibrationsd_3h],[voltmean_24h],[rotatemean_24h],[pressuremean_24h],[vibrationmean_24h],[voltsd_24h],[rotatesd_24h],[pressuresd_24h],[vibrationsd_24h],[error1count],[error2count],[error3count],[error4count],[error5count],[comp1],[comp2],[comp3],[comp4],[age],[model_model1],[model_model2],[model_model3],[model_model4] from FeaturesAndLabels'
              , @input_data_1_name = N'pdm_data'
              , @params = N'@nb_model varbinary(max)'
              , @nb_model = @nb_model
              WITH RESULT SETS ( (id int, failure varchar(10)));
       END;
GO

/* End Activity: Generate Stored Procedure for predictions */

/* Activity: Return Results */
EXEC predict_failures 'pdm_model';
GO
/* End Activity: Return Results */


/* EOF: SQL Scripts for hybrid ML Course.sql */
