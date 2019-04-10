![](graphics/microsoftlogo.png)

# Hybrid Machine Learning

#### <i>A Microsoft Course from the Learn AI team</i>

## 6 - Customer Acceptance and Model Retraining

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

The final phase of the Team Data Science Process involves testing the model predictions on real-world queries to ensure that it meets all requirements. In this phase you will also document the project so that all parameters are well-known. Finally, a mechanism is evaluated to re-train the model. You will not cover the retraining portion of the process in this course.

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

- Connect to SQL Server with a different SQL query tool, and run the following code that sends the data in the FeaturesAndLabels table:

<pre>
EXEC predict_failures 'pdm_model';
GO
</pre>

You'll get back a prediction showing how many failures are expected.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>6.2 Close out the Project</b></p>

To complete the project, document the steps, findings, and results. In the activity that follows, you'll find a complete document reference for this process.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity: Create a Project Closeout Document</b></p>

- Open the `./assets/project/ProjectCloseout.md` file and fill in the fields from your project.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/thinking.jpg"><b>For Further Study</b></p>

[Learn more about closing out a Data Science project here](https://docs.microsoft.com/en-us/azure/machine-learning/team-data-science-process/lifecycle-acceptance)

Congratulations! You have completed this course on Hybrid Machine Learning Services. You now have the tools, assets, and processes you need to extrapolate this information into other applications.