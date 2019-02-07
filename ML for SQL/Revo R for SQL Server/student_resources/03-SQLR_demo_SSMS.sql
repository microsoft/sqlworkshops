
-- Our first example is to create an R plot and serve it in SSRS.

USE RDB;
GO
CREATE TABLE plots(plot varbinary(max));
GO

INSERT INTO plots(plot)
EXEC  sp_execute_external_script
	 @language = N'R'
	,@script = N'
        image_file = tempfile()
        jpeg(filename = image_file, width = 500, height = 500)
        hist(fraudDS$balance, col = "light blue")
        dev.off()
        OutputDataset <- data.frame(data = readBin(file(image_file, "rb"), what = raw(), n = 1e6))'
	,@input_data_1 = N'SELECT balance FROM RDB.dbo.FraudSmall;'
	,@input_data_1_name = N'fraudDS'
	,@output_data_1_name = N'OutputDataset';
--WITH RESULT SETS ((plot varbinary(max)));

SELECT top 1 plot FROM RDB.dbo.plots;

-- We can now go to SSRS to serve this plot
-- Just open up Report Builder, create a new data source pointing to the above data, create a new dataset with the above query, insert a new image in the canvas that points to this data and renders into JPEG.
-- MININT-1NA9NJM

-- Our second example is to score a dataset with a model we built in R

SELECT model FROM RDB.dbo.models;

-- We can run this to show that we can successfully retrieve the model
DECLARE @lmodel2 varbinary(max) = (SELECT TOP 1 model FROM RDB.dbo.models);
EXEC sp_execute_external_script @language = N'R',
@script = N'
mod <- unserialize(as.raw(model))
print(summary(mod))',    
@params = N'@model varbinary(max)',
@model = @lmodel2;  
GO


-- Create prediction stored procedure to score new data with the model
USE RDB;
GO
CREATE PROCEDURE [dbo].[PredictBatchMode] @inquery nvarchar(max)
AS
BEGIN
DECLARE @lmodel2 varbinary(max) = (SELECT TOP 1 model FROM RDB.dbo.models);
EXEC sp_execute_external_script @language = N'R',
@script = N'
# source(''preloadRcode.R'')
mod <- unserialize(as.raw(model))
print(summary(mod))
OutputDataSet <- rxPredict(modelObject = mod, data = InputDataSet, outData = NULL,
predVarNames = "Score", type = "response", writeModelVars = FALSE,
overwrite = TRUE)
str(OutputDataSet)
print(OutputDataSet)',
@input_data_1 = @inquery,
@params = N'@model varbinary(max)',
@model = @lmodel2
WITH RESULT SETS ((Score float));
END

-- Run predictions on the first 10 rows of the data
EXEC PredictBatchMode @inquery = N'select top 10 * from RDB.dbo.FraudSmall';
