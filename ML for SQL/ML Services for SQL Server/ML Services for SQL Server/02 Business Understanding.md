![](graphics/solutions-microsoft-logo-small.png)

# Secure Machine Learning with SQL Server and Microsoft Azure AI

## 02 Business Understanding

<p style="border-bottom: 1px solid lightgrey;"></p> 
<dl>
  <dt>Course Outline</dt>
  <dt>1 Overview and Course Setup</dt>
  <dt>2 Business Understanding <i>(This section)</i></dt>
        <dd>2.1 Setting up the Data Science Project</dd>
        <dd>2.2 Find the Question</dd>
        <dd>2.3 Document the Data</dd>
  <dt>3 Data Acquisition and Understanding</dt>
  <dt>4 Modeling</dt>
  <dt>5 Deployment</dt>
  <dt>6 Customer Acceptance and Model Retraining</dt>
<dl>
<p style="border-bottom: 1px solid lightgrey;"></p> 

From here on out, you'll follow the Data Science Process for teams, and implement each step in an actual implementation. You'll begin with a discovery session with the client, to understand what they are looking for and to determine the best way to solve it.

In the Business Understanding Phase the team determines the prediction or categorical work your organization wants to create. You'll also set up your project planning documents, locate your initial data source locations, and set up the environment you will use to create and operationalize your models. This phase involves a great deal of coordination among the team and the broader organization.

### Goals for Business Understanding

- Specify the key variables that are to serve as the model targets and whose related metrics are used determine the success of the project.
- Identify the relevant data sources that the business has access to or needs to obtain.

### How to do it (There are two main tasks addressed in this stage)

- Define objectives: Work with your customer and other stakeholders to understand and identify the business problems. Formulate questions that define the business goals that the data science techniques can target.
- Identify data sources: Find the relevant data that helps you answer the questions that define the objectives of the project.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>2.1 Setting up the Data Science Project</b></p>

Begin by assembling your team. It should include a Data Scientist, a Data Engineer (data professional with Data Science team experience), a business or organizational representative, and the owner of the project. If the project is going to go forward, set up a schedule for the work that follows. 

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>2.2 Find the Question</b></p>

Remember that not every question can be answered by Machine Learning. Some questions can be solved with simple Linear Regression, Business Intelligence, or even a query in a report. Check the last module for the types of scenarios where Machine Learning works well. 

In this case, the Contoso organization has presented the following scenario: 

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/contosologo.png" width="50"><i>
We own and operate a rental ski business in the Pacific Northwest of the United States. Skiing revenue is subject to the weather, mountain passes, road conditions and economic factors.

We need to be able to predict demand for our services. Transferring appropriate stock, asking staff to travel in, and renting the facilities is very expensive, and the if the customers don't arrive in sufficient numbers, we lose significant profit each day.

We have data from previous years on attendance and other factors, and we would like to be able to predict demand down to the specific rentals. This will allow us to maximize our profit and ensure our staff and equipment are engaged.
</i></p>

What question does Contoso want answered? Is it a prediction, a classification, or a clustering exercise? What are some candidate algorithms that could be used to create a Model?

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>2.3 Document the Data</b></p>

Getting an accurate prediction involves having solid training data that is as predictive as possible. In most cases, this involves a preliminary investigation by the Data Scientist to determine the Features and Labels that would best fit a prediction or classification. This data may be on hand already, or you may need to acquire it. In some cases, the data does not exist that would create a good model, and in that case a set of proxy data may be used, or the collection of that data started and the project delayed until a representative dataset is available.

In the case of this course, the data is wholly contained within the sample database. However, you might think about other data sources that could be useful.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity: Review Project Documents, Determine specific Questions, Document the Data Source</b></p>

- Open  `./assets/Advanced Analytics Microsoft Project Plan.xls` (if possible) and review its structure.
- Fill out the project Charter Document: `./assets/Charter.md`
- Identify Data Sources: `./assets/DataDefintion.md`
- Create a Data Dictionary: `./assets/DataDictionary.md`

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/thinking.jpg"><b>For Further Study</b></p>

- Business Understanding Reference - https://docs.microsoft.com/en-us/azure/machine-learning/team-data-science-process/lifecycle-business-understanding

Next, Continue to *03 Data Acquisition and Understanding*