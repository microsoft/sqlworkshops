![](graphics/microsoftlogo.png)

# Hybrid Machine Learning

#### <i>A Microsoft Course from the Learn AI team</i>

## 2 - Business Understanding

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

Now that the Project is underway (the *Implementation* Project phase), you'll follow the Data Science Process for teams, and implement each step in an actual implementation. You'll begin with a deeper discovery session for determining the best model type and hyperparameters you need for the prediction.

During the *Discovery*, *Envisioning* and *ADS* phases the customer explained the type of answer they were looking for. In this case, the answer involves a *Prediction*, and that means you need to create and train a Machine Learning Model that will use current data for training, so that it can make predictions over data it has not seen. The Project phases are less specific than you need for a Data Science project, since it's important to get the data (features and labels) the process needs. That's what the Business Understanding phase does.

In the *Business Understanding* step of the Team Data Science Process the Data Science team determines the prediction or categorical work your organization wants to create. You'll also set up your project planning documents, locate your initial data source locations, and set up the environment you will use to create and operationalize your models. This phase involves a great deal of coordination among the team and the broader organization.

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

<p><img style="margin: 0px 15px 15px 0px;" src="./graphics/contosologo.png" width="50"><i>
<br>Contoso Manufacturing creates and repairs components for highly varied solutions. We wish to create a Predictive Maintenance solution whereby we can do maintenance on our manufacturing systems efficiently.

We want to use a larger system to but train a predictive model at a remote location, since this will only be done periodically and we don't want to incur CapEx costs for the effort.

Because the training will be done remotely, it's important to ensure data security in the training. We can't let production data with system identifiers off site. (Identifiers are all we really care about, the rest of the data can be traditionally secured)

Currently, all manufacturing systems record data into a SQL Server Instance.

Ideally, the model created would be used in the testing phase of manufacturing for quality control, and also be deployable to an IoT device as an add-on service for the equipment once created.
</i></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity: Defining the Business Problem</b></p>

- Open the `ML Services for SQL Server/assets/Project` folder and review the project documents you see there.
- What question does Contoso want answered? Which document does that go into? Open that document and ensure it's accurate.
- Is this a prediction, a classification, or a clustering exercise? Or just reporting? Who can answer that question? Which document does that go into? Open that document and ensure it's accurate.
- What are the specific requirements and constraints? Which document does that go into? Open that document and ensure it's accurate.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>2.3 Document the Data Sources</b></p>

Getting an accurate prediction involves having solid training data that is as predictive as possible. In most cases, this involves a preliminary investigation by the Data Scientist to determine the Features and Labels that would best fit a prediction or classification. This data may be on hand already, or you may need to acquire it. In some cases, the data does not exist that would create a good model, and in that case a set of proxy data may be used, or the collection of that data started and the project delayed until a representative dataset is available.

In the case of this course, the data is wholly contained within the sample database, and a generated data set for training we will use. However, you might think about other data sources that could be useful.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity: Restore the Database</b></p>

- The dataset used in this course is hosted in a few SQL Server tables.The tables contain data from various systems on-premises over a period of time. The backup (.bak) file is in the `ML Services for SQL Server/data`  directory from wherever you downloaded the course - it's a file called `ContosoEngineering.bak`. Copy that file to a location that SQL Server can access: `C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup`.

- Open Visual Studio Code, and then open the course file `ML Services for SQL Server/code/SQL Scripts for hybrid ML Course.sql`.

- Press F1 and type `sql connect` to connect to your SQL Server Instance. <a href="https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-develop-use-vscode?view=sql-server-2017" target=_blank>(More on how to do that here)</a>:

- Find the section in the file marked `/* Activity: Restore the Database */`, and run the code (highlight and press CTRL-SHIFT-E) from that location until `/* End Activity: Restore the Database */`. Follow any instructions you see there.

You should see rows of data returned. You'll explore those further in the next module.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>2.4 Document the Data Sources</b></p>

One of the primary challenges in this solution is that the production data - which the customer has defined as "with identifiers" - cannot leave the SQL Server system. Of primary importance is the choices for the security of the data. In the *ADS Decision Matrix* Excel spreadsheet, the choices inferred by the team are:

- Use sample data from the machine's manufacturer
- Create a program that simulates the machine's behavior
- Statistically anonymize the data

In the next Module, you will explore these options further. First, you will need to restore the database that exists in the customer's on-premises location.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity: Review Project Documents, Determine specific Questions, Document the Data Source</b></p>

- Open the `ML Services for SQL Server/assets/Project` folder and review the documents you see there.
- Open the **Decision Matrix** Excel Spreadsheet you see there and look through the choices. How do the requirements and constraints impact the technical decisions? *For now, assume these are the correct choices*.
- Examine/Fill out (as time permits) the project Charter Document: `ML Services for SQL Server/assets/Charter.md`
- Examine/Identify (as time permits) Data Sources: `ML Services for SQL Server/assets/DataDefintion.md`
- Examine/Create (as time permits) a Data Dictionary: `ML Services for SQL Server/assets/DataDictionary.md` Is there a way to create a Data Dictionary quickly using only T-SQL statements? Are there reports you could use?
- Are there specific data elements that would be predictive or at least corollary for Predictive Maintenance in the data sample?

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/thinking.jpg"><b>For Further Study</b></p>

<br>

- Business Understanding Reference:  https://docs.microsoft.com/en-us/azure/machine-learning/team-data-science-process/lifecycle-business-understanding

- See https://www.georgetownlawtechreview.org/re-identification-of-anonymized-data/GLTR-04-2017/ for a discussion on statistical obfuscation dangers and methods

Next, you'll continue following the Team Data Science Process with <a href="03%20Data%20Acquisition%20and%20Understanding.md" target="_blank"><i>Phase 3 - Data Acquisition and Understanding</i></a>