# 03_WorkingWithData.py
# Purpose: Exercise files for Python for Data Professionals course, section 3
# Author: Buck Woody
# Credits and Sources: Inline
# Last Updated: 02 July 2018

# <TODO> - 3.1 Data Types

# Create a variable called MyName and set it to your name. 
# Print out the middle two letters of the variable:

# Create a new variable of a 3-digit number. Print out the data type for the variable:

# Change the previous variable to text. Print the data type for the variable:

# Create a list structure with three numbers in it, add two of the numbers, print the result:

# Create a Dictionary structure with three values using keys of 1, 2 and 3.
# Query for the value of key 2:

# <TODO> - 3.1a NumPy Exercises
# Create a NumPy 1-dimensional array consisting of three numbers.
# Sum those numbers. 
# Add three more numbers as an additional dimension to the array.
# Sum the two dimensions over the rows.
# Sum the two dimensions over the columns:


# <TODO> - 3.1b Pandas Exercises
# Use the Pandas library, and alias it as pd:

# Show the first five values of long_series:
long_series = pd.Series(np.random.randn(1000))

# Read the file CATelcoCustomerChurnTrainingSample.csv from the ./data directory
# into a Pandas Data Frame:

# Explore the Data Frame you just created with Pandas:

# <TODO> - 3.2 Data Ingestion
# Read customer data from the ./data/CATelcoCustomerChurnTrainingSample.csv
# into a data frame called df using pandas:

# Show the Data in the Data Frame:

# <TODO> - 3.3 Data Inspection
# Ensure that you have 29 columns and 20,468 rows loaded
print('There should be 20468 observations of 29 variables:')

# Explore the df Dataframe, using at least a five-number statistical summary.
# NOTE: Your exploration may be much different - you will show this data
# using graphs in the next exercise. 

# Show the size and shape of the data:

# Show the first and last 10 rows:

# Show the dataframe structure:

# Check for missing values:
print('Missing values: ', '\n')

# perform a simple statistical display:    
print('Dataframe Statistics: ', '\n')

# <TODO> - 3.4 Graphing
# Using any graphical library or representation you like, create three separate graphs
# that best illustrate the data layout of the dataframe you just created:

# <TODO> - 3.5 Machine Learning and AI
# Review the following code, observing what it does. 

# 1 - Setup - Get everything up to date, and add any pips you want here
# Import Libraries for the Customer Churn Prediction Labs - Change for other uses

# Serializing output/input
import pickle

# Libraries for training and scoring
from sklearn.naive_bayes import GaussianNB
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder

# Data and Numeric Manipulation
import pandas as pd
import numpy as np

# Working with files
import csv

#/ 1 - Setup 

#2 - Read data and verify
# Read customer data from a single file
df = pd.read_csv('./data/CATelcoCustomerChurnTrainingSample.csv') 

# Ensure that you have 29 columns and 20,468 rows loaded
print('There should be 20468 obervations of 29 variables:')
print(df.shape, '\n')

# Optional - Instead, read the data from source:
# https://github.com/Azure/MachineLearningSamples-ChurnPrediction/blob/master/data/CATelcoCustomerChurnTrainingSample.csv 
#/ 2 - Read Data

# 2.1 - Explore Data
# Explore the df Dataframe, using at least a five-number statistical summary.
# NOTE: Your exploration may be much different - experiment with graphics as well.

# Show the size and shape of data:
print('The size of the data is: %d rows and  %d columns' % df.shape, '\n')

# Show the first and last 10 rows
print('First ten rows of the data: ')
print(df.head(10), '\n')
print('Last ten rows of the data: ')
print(df.tail(10), '\n')

# Show the dataframe structure:
print('Dataframe Structure: ', '\n')
print(df.info(), '\n')

# Check for missing values:
print('Missing values: ', '\n')
print(df.apply(lambda x: sum(x.isnull()),axis=0), '\n') 

# perform a simple statistical display:    
print('Dataframe Statistics: ', '\n')
print(df.describe(), '\n')

#/ 2.1

# 3.0 - Customer Churn Prediction Experiment
# For completeness of this example, let's re-import our libraries
import pickle
import pandas as pd
import numpy as np
import csv
from sklearn.naive_bayes import GaussianNB
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder

# We'll re-load the data as "CustomerDataFrame"
CustomerDataFrame = pd.read_csv('data/CATelcoCustomerChurnTrainingSample.csv')

# Fill all NA values with 0:
CustomerDataFrame = CustomerDataFrame.fillna(0)

# Drop all duplicate observations:
CustomerDataFrame = CustomerDataFrame.drop_duplicates()

# We don't need the 'year" or 'month' variables
CustomerDataFrame = CustomerDataFrame.drop('year', 1)
CustomerDataFrame = CustomerDataFrame.drop('month', 1)

# Implement One-Hot Encoding for this model (https://machinelearningmastery.com/why-one-hot-encode-data-in-machine-learning/) 
columns_to_encode = list(CustomerDataFrame.select_dtypes(include=['category','object']))
dummies = pd.get_dummies(CustomerDataFrame[columns_to_encode]) #

# Drop the original categorical columns:
CustomerDataFrame = CustomerDataFrame.drop(columns_to_encode, axis=1) # 

# Re-join the dummies frame to the original data:
CustomerDataFrame = CustomerDataFrame.join(dummies)

# Show the new columns in the joined dataframe:
print(CustomerDataFrame.columns, '\n')

# Experiment using Naive Bayes:
nb_model = GaussianNB()
random_seed = 42
split_ratio = .3
train, test = train_test_split(CustomerDataFrame, random_state = random_seed, test_size = split_ratio)

target = train['churn'].values
train = train.drop('churn', 1)
train = train.values
nb_model.fit(train, target)

