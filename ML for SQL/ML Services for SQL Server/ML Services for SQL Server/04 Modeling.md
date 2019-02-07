![](graphics/solutions-microsoft-logo-small.png)

# Secure Machine Learning with SQL Server and Microsoft Azure AI

## 04 Modeling

<p style="border-bottom: 1px solid lightgrey;"></p> 
<dl>
  <dt>Course Outline</dt>
  <dt>1 Overview and Course Setup</dt>
  <dt>2 Business Understanding</dt>
  <dt>3 Data Acquisition and Understanding</dt>
  <dt>4 Modeling <i>(This section)</i></dt>
        <dd>4.1 Feature Engineering</dd>
        <dd>4.2 Training the Model</dd>
  <dt>5 Deployment</dt>
  <dt>6 Customer Acceptance and Model Retraining</dt>
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

Often times, the data needs to be prepared and cleaned before you start training the Model. In this course, most of the preparations have already been done within the database, but to work with an R model, you'll convert certain values to factors, making them categorical.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity: Set three Features to Categorical Data using R</b></p>

- Using your last connection from your R tool, run the following code:

<pre>

# Changing the three factor columns to factor types
# This helps when building the model because we are explicitly saying that these values are categorical
rentaldata$Holiday <- factor(rentaldata$Holiday);
rentaldata$Snow <- factor(rentaldata$Snow);
rentaldata$WeekDay <- factor(rentaldata$WeekDay);

#Visualize the dataset after the change
str(rentaldata);
</pre>

- Show the new data types in your R Data Frame

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>4.2 Train the Model</b></p>

In order to predict using a Model, you have to first find a function that best describes the dependency between the variables in your dataset. This step is called *training the model*. The training dataset will be a subset of the entire dataset. In the next exercise you are going to create two different models and see which one is predicting most accurately - one using a simple linear model and another than uses a tree.

One set of data is used to train your model, and the other to test how well it performed. In this activity you will use a natural year-break to create the testing and training data. This is a process you should repeat with different ways of separating this data, since one year might have factors that unduly weight the results. 

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity: Create an Experiment with two Algorithms</b></p>

- Using your last connection from your R tool, run the following code to create an experiment:

<pre>

# Split the dataset into 2 different sets:
# One set for training the model and the other for validating it
train_data = rentaldata[rentaldata$Year < 2015,];
test_data = rentaldata[rentaldata$Year == 2015,];

# Use this column to check the quality of the prediction against actual values
actual_counts <- test_data$RentalCount;

# Model 1: Use rxLinMod to create a linear regression model. We are training the data using the training data set
model_linmod <- rxLinMod(RentalCount ~  Month + Day + WeekDay + Snow + Holiday, data = train_data);

# Model 2: Use rxDTree to create a decision tree model. We are training the data using the training data set
model_dtree <- rxDTree(RentalCount ~ Month + Day + WeekDay + Snow + Holiday, data = train_data);
</pre>

- Now create a prediction run to record how each model records:

<pre>
# Use the models you just created to predict using the test data set 
# that enables you to compare actual values of RentalCount from the two models and compare to the actual values in the test data set:
predict_linmod <- rxPredict(model_linmod, test_data, writeModelVars = TRUE, extraVarsToWrite = c("Year"));

predict_dtree <- rxPredict(model_dtree, test_data, writeModelVars = TRUE, extraVarsToWrite = c("Year"));

# Look at the top rows of the two prediction data sets:
head(predict_linmod);
head(predict_dtree);
</pre>

- Now compare them. This is best done in this case with a series of scatterplots:

<pre>
# Plot the difference between actual and predicted values for both models to compare accuracy:
par(mfrow = c(2, 1));
plot(predict_linmod$RentalCount_Pred - predict_linmod$RentalCount, main = "Difference between actual and predicted. rxLinmod");
plot(predict_dtree$RentalCount_Pred - predict_dtree$RentalCount, main = "Difference between actual and predicted. rxDTree");
</pre>

- Which experiment had the best prediction?
- What hyperparameters can you change to affect the outcome?

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/thinking.jpg"><b>For Further Study</b></p>
 - Learn more about Feature Engineering and Modeling here: https://docs.microsoft.com/en-us/azure/machine-learning/team-data-science-process/lifecycle-modeling 