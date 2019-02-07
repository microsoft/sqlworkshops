![](graphics/solutions-microsoft-logo-small.png)

# Secure Machine Learning with SQL Server and Microsoft Azure AI

## 06 Customer Acceptance and Model Retraining

<p style="border-bottom: 1px solid lightgrey;"></p> 
<dl>
  <dt>Course Outline</dt>
  <dt>1 Overview and Course Setup</dt>
  <dt>2 Business Understanding</dt>
  <dt>3 Data Acquisition and Understanding</dt>
  <dt>4 Modeling</dt>
  <dt>5 Deployment</i></dt>
  <dt>6 Customer Acceptance and Model Retraining <i>(This section)</dt>
        <dd>6.1 Call the Prediction from a Stored Procedure</dd>
        <dd>6.2 Close out the project</dd>
<dl>
<p style="border-bottom: 1px solid lightgrey;"></p> 

The final phase involves testing the model predictions on real-world queries to ensure that it meets all requirements. In this phase you will also document the project so that all parameters are well-known. Finally, a mechanism is evaluated to re-train the model. You will not cover the retraining portion of the process in this course.

### Goals for Customer Acceptance

- Confirm that the pipeline, the model, and their deployment in a production environment satisfy the customer's objectives
- Create a project close out document
- Create a path for retraining your model

### How to do it

- System validation: Confirm that the deployed model and pipeline meet the customer's needs.
- Project hand-off: Hand the project off to the entity that's going to run the system in production
- Develop a "ground truth" mechanism and feed the new labels (if applicable) back into the retraining API

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>6.1 Test the predictions with a Stored Procedure</b></p>

Using the binary Model you created, you can now allow users to make calls to the system for predictions. In the code that the application runs, you need to send along the Features the model expects, and accept the returned value(s) as the prediction. Alternately, you could store the results in a table or other SQL Server object. 

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity: Make a call with features sent to the Model's Stored Procedure</b></p>

- Connect to SQL Server with a SQL query tool, and run the following code that sends five Features to the Model:

<pre>
-- Execute the predict_rentals stored proc and pass the model name and a query string with a set of features we want to use to predict the rental count
EXEC dbo.predict_rentalcount_new @model = 'rxDTree',
       @q ='SELECT CONVERT(INT, 3) AS Month, CONVERT(INT, 24) AS Day, CONVERT(INT, 4) AS WeekDay, CONVERT(INT, 1) AS Snow, CONVERT(INT, 1) AS Holiday';
GO
</pre>

You'll get back a prediction showing how many rentals are expected.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>6.2 Close out the Project</b></p>

To complete the project, document the steps, findings, and results. In the activity that follows, you'll find a complete document reference for this process.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity: Create a Project Cloudout Document</b></p>

- Open the `./assets/ProjectCloseout.md` file and fill in the fields from your project.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/thinking.jpg"><b>For Further Study</b></p>
 - Learn more about closing out a Data Science project here: https://docs.microsoft.com/en-us/azure/machine-learning/team-data-science-process/lifecycle-acceptance 