![](graphics/microsoftlogo.png)

# Hybrid Machine Learning

#### <i>A Microsoft Course from the Learn AI team</i>

## 3 - Data Acquisition and Understanding

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

From Business Intelligence you're familiar with Extract, Transform and Load (ETL) to prepare data for historical, pre-aggregated storage for ad-hoc queries. For Machine Learning, it's more common to extract the data, load it ito a source, and then transform the data as late as possible in the process (ELT). This allows the most fidelity within the process.

There are multiple ways to ingest data, depending on the intended location. For SQL Server, data is often generated within base tables by applications, and other data can be loaded via the bcp program or SQL Server Integration Services. For Azure Machine Learning Services, you can use Azure Blob storage, Azure SQL DB, and many other locations.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>3.1 Loading Data into the Solution</b></p>

In the Data Acquisition and Understanding phase of your process you ingest or access data from various locations to answer the questions the organization has asked. In most cases, this data will be in multiple locations. Once the data is ingested into the system, you’ll need to examine it to see what it holds. All data needs cleaning, so after the inspection phase, you’ll replace missing values, add and change columns. You’ll cover more extensive Data Wrangling tasks in other courses. In this section, you’ll use a single Database dataset to train your model.

### Goals for Data Acquisition and Understanding

- Produce a clean, high-quality data set whose relationship to the target variables is understood. Locate the data set in the appropriate analytics environment so you are ready to model.
- Develop a solution architecture of the data pipeline that refreshes and scores the data regularly.

### How to do it

- Ingest the data into the target analytic environment.
- Explore the data to determine if the data quality is adequate to answer the question.
- Set up a data pipeline to score new or regularly refreshed data.

In this scenario, the data is currently collected into a SQL Server database from the systems on-premises:

<img style="height: 600; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" src="./graphics/ContosoManufacturingProcess.png">

Your Source Data is already in the destination system for operationalization. But for this scenario, the data is used to train in another system, and because of the security requirements, there is one additional step: Anonymizing the data. Recall that the requirements for this project state that the data cannot leave the premises with identifiers intact. In the database you have for this assignment, your team has already exported the data, stripping the identifiers from the appropriate locations.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity: Anonymizing data</b></p>

- In the course sample data, the system ID numbers have already been anonymized. Discuss the processes and tools you can use, with other options you can think of.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity: The Training environment </b></p>

For the Machine Learning section of this course, you will use Python with the *SciKit-Learn* and *numpy* libraries for training a model. The data pipeline is simulated using the *wget* utility in a Jupyter Notebook in Azure Machine Learning Services. You'll run the model training in your Data Science Virtual Machine (DSVM) - sometimes called the "Training Target". There are many considerations for this decision, and in production you are concerned with several of these factors.

- As a class, list the reasons and justifications for using a remote system for the model training
- What concerns have not been addressed so far in the architecture you are currently using?


<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity: Import the Anonymized Export of Data into Azure Machine Learning Services</b></p>

In this activity, you'll create an environment for the library versions you want, open a Jupyter Notebook, and load the data. (You'll use the sections in this Notebook throughout the rest of the course, so you can leave it open after you run these sections)

*Note that you will create an environment to isolate and stay consistent with the Data Scientist's original experiment. This is a rather complicated problem, and you'll walk through this exercise to ensure that you understand how that works. Azure Machine Learning Services solves many of these issues, as does Azure Databricks.*

- Connect to the  Data Science Virtual Machine (DSVM) you created as part of your pre-requisites.
- Open a command-prompt on the DSVM.
- Change directories to the location where you copied the course's source files, and then to `ML Services for SQL Server/notebooks`. *You must run all commands from this directory*.
- Create an environment to ensure the proper versions of the libraries you want to use by typing `conda env create -f environment.yml`. Allow that process to complete.
- Use that new environment by typing `activate HybridML`
- Verify that the course's environment is installed and in place by typing `conda env list`. Notice that there is an asterisk next to the currently set environment.
- Ensure the Jupyter Notebook's Kernel will have access to this new environment by typing `python -m ipykernel install --user --name HybridML --display-name "HybridML"`
- Type `Jupyter Notebook` and press `ENTER`. Allow the Notebook server to start, and wait for the web page to appear. *Note: You may get an error that the Kernel is not set. If so, select the "HybridML" Kernel.*
- Click on the `Predictive Maintenance in Python Notebook.ipynb` file.
- One inside the Notebook, look for the section marked `03 Data Acquisition and Understanding`, and then the section below that marked `# Activity: Import the Anonymized Export of Data into Azure Machine Learning Services`.
- Read the Cell instructions, and then click `Run` to load the data. Note that this will take some time. *(Whenever the Kernel is working on a task, the small circe next to the words `HybridML` in the top right corner of the Notebook will be filled in)*
- Once the data is loaded to the Notebook location, you need to read it in to a Data Frame using the Pandas library, which allows Python to work with the data conveniently. Read the next Cell about that process, and then run the code Cell below it. (Once again, this takes some time, so watch the small circle and wait for it to complete) You now have five Data Frames that comprise your data load.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>3.2 Data Exploration and Profiling</b></p>

With the data located and loaded, you can now begin the exploration. You need to know the "shape" of the data, some basic statistics, and very importantly, any missing values.

You can use various libraries and language statements for a majority of the exploration. The SQL language has a rich, declarative structure that will provide most of the information you need. There are other options for for exploring your data, such as R or Python. R is a data-first language, and most Data Scientists are familiar with using it to explore data. Python has a rich set of libraries to query, visualize and explore data.

You can perform this analysis remotely on your local system, or in Azure, using Jupyter Notebooks as you will in this course. You can also use SQL Server Stored Procedures to hold the Python or R code and run it within SQL Server ML Services as you saw in the previous module. You can  use a series of R or Python Library calls to query the data held in SQL Server and work with it locally to a workstation in a traditional fashion.

In the graphic below, the Data Scientist works with R locally, and once they determine a good model, deploy that to SQL Server. Clients use that Model by calling a standard SQL Server Stored Procedure, and no R client is needed on their machine or device:

<p>
<img src="./graphics/MLServerArchitecture.png" width="500">
<p>

In this scenario, you'll create the model, and then deploy the output to SQL Server locally. To begin, you'll use Python statements and graphical libraries to understand the data. You'll explore the data with this process next.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity: Explore the Data using Python and Jupyter Notebooks</b></p>

- Open your Jupyter Notebook and find the location marked `03 Data Acquisition and Understanding`, and then the section below that marked `# Activity: Explore the Data using Azure ML and Jupyter Notebooks`.
- Read each content Cell, and then run each code Cell, allowing it to finish and examining the output as described. Note that some cells take a bit of time to complete, so wait for each output prior to running the next Cell. Running a Cell before a previous Cell completes will cause errors.
- Stop at the cell marked `04 Modeling`.

<p><img style="margin: 0px 15px 15px 0px;" src="./graphics/thinking.jpg"><b>For Further Study</b></p>

<br>

- Data Acquisition and Understand Reference: https://docs.microsoft.com/en-us/azure/machine-learning/team-data-science-process/lifecycle-data

Next, you'll continue following the Team Data Science Process with <a href="04%20Modeling.md" target="_blank"><i>Phase 4 - Modeling</i></a>