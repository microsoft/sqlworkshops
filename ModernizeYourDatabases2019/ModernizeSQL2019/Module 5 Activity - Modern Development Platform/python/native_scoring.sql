USE TutorialDB;

--STEP 1 - Setup model table for storing the model
DROP TABLE IF EXISTS rental_models;
GO
CREATE TABLE rental_models (
                model_name VARCHAR(30) NOT NULL DEFAULT('default model'),
                lang VARCHAR(30),
				model VARBINARY(MAX),
				native_model VARBINARY(MAX),
				PRIMARY KEY (model_name, lang)

);
GO

--STEP 2 - Train model using revoscalepy rx_dtree or rxlinmod
DROP PROCEDURE IF EXISTS generate_rental_py_native_model;
go
CREATE PROCEDURE generate_rental_py_native_model (@model_type varchar(30), @trained_model varbinary(max) OUTPUT)
AS
BEGIN
    EXECUTE sp_execute_external_script
      @language = N'Python'
    , @script = N'
from revoscalepy import rx_lin_mod, rx_serialize_model, rx_dtree
from pandas import Categorical
import pickle

rental_train_data["Holiday"] = rental_train_data["Holiday"].astype("category")
rental_train_data["Snow"] = rental_train_data["Snow"].astype("category")
rental_train_data["WeekDay"] = rental_train_data["WeekDay"].astype("category")

if model_type == "linear":
	linmod_model = rx_lin_mod("RentalCount ~ Month + Day + WeekDay + Snow + Holiday", data = rental_train_data)
	trained_model = rx_serialize_model(linmod_model, realtime_scoring_only = True);
if model_type == "dtree":
	dtree_model = rx_dtree("RentalCount ~ Month + Day + WeekDay + Snow + Holiday", data = rental_train_data)
	trained_model = rx_serialize_model(dtree_model, realtime_scoring_only = True);
'

    , @input_data_1 = N'select "RentalCount", "Year", "Month", "Day", "WeekDay", "Snow", "Holiday" from dbo.rental_data where Year < 2015'
    , @input_data_1_name = N'rental_train_data'
    , @params = N'@trained_model varbinary(max) OUTPUT, @model_type varchar(30)'
	, @model_type = @model_type
    , @trained_model = @trained_model OUTPUT;
END;
GO

--STEP 3 - Save model to table

--Line of code to empty table with models
--TRUNCATE TABLE rental_models;

--Save Linear model to table
DECLARE @model VARBINARY(MAX);
EXEC generate_rental_py_native_model "linear", @model OUTPUT;
INSERT INTO rental_models (model_name, native_model, lang) VALUES('linear_model', @model, 'Python');

--Save DTree model to table
DECLARE @model2 VARBINARY(MAX);
EXEC generate_rental_py_native_model "dtree", @model2 OUTPUT;
INSERT INTO rental_models (model_name, native_model, lang) VALUES('dtree_model', @model2, 'Python');

-- Look at the models in the table
SELECT * FROM rental_models;

GO

--STEP 4  - Use the native PREDICT (native scoring) to predict number of rentals for both models
DECLARE @model VARBINARY(MAX) = (SELECT TOP(1) native_model FROM dbo.rental_models WHERE model_name = 'linear_model' AND lang = 'Python');
SELECT d.*, p.* FROM PREDICT(MODEL = @model, DATA = dbo.rental_data AS d) WITH(RentalCount_Pred float) AS p;
GO

--Native scoring with dtree model
DECLARE @model VARBINARY(MAX) = (SELECT TOP(1) native_model FROM dbo.rental_models WHERE model_name = 'dtree_model' AND lang = 'Python');
SELECT d.*, p.* FROM PREDICT(MODEL = @model, DATA = dbo.rental_data AS d) WITH(RentalCount_Pred float) AS p;
GO