expected = test['churn'].values
test = test.drop('churn', 1)
predicted = nb_model.predict(test)

# Print out the Naive Bayes Classification Accuracy:
print("Naive Bayes Classification Accuracy", accuracy_score(expected, predicted))

# Experiment using Decision Trees:
dt_model = DecisionTreeClassifier(min_samples_split=20, random_state=99)
dt_model.fit(train, target)
predicted = dt_model.predict(test)

# Print out the Decision Tree Accuracy:
print("Decision Tree Classification Accuracy", accuracy_score(expected, predicted))

#/ 3.0

# 4.0a - Create the Model File
# serialize the best performing model on disk
print ("Serialize the model to a model.pkl file in the root")
ModelFile = open('./model.pkl', 'wb')
pickle.dump(dt_model, ModelFile)
ModelFile.close()
#/ 4.0a

# 4.0b - Operationalization: Scoring the calls to the model
# Prepare the web service definition before deploying
# Import for the pickle
from sklearn.externals import joblib

# load the model file
global model
model = joblib.load('model.pkl')

# Import for handling the JSON file
import json
import pandas as pd

# Set up a sample "call" from a client:
input_df = "{\"callfailurerate\": 0, \"education\": \"Bachelor or equivalent\", \"usesinternetservice\": \"No\", \"gender\": \"Male\", \"unpaidbalance\": 19, \"occupation\": \"Technology Related Job\", \"year\": 2015, \"numberofcomplaints\": 0, \"avgcallduration\": 663, \"usesvoiceservice\": \"No\", \"annualincome\": 168147, \"totalminsusedinlastmonth\": 15, \"homeowner\": \"Yes\", \"age\": 12, \"maritalstatus\": \"Single\", \"month\": 1, \"calldroprate\": 0.06, \"percentagecalloutsidenetwork\": 0.82, \"penaltytoswitch\": 371, \"monthlybilledamount\": 71, \"churn\": 0, \"numdayscontractequipmentplanexpiring\": 96, \"totalcallduration\": 5971, \"callingnum\": 4251078442, \"state\": \"WA\", \"customerid\": 1, \"customersuspended\": \"Yes\", \"numberofmonthunpaid\": 7, \"noadditionallines\": \"\\\\N\"}"

# Cleanup 
input_df_encoded = json.loads(input_df)
input_df_encoded = pd.DataFrame([input_df_encoded], columns=input_df_encoded.keys())
input_df_encoded = input_df_encoded.drop('year', 1)
input_df_encoded = input_df_encoded.drop('month', 1)
input_df_encoded = input_df_encoded.drop('churn', 1)

# Pre-process scoring data consistent with training data
columns_to_encode = ['customersuspended', 'education', 'gender', 'homeowner', 'maritalstatus', 'noadditionallines', 'occupation', 'state', 'usesinternetservice', 'usesvoiceservice']
dummies = pd.get_dummies(input_df_encoded[columns_to_encode])
input_df_encoded = input_df_encoded.join(dummies)
input_df_encoded = input_df_encoded.drop(columns_to_encode, axis=1)

columns_encoded = ['age', 'annualincome', 'calldroprate', 'callfailurerate', 'callingnum',
       'customerid', 'monthlybilledamount', 'numberofcomplaints',
       'numberofmonthunpaid', 'numdayscontractequipmentplanexpiring',
       'penaltytoswitch', 'totalminsusedinlastmonth', 'unpaidbalance',
       'percentagecalloutsidenetwork', 'totalcallduration', 'avgcallduration',
       'customersuspended_No', 'customersuspended_Yes',
       'education_Bachelor or equivalent', 'education_High School or below',
       'education_Master or equivalent', 'education_PhD or equivalent',
       'gender_Female', 'gender_Male', 'homeowner_No', 'homeowner_Yes',
       'maritalstatus_Married', 'maritalstatus_Single', 'noadditionallines_\\N',
       'occupation_Non-technology Related Job', 'occupation_Others',
       'occupation_Technology Related Job', 'state_AK', 'state_AL', 'state_AR',
       'state_AZ', 'state_CA', 'state_CO', 'state_CT', 'state_DE', 'state_FL',
       'state_GA', 'state_HI', 'state_IA', 'state_ID', 'state_IL', 'state_IN',
       'state_KS', 'state_KY', 'state_LA', 'state_MA', 'state_MD', 'state_ME',
       'state_MI', 'state_MN', 'state_MO', 'state_MS', 'state_MT', 'state_NC',
       'state_ND', 'state_NE', 'state_NH', 'state_NJ', 'state_NM', 'state_NV',
       'state_NY', 'state_OH', 'state_OK', 'state_OR', 'state_PA', 'state_RI',
       'state_SC', 'state_SD', 'state_TN', 'state_TX', 'state_UT', 'state_VA',
       'state_VT', 'state_WA', 'state_WI', 'state_WV', 'state_WY',
       'usesinternetservice_No', 'usesinternetservice_Yes',
       'usesvoiceservice_No', 'usesvoiceservice_Yes']

# Now that they are encoded, some values will be "empty". Fill those with 0's:
for column_encoded in columns_encoded:
    if not column_encoded in input_df_encoded.columns:
        input_df_encoded[column_encoded] = 0

# Return final prediction
pred = model.predict(input_df_encoded)

# (In production you would replace Print() statement here with some sort of return to JSON)
print('JSON sent to the prediction Model:', '\n')
print(input_df, '\n')
print('For the JSON string sent from the client, The prediction is returned as more JSON (0 = No churn, 1 = Churn):', '\n')
print(json.dumps(str(pred[0])))

#/ 4.0b

# EOF: 03_WorkingWithData.py