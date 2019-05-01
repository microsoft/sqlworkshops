![](graphics/microsoftlogo.png)

# Hybrid Machine Learning

#### <i>A Microsoft Course from the Learn AI team</i>

## 4 - Modeling

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
In this phase, you'll perform feature engineering, create the experiment runs, and run experiments with various settings and parameters. After selecting the best performing run, you'll create a trained model and save it for operationalization in the next phase.

### Goals for Modeling

- Determine the optimal data features for the machine-learning model.
- Create an informative machine-learning model that predicts the target most accurately.
- Create a machine-learning model that's suitable for production.

### How to do it

- Feature engineering: Create data features from the raw data to facilitate model training.
- Model training: Find the model that answers the question most accurately by comparing their success metrics.
- Determine if your model is suitable for production.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>4.1 Data Engineering</b></p>

Often times, the data needs to be prepared and cleaned before you start training the Model. In this course, most of the preparations have already been done within the database, but to work with the data you have to create this model, you'll convert certain values to factors, making them categorical, creating rolling windows for the maintenance and other tasks.

You'll use a Jupyter Notebook environment to work with your model. You're doing that for this course as a learning exercise, although this is a common way of working with a Data Science project. It's also common to work with Azure Machine Learning Services, Azure DataBricks, Azure Cosmos DB or other tools to explore your data, create an experiment, and create and train a model.

The key to the Hybrid Machine Learning Scenario is that you create that model in one location, store the results as a serialized model (using Python's "Pickle" function or the ONNX standard, and then bring that model in to a local environment using an engine like SQL Server ML Services or [ML.NET with ONNX](https://blogs.msdn.microsoft.com/dotnet/2018/10/08/announcing-ml-net-0-6-machine-learning-net/) to do the predictions.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity: Feature Engineering using Python</b></p>

**NOTE:** *Allow each Cell to complete before continuing on to a new Cell - running the next Cell before the previous one finish will cause your experiment to fail.*

- Continue (or re-connect) to the course's Jupyter Notebook.
- One inside the Notebook, look for the section marked `04 Modeling`, and then the section below that marked `Activity: Feature Engineering using Python`.
- Read the Cell instructions, and then click `Run` to process the data into Features. Note that this will take some time. *(Whenever the Kernel is working on a task, the small circe next to the words `HybridML` in the top right corner of the Notebook will be filled in)*

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>4.2 Train the Model</b></p>

In order to predict using a Model, you have to first find a function that best describes the dependency between the variables in your dataset. This step is called *training the model*. The training dataset will be a subset of the entire dataset. In the next exercise you are going to create the model using the Features and Labels from the previous exercise.

In production, you will use multiple algorithms and variables (hyperparameters) to find the best model. In this case, you'll focus on one model, and use that. You will, however, see how to evaluate the model, which you would do with each run (experiment).

You'll use one set of data to train your model, and another other to test how well it performed. In this activity you will use a natural time-period-break (rolling window) to segment the testing and training data. This is a process you should repeat with different ways of separating this data, since one parameter or another might have factors that unduly weight the results.

It's interesting to see that the Data Scientist decided to use the Pandas function of the Rolling Mean. This function is now deprecated in Pandas. You have two choices - you can create the same environment that the original developer used (*as we have had you do in this course*) or you could fix the code. Fixing the code means changing - however slightly - the original experiment. This course had you duplicate the original environment, which took quite a bit of tuning to get right - recall all the conda statements you ran to get the environment correct. This is a real-world lesson on working with multiple people in a team project.

*As a "stretch" assignment, you can go back after you complete the course and attempt to re-create the code with the correct syntax. Of course, this means that you will then have to ensure that the Operationalizing system (SQL Server ML Services in this case) **also** has the right code/library version combination.*

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity: Create the Training Experiment</b></p>

- Continue (or re-connect) to the course's Jupyter Notebook.
- One inside the Notebook, look for the section marked `04 Modeling`, and then the section below that marked `Activity: Create the Training Experiment`.
- Read the Cell instructions, and then click `Run` to process the data into Features in each Cell. Note that this will take some time. *(Whenever the Kernel is working on a task, the small circe next to the words `HybridML` in the top right corner of the Notebook will be filled in)*
- Remember to wait for each cell to complete.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>4.3 Evaluating the Model</b></p>

For each type of algorithm and each set of hyperparameters you choose, you should evaluate the performance of the results. You can do that by working with various Machine Learning concepts such as a confusion matrix, an FI-score, and more.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity: Evaluating Training Performance</b></p>

You'll use your Jupyter Notebook to work with Azure ML Services. While the experiment runs, take a look at the next section, *4.4 Using Azure ML Services*.

**NOTE:** *Allow each Cell to complete before continuing on to a new Cell - running the next Cell before the previous one finish will cause your experiment to fail.*

- Continue (or re-connect) to the course's Jupyter Notebook in your DSVM.
- One inside the Notebook, look for the section marked `04 Modeling`, and then the section below that marked `Activity: Evaluating Training Performance`.
- Read the Cell instructions, and then click `Run` to process the data into Features in each Cell. Note that this will take some time. *(Whenever the Kernel is working on a task, the small circe next to the words `HybridML` in the top right corner of the Notebook will be filled in)*
- Stop at the cell marked `Evaluation`.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>4.4 Using Azure ML Services</b></p>

Using Azure ML Services to create these experiments allows greater scale, and many service-based features that allow you to create, run, and manage the entire process. Azure ML Services also helps a great deal with the environment and CI/CD aspects of your work.

You spent some time on these decisions during the Architecture Design Session, and there are a few other components that will assist in your model development:

- [Azure ML Service](https://docs.microsoft.com/en-us/azure/machine-learning/service/overview-what-is-azure-ml) - Develop and deploy machine learning models at scale.
- [Azure ML SDK](https://docs.microsoft.com/en-us/python/api/overview/azure/ml/intro?view=azure-ml-py) - Build and run machine learning workflows upon the Azure Machine Learning service. [Short video on this process is here](https://channel9.msdn.com/Shows/AI-Show/VS-Code-Tools-for-AI-Train-ML-Models-With-Azure-Machine-Learning)
- [Azure AutoML](https://docs.microsoft.com/en-gb/azure/machine-learning/service/tutorial-auto-train-models) - Identify the best algorithm to use for a given Machine Learning Problem. [More here](https://azure.microsoft.com/en-us/blog/announcing-automated-ml-capability-in-azure-machine-learning/)
- [Azure Hyperdrive](https://docs.microsoft.com/en-us/azure/machine-learning/service/how-to-tune-hyperparameters) -  Automatically tune hyperparameters for your model using Azure Machine Learning service.
- [ONNX](https://onnx.ai/) - An open format to represent deep learning models, allows transfer between frameworks (such as TensorFlow and PyTorch)
- [Azure DevOps](https://azure.microsoft.com/en-us/solutions/devops/) - Automate the entire process from code commit to production if your CI/CD tests are successful.

Your instructor will show you the general thoughts around these areas, and then you'll incorporate these features into the design.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity: Incorporate Azure ML Services into the Solution</b></p>

- Using the information above, examine the architecture for where it fits. What changes could/should you make to take advantage of these services?

<p><img style="margin: 0px 15px 15px 0px;" src="./graphics/thinking.jpg"><b>For Further Study</b></p>

<br>

 - Learn more about Feature Engineering and Modeling here: https://docs.microsoft.com/en-us/azure/machine-learning/team-data-science-process/lifecycle-modeling

Next, you'll continue following the Team Data Science Process with <a href="05%20Deployment.md" target="_blank"><i>Phase 5 - Deployment</i></a>