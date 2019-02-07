![](graphics/microsoftlogo.png)

# Hybrid Machine Learning

#### <i>A Microsoft Course from the Learn AI team</i>

## 5 - Deployment

<p style="border-bottom: 1px solid lightgrey;"></p>

In this course you're learning to use a Process and a Platform to create a hybrid Machine Learning solution you can deploy on SQL Server. In each section you'll get more references to go deeper, which you should follow up on. Also watch for links within the text - click on each one to explore that topic.

<a href="ML%20Services%20for%20SQL%20Server/00%20Pre-Requisites.md" target="_blank">Make sure you check out the <b>00 Pre-Requisites</b> page before you start</a>. You'll need all of the items loaded there before you can proceed with the course.

You'll cover these topics in the course:

<dl>
  <dt>Modules in this course:</dt>
  <dt><a href="ML%20Services%20for%20SQL%20Server/01%20Project%20Methodology%20and%20Data%20Science.md" target="_blank">1 Project Methodology and Data Science</a></dt>
  <dt><a href="02%20Business%20Understanding.md" target="_blank">2 Business Understanding</a></dt>
  <dt><a href="20Data%20Acquisition%20and%20Understanding.md" target="_blank">3 Data Acquisition and Understanding</a></dt>
  <dt><a href="04%20Modeling.md" target="_blank">4 Modeling</a></dt>
  <dt><a href="05%20Deployment.md" target="_blank">5 Deployment</a></dt>
  <dt><a href="06%20Customer%20Acceptance%20and%20Retraining.md" target="_blank">6 Customer Acceptance and Model Retraining</a></dt>
<dl>

<p style="border-bottom: 1px solid lightgrey;"></p>

In this phase you'll take the Trained Model from the Azure environment and then use the Model in SQL Server using ML Services over hybrid data.

Goal for Deployment
- Deploy models with a data pipeline to a production or production-like environment for final user acceptance

How to do it
- Deploy the model and pipeline to a production or production-like environment for application consumption

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>5.1 Transfer the Model</b></p>

In this section, you will move the Trained Model you created in your Jupyter Notebook to SQL Server and deploy your predictive model with the help of SQL Server Machine Learning Services.

To deploy a model, you store the model in a hosting environment and implement a prediction function that uses the model to predict. That function can be called from applications, on a schedule, or an API service.

Note that you could have trained and created the model directly in SQL Server ML Services using Python or R locally in the context of SQL Server. You can author T-SQL programs that contain embedded Python or R scripts, and the SQL Server database engine takes care of the execution. Because it executes in SQL Server, your training can easily be run against data stored in the database. In this scenario however, you wanted to take advantage of the features of Azure ML Services and train the model there, and you simulated that using a Jupyter Notebook.

In either case, to deploy the model so that you can use it in SQL Server, you will copy the model to a location and SQL Server can read, load it into a binary column of a table in the SQL Server database. To use the model, you will create a stored procedure that does predictions by calling the Model.

The model is stored as a binary object in SQL Server, so you'll begin by making a SQL Server table to hold the binary object.

In this course, your model file is created using Python from a Jupyter Notebook. Whatever technology you use, the key to this "Train elsewhere, use in SQL Server" scenario is that you are able to create a binary representation of your Trained Model for use in SQL Server.

In your Jupyter Notebook, the Python code creates a binary file *(called a pickle)* that contains the Model. There are other serialization methods available, including ONNX that you can use to store your model. If you use Azure Machine Learning Services, the Model is stored in the Cloud.

**NOTE: The Model essentially contains the code from the final training. That means that the receiving system (SQL Server in this course) must be able to run that code, have the same libraries and so on.**

The Model you trained is stored at the location where you downloaded the course, and then `ML Services for SQL Server/notebooks/result_folder`. There's a pickle (*.pkl) for each run of the model, and you'll transfer the last one. You can see the code in the last section of your Jupyter Notebook that creates the Models.

The test data is also stored at this location. For this course, the same Features (minus the Labels of course) have been created using SQL Server Integration Services, and stored in a table called "FeaturesAndLabels". This is data created directly from production, which the model has not seen yet. This has been done for you already, but in production you would work with the SQL Server team to create exactly the same transforms (rolling time windows and so on) that were used to train the model.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity: Copy the Model File</b></p>

In this exercise, you will simulate downloading the Trained Model from Azure by creating a directory that SQL Server has permissions to and copying the latest trained model there.

- From the File Explorer on your DSVM, open the `ML Services for SQL Server/notebooks/result_folder` folder.
- Locate the last model (which you determined was the "best" one from the review stage in the Jupyter Notebook) - `model_2.pkl`.
- Copy that file to the BACKUP directory in SQL Server - normally located at `C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup`. If that location does not exist, you can create a directory anywhere you like, grant full permissions to the account running the SQL Server Service, and store the model there. If you do that, you will need to change the T-SQL statement that loads the data to that new location.

You'll use Visual Studio Code to run these T-SQL statements, but you can also use tools such as Visual Studio, SQL Server Management Studio, or the Azure Data Studio as well. Remain in Visual Studio Code throughout this section.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity: Create a table for the binary Model</b></p>

- Open Visual Studio Code, and then open the course file `ML Services for SQL Server/code/SQL Scripts for Hybrid ML Course.sql`.

- Press F1 and type `sql connect` to connect to your SQL Server Instance. <a href="https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-develop-use-vscode?view=sql-server-2017" target=_blank>(More on how to do that here)</a>:

- Find the section in the file marked `/* Activity: Import Model */`, and run the code (highlight and press CTRL-SHIFT-E) from that location until `/* End Activity: Import Model */`. Follow any instructions you see there.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>5.2 Run Predictions Over Production Data</b></p>

Everything is now in place for you to create the Stored Procedure that will wait for data as input and then run the model, predicting the outcome. You'll send in the Features (in this case, using a SELECT statement as the input variable).

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity: Generate Stored Procedures for Predictions</b></p>

- Find the section in the .sql file marked `/* Activity: Generate Stored Procedure for predictions */`, and run the code (highlight and press CTRL-SHIFT-E) from that location until `/* End Activity: Generate Stored Procedure for predictions */`. Follow any instructions you see there.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>5.3 View Predictions</b></p>

Finally, you're ready to send in new data that the model has *not* seen, and make predictions for which components are likely to fail and need to be addressed.

In this exercise you're simply going to call the Stored Procedure you just created, but in production, you could also persist the data it returns into a table that you can examine with Power BI or some other Visualization tool.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity: View Predictions</b></p>

- Find the section in the .sql file marked `/* Activity: Return Results */`, and run the code (highlight and press CTRL-SHIFT-E) from that location until `/* End Activity: Return Results */`. Follow any instructions you see there.
- *Optional*: Change these statements to store the data with a date-stamp column in another table. Create a visualization of this new table.
- *Optional*: Create a Power BI report that views the data stored in the table stored in the previous step, or have it directly run the prediction and create a real-time chart of the predictions.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/thinking.jpg"><b>For Further Study</b></p>
 - Another example of using a Stored Procedure to predict data using R and SQL Server: https://docs.microsoft.com/en-us/sql/advanced-analytics/tutorials/rtsql-create-a-predictive-model-r?view=sql-server-2017

Next, you'll continue following the Team Data Science Process with <a href="06%20Customer%20Acceptance%20and%20Retraining.md" target="_blank"><i>Phase 6 - Customer Acceptance and Model Retraining</i></a>