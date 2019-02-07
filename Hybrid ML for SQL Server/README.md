![](graphics/microsoftlogo.png)

# Hybrid Machine Learning

#### <i>A Microsoft Course from the Learn AI team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px; height: 30;" src="./graphics/thinking.jpg">About this Course</h2>

Welcome to this Microsoft Solutions course on *Hybrid Machine Learning*. In this course, you'll learn how to implement a complete solution from start to finish using a defined Data Science process leveraging the Microsoft AI platform and SQL Server, and you'll also learn the skills you need to create other solutions on your own. This README.MD file explains how the course is laid out, what you will learn, and the technologies you will use in this solution.

(You can view all of the [source files for this course on our github site. And you can find more courses there as well. Open this link in a new tab to find out more.](https://azure.github.io/learnAnalytics-public/))

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px; height: 35;" src="./graphics/brain.png">Course Goals</h2>

In this course you'll learn how to take a model that was trained on another system and operationalize it using SQL Server, maintaining the local predictions of the data while allowing powerful training in another system. Using machine telemetry data, you'll take a trained model from an external system that uses anomalies in collected data to perform predictive maintenance. You'll then apply the model using SQL Server Machine Learning Services and create a prediction table of the systems that require maintenance. You'll also learn how to leverage various features of Azure Machine Learning to extend the solution, such as model management with CI/CD. You'll visualize the output as a Power BI report from on-premises systems. Optionally, you can also change this solution to a complete virtual environment in Microsoft Azure.

<h3>Data Science and Business Applications of this course</h3>

Businesses require critical equipment to be running at peak efficiency and utilization to realize their return on capital investments. These assets could range from aircraft engines, turbines, elevators, or industrial chillers - that cost millions - down to everyday appliances like photocopiers, coffee machines, or water coolers.

By default, most businesses rely on *corrective* maintenance, where parts are replaced as and when they fail. Corrective maintenance ensures parts are used completely (therefore not wasting component life), but costs the business in downtime, labor, and unscheduled maintenance requirements (off hours, or inconvenient locations).

At the next level, businesses practice *preventive* maintenance, where they determine the useful lifespan for a part, and maintain or replace it before a failure. Preventive maintenance avoids unscheduled and catastrophic failures. But the high costs of scheduled downtime, under-utilization of the component before its full lifetime of use, and labor still remain.

The goal of *predictive* maintenance (PdM) is to optimize the balance between corrective and preventative maintenance, by enabling just in time replacement of components. This approach only replaces those components when they are close to a failure. By extending component lifespans (compared to preventive maintenance) and reducing unscheduled maintenance and labor costs (over corrective maintenance), businesses can gain cost savings and competitive advantages.

Businesses face high operational risk due to unexpected failures and have limited insight into the root cause of problems in complex systems. Some of the key business questions are:

    Detecting anomalies in equipment or system performance or functionality.
    Predicting whether an asset may fail in the near future.
    Estimating the remaining useful life of an asset.
    Identifying the main causes of failure of an asset.
    Identifying what maintenance actions need to be done, by when, on an asset.

Typical goal statements from PdM are:

    Reduce operational risk of mission critical equipment.
    Increase rate of return on assets by predicting failures before they occur.
    Control cost of maintenance by enabling just-in-time maintenance operations.
    Lower customer attrition, improve brand image, and lost sales.
    Lower inventory costs by reducing inventory levels by predicting the reorder point.
    Discover patterns connected to various maintenance problems.
    Provide KPIs (key performance indicators) such as health scores for asset conditions.
    Estimate remaining lifespan of assets.
    Recommend timely maintenance activities.
    Enable just in time inventory by estimating order dates for replacement of parts.

These goal statements are the starting points for:

    Data Scientists, to analyze and solve specific predictive problems.
    Solution Architects and Developers, to put together an end to end solution.

<h3>Solution Diagram</h3>
This solution uses a model to do predictive "Remaining Useful Life" (RUL) industry-standard predictions on an mechanical engine of almost any type, but it has many applications.

In this diagram, the solution is divided into two sections: The model training, which is done in Azure, and the model operationalization, which is done on-premises. Both parts of the solution are kept under the management of the DevOps function in an organization.

<img style="height: 600; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" src="./graphics/SQLML.png">

<p style="border-bottom: 1px solid lightgrey;"></p>

<h3>Sample Solution Output</h3>

 As an example, when applied to an aircraft engine, a [Power BI report can indicate the specifics and location](https://docs.microsoft.com/en-us/azure/iot-accelerators/quickstart-predictive-maintenance-deploy) of a particular component that requires maintenance:

<img style="height: 300; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" src="./graphics/AirplanePowerBIReport.png">

Many other outputs and API calls are available, from alerting via SMS, intelligent assistant, web interfaces and more. Another example is an [interactive Power BI Report on plant-floor-based processing equipment](http://www.microsoftazureiotsuite.com/demos/predictivemaintenance):

<img style="height: 300; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" src="./graphics/GeneralPowerBIReport.png">

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px; height: 20;" src="./graphics/keyboard.jpg">Technologies</h2>

This solution includes the following technologies - although you are not limited to these, they form the basis of the course. At the end of the course you will learn how to extrapolate these components into other solutions.

 <table style="width: 75%; tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 2px; border-color: gray;">

  <tr>
    <th style="background-color: #1b20a1; color: white;">Technology</th>
    <th style="background-color: #1c6afc; color: white;">Use</th>
  </tr>

  <tr>
    <td>Microsoft Data Science Process (TDSP)</td>
    <td>Project, Development, Control and Management framework</td>
  </tr>
  <tr>
    <td>Microsoft Azure</td>
    <td>Development environment, and/or as training/operationalize environment, security, IoT hub, telemetry, monitoring and management</td>
  </tr>
  <tr>
    <td>Azure Data Science Virtual Machine (DSVM)</td>
    <td>Development environment, and/or as training/operationalize target</td>
  </tr>
  <tr>
    <td>ONNX and Other Serializing Technologies</td>
    <td>Model translation/transport</td>
  </tr>
  <tr>
    <td>SQL Server 2017 Machine Learning Services</td>
    <td>Operationalize environment, hybrid data</td>
  </tr>
  <tr>
    <td>Azure ML SDK</td>
    <td>AutoML, CI/CD (Model Management)</td>
  </tr>
  <tr>
    <td>Power BI</td>
    <td>Visualization</td>
  </tr>
    <tr>
    <td><i>Python</i></td>
    <td><i>ML/AI programming, Model creation, Data Generator Simulation</i></td>
  </tr>
  <tr>
    <td><i>SciKit Learn</i></td>
    <td><i>(Optional if training done in SQL Server ML)</i></td>
  </tr>
  <tr>
    <td><i>Jupyter Notebook with Python</i></td>
    <td><i>Used for Model Training.</i></td>
  </tr>
</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px; height: 20;" src="./graphics/aml-logo.png">Industries</h2>

This solution uses a single industry for learning the tools and concepts, but it extrapolates to many industries.

 <table style="width: 75%; tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 2px; border-color: gray;">

  <tr>
    <th style="background-color: #155c0d; color: white;">Industry</th>
    <th style="background-color: #1e9611; color: white;">Examples of relevant scenarios</th>
  </tr>

<tr><td>Aerospace - <i>Flight delay and cancellations</i></td><td>Flight route information in the form of flight legs and page logs. Flight leg data includes routing details such as departure/arrival date, time, airport, layovers etc. Page log includes a series of error and maintenance codes recorded by the ground maintenance personnel.</td></tr>
<tr><td>Aerospace - <i>Aircraft engine parts failure</i></td><td>Data collected from sensors in the aircraft that provide information on the condition of the various parts. Maintenance records help identify when component failures occurred and when they were replaced.</td></tr>
<tr><td>Finance - <i>ATM Failure</i></td><td>Sensor readings for each transaction (depositing cash/check) and dispensing of cash. Information on gap measurement between notes, note thickness, note arrival distance, check attributes etc. Maintenance records that provide error codes, repair information, last time the cash dispenser was refilled.</td></tr>

<tr><td>Public Utilities - <i>Wind turbine or line Power failure</i></td><td>Sensors monitor turbine conditions such as temperature, wind direction, power generated, generator speed etc. Data is gathered from multiple wind turbines from wind farms located in various regions. Typically, each turbine will have multiple sensor readings relaying measurements at a fixed time interval.</td></tr>

<tr><td>Public Utilities - <i>Circuit breaker failures</i></td><td>Maintenance logs that include corrective, preventive, and systematic actions. Operational data that includes automatic and manual commands sent to circuit breakers such as for open and close actions. Device metadata such as date of manufacture, location, model, etc. Circuit breaker specifications such as voltage levels, geolocation, ambient conditions.</td></tr>

<tr><td>Facilities - <i>Door and other automatic surfaces failures<i></td><td>Door metadata such as type of elevator, manufactured date, maintenance frequency, building type, and so on. Operational information such as number of door cycles, average door close time. Failure history with causes.</td></tr>

<tr><td>Manufacturing - <i>Component failures</i></td><td>Sensor data that measures  acceleration, braking instances, distance, velocity etc. Static information on wheels like manufacturer, manufactured date. Failure data inferred from part order database that track order dates and quantities.</td></tr>

<tr><td>Transportation - <i>Subway train door failures/Bus component failures</i></td><td>Door opening and closing times, other operational data such as current condition of train or bus components. Static data would include asset identifier, time, and condition value columns.</td></tr>
</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px; height: 30;" src="./graphics/pin.jpg">Before Taking this Course</h2>

You must have a Microsoft Azure account with the ability to create assets. You will use an Azure Data Science Virtual Machine (DSVM) for this course, and use Jupyter Notebooks running Python to create an experiment for the model generation.

<h3>Skills</h3>

This course expects that you understand data structures and working with SQL Server. This course does not expect the reader to have any prior data science knowledge. For the Data Science content, basic knowledge of statistics and data science is helpful. Knowledge of SQL Server, Azure Data and AI services, Python, and Jupyter Notebooks is recommended. AI techniques are implemented in Python packages. Solution templates are implemented using Azure services, development tools, and SDKs. You should have a basic understanding of working with the Microsoft Azure Platform.

If you are new to these, here are a few references you should complete prior to class:

-  [Microsoft Azure](https://docs.microsoft.com/en-us/learn/paths/azure-fundamentals/)
-  [Working with Jupyter Notebooks](https://notebooks.azure.com/Microsoft/libraries/samples)
-  [Python Introduction](https://notebooks.azure.com/Microsoft/libraries/samples/html/Introduction%20to%20Python.ipynb)
-  [Visual Studio Code](https://code.visualstudio.com/docs/getstarted/introvideos)
-  [Microsoft SQL Server](https://docs.microsoft.com/en-us/sql/relational-databases/database-engine-tutorials?view=sql-server-2017)


<h3>Setup</h3>

<a href="ML%20Services%20for%20SQL%20Server/00%20Pre-Requisites.md" target="_blank">A full pre-requisites document is located here</a>. These instructions should be completed the day before the course starts, since we will not have time to cover these in class. Remember to turn off the DSVM from the Azure Portal when not taking the class so that you do encure charges (shutting down the machine in the VM itself is not sufficient).

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px; height: 15;" src="./graphics/check.png">Course Details</h2>

The "hybrid Machine Learning with SQL Server ML and Azure ML" course is taught using Microsoft Azure, SQL Server, and Visual Studio/Visual Studio Code/Jupyter Notebooks, with a focus on Python and Azure ML.

<table style="width: 50%; tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 2px; border-color: gray;">

  <tr>
    <td style="background-color: #965a11; color: white;">Primary Audience</td>
    <td>System Architects and Data Professionals tasked with developing hybrid Machine Learning and AI solutions</td>
  </tr>

  <tr>
    <td style="background-color: #965a11; color: white;">Secondary Audience</td>
    <td>Security Architects, Developers, and Data Scientists</td>
  </tr>

  <tr>
    <td style="background-color: #965a11; color: white;">Level</td>
    <td>300</td>
  </tr>

  <tr>
    <td style="background-color: #965a11; color: white;">Type</td>
    <td>In-Person</td>
  </tr>

  <tr>
    <td style="background-color: #965a11; color: white;">Length</td>
    <td>8 hours</td>
  </tr>
</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px; height: 20;" src="./graphics/files.jpg">Related Courses</h2>

[Technical guide to the Cortana Intelligence Solution Template for predictive maintenance in aerospace and other businesses](https://docs.microsoft.com/en-us/azure/machine-learning/team-data-science-process/cortana-analytics-technical-guide-predictive-maintenance)

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png">Course Outline</h2>

This is a modular course, and in each section, you'll learn technologies and processes to help you complete the solution.

<dl>
  <dt>Modules in this course:</dt>
  <dt><a href="ML%20Services%20for%20SQL%20Server/01%20Project%20Methodology%20and%20Data%20Science.md" target="_blank">1 Project Methodology and Data Science</a></dt>
  <dt><a href="ML%20Services%20for%20SQL%20Server/02%20Business%20Understanding.md" target="_blank">2 Business Understanding</a></dt>
  <dt><a href="ML%20Services%20for%20SQL%20Server/03%20Data%20Acquisition%20and%20Understanding.md" target="_blank">3 Data Acquisition and Understanding</a></dt>
  <dt><a href="ML%20Services%20for%20SQL%20Server/04%20Modeling.md" target="_blank">4 Modeling</a></dt>
  <dt><a href="ML%20Services%20for%20SQL%20Server/05%20Deployment.md" target="_blank">5 Deployment</a></dt>
  <dt><a href="ML%20Services%20for%20SQL%20Server/06%20Customer%20Acceptance%20and%20Retraining.md" target="_blank">6 Customer Acceptance and Model Retraining</a></dt>
<dl>

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/thinking.jpg"><b>Next Steps</b></p>

Next, Continue to <a href="ML%20Services%20for%20SQL%20Server/00%20Pre-Requisites.md" target="_blank"><i>Pre-Requisites</i></a>.
