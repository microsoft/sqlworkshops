
## Course Introduction

# With Microsoft SQL Server 2016 we can do **in-database analytics** using the R programming language. In this tutorial we want to see examples of the kinds oof analytics R is good at and what it means to do the analytics in-database. We will look at the two architectures that SQL R Services uses and what they offer to the end user. We will also look at how the `RevoScaleR` package can be leveraged to do scalable big data analytics in multiple compute contexts.

## Two architectures

# As mentioned earlier, you have two options for using R code with SQL Server R Services. The first option is to use your local client to create R scripts that will call out to SQL Server R Services and use the compute and data resources on that system to obtain data, run the R code, and return the results to the local workstation. The second option is to include the R code in SQL Server stored procedures, which are stored and run on the SQL Server. Let's begin by making calls to SQL Server from the R IDE (the first architecture):

###########################################################
## Part 0: Installing packages
###########################################################

rxSetComputeContext(RxLocalSeq())
rm(list = ls())
# options("repos" = c(CRAN = "http://cran.r-project.org/"))
# install.packages('gridExtra')
library(gridExtra)
# install.packages('RODBC')
library(RODBC)
# install.packages('dplyr')
library(dplyr)
# install.packages('broom')
library(broom)
# install.packages('ggplot2')
library(ggplot2)

###########################################################
## Part 1: Taking data into SQL Server
###########################################################

# Let's begin by pointing to some data on our machine and taking it into SQL Server. For the most part, data is already sitting in a SQL Server database ready for us to read from, so this is not something that we would do regularly, but it's useful when we want to take a smaller data into SQL Server (assuming we have the permission to do that).

# Point to a text file (CSV) on the local file system
sample_data_path <- "C:/Program Files/Microsoft/R Server/R_SERVER/library/RevoScaleR/SampleData/"
csvFraudDS <- RxTextData(file.path(sample_data_path, 'ccFraudSmall.csv'))
file.exists(csvFraudDS@file)

# Create a variable for the SQL Server Connection String
sqlConnString <- "Driver=SQL Server;Server=.;Database=RDB;Uid=ruser;Pwd=ruser"
sqlRowsPerRead <- 100000 # number of rows processed during each iteration
sqlTable <- "FraudSmall" # name of resulting SQL table

# Point to (non-existant) data in SQL Server
sqlFraudDS <- RxSqlServerData(connectionString = sqlConnString, table = sqlTable, rowsPerRead = sqlRowsPerRead)

# Copy the CSV file to the SQL database
rxDataStep(csvFraudDS, sqlFraudDS, overwrite = TRUE)

# Query the new data and double check column types
rxGetInfo(sqlFraudDS, getVarInfo = TRUE, numRows = 10)

# Get summary statistics for the column called `state`
rxSummary( ~ state, data = sqlFraudDS)

###########################################################
## Part 2: Handling meta-data
###########################################################

# For the most part (though not always), data types in SQL map into the appropriate data types in R, but the one major exception are factor columns in R. A factor is a column that stores categorical data. It has levels (categories), what the levels are has  less to do with what's in the data and more to do with what's relevant to the analysis.

stateAbb <- c("AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DC", "DE",
              "FL", "GA", "HI", "IA", "ID", "IL", "IN", "KS", "KY",
              "LA", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT",
              "NB", "NC", "ND", "NH", "NJ", "NM", "NV", "NY", "OH",
              "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT",
              "VA", "VT", "WA", "WI", "WV", "WY")

ccColInfo <- list(
  gender = list(type = "factor",
                levels = c("1", "2"),
                newLevels = c("Male", "Female")),
  cardholder = list(type = "factor",
                    levels = c("1", "2"),
                    newLevels = c("Principal", "Secondary")),
  state = list(type = "factor",
               levels = as.character(1:51),
               newLevels = stateAbb),
  fraudRisk = list(type = "factor", levels = c('0', '1')))

sqlFraudDS <- RxSqlServerData(connectionString = sqlConnString, table = sqlTable, rowsPerRead = sqlRowsPerRead, colInfo = ccColInfo)

rxGetInfo(sqlFraudDS, getVarInfo = TRUE, numRows = 10)

# I we modify the ccColInfo object to contain only a subset of the states available in the data (the subset that we consider relevant to the analysis), then R will treat the remaining categories as NA (missing value). Different analysis functions treat missing values differently.

important_states <- sort(c('CA', 'IL', 'FL', 'NY', 'MI', 'WA', 'GA'))
ccColInfo$state$levels <- as.character(which(stateAbb %in% important_states))
ccColInfo$state$newLevels <- important_states
ccColInfo$state

sqlFraudDS <- RxSqlServerData(connectionString = sqlConnString, table = sqlTable, rowsPerRead = sqlRowsPerRead, colInfo = ccColInfo)

rxGetInfo(sqlFraudDS, getVarInfo = TRUE, numRows = 10)

###########################################################
## Part 3: Setting the SQL compute context
###########################################################

# Create a variable to store the data returned from the SQL Server
sqlShareDir <- paste("C:/temp/", Sys.getenv("USERNAME"), sep = "")
if(!file.exists(sqlShareDir)) dir.create(sqlShareDir, recursive = TRUE)
sqlWait <- TRUE
sqlConsoleOutput <- FALSE

# Create a compute context object that points to SQL Server
sqlCompute <- RxInSqlServer(connectionString = sqlConnString, shareDir = sqlShareDir, wait = sqlWait, consoleOutput = sqlConsoleOutput)

# Set the compute context to SQL Server, this means we can now do in-database analytics
rxSetComputeContext(sqlCompute)
rxGetComputeContext() # what is the current compute context?

# Create a second version of the compute context object that is better for debugging. We can change the compute context to this one when we need to 
sqlComputeTrace <- RxInSqlServer(connectionString = sqlConnString, shareDir = sqlShareDir, wait = sqlWait, consoleOutput = sqlConsoleOutput, traceEnabled = TRUE, traceLevel = 7)

###########################################################
## Part 4: How RevoScaleR functions are compute-context-aware
###########################################################

# RevoScaleR functions are compute-context-aware, meaning that setting the compute context and pointing to the remote data is all we have to do: the analysis functions in RevoScaleR will be called as they usually are, but depending on the compute context the computation might happen locally or remotely. Here's an example:

rxSetComputeContext(RxLocalSeq()) # local computation on one core

# Locally compute summary statistics for CSV data on the local file system
rxGetComputeContext() # double-check that compute context is local
rxSummary(~ gender + balance + numTrans + numIntlTrans + creditLine, csvFraudDS)

# Locally compute summary statistics for SQL data on the remote SQL Server. In this scenario, the data needs to travel to the local R session because the computation is happening locally
rxGetComputeContext() # double-check that compute context is local
rxSummary(~ gender + balance + numTrans + numIntlTrans + creditLine, sqlFraudDS)

# Remotely compute summary statistics for SQL data on the remote SQL Server. We now set the compute context to the remote SQL Server and perform the same computation, but this time the computation is happening remotely (i.e. in-database)
rxSetComputeContext(sqlCompute)
rxSummary(~ gender + balance + numTrans + numIntlTrans + creditLine, sqlFraudDS)

# Conclusion: `rxSummary` looks at (1) where is the data and (2) what is the compute context (CC). If data is local, then CC must also be local. If data is remote, then CC can still be local (for big data this is innefficient because of network IO) or the CC can be set to remote so that we can perform the computation in-database (now the data stays put, the computation travels to the data, the results of the computation travel back to the local R session).

# The same is true of all the other analysis functions in RevoScaleR: rxSummary, rxCube, rxCrossTabs, rxLinMod, rxLogit, rxDTree, rxDForest, etc.

###########################################################
## Part 5: Running some summaries
###########################################################

rxGetComputeContext()
sumOut <- rxSummary(formula = ~ gender + balance + numTrans + numIntlTrans + creditLine, data = sqlFraudDS)
sumOut

# We can use the rxQuantile function to compute percentiles for the numeric columns in the data and plot them in R using ggplot2.

# Compute the correlation between the four numeric columns
rxCor(~ balance + numTrans + numIntlTrans + creditLine, data = sqlFraudDS)

# Compute correlations on log transformations of the numeric columns, but perform the transformation in R
rxCor(~ balance + numTrans + numIntlTrans + creditLine, data = sqlFraudDS, 
      transforms = list(balance = log(balance+1),
                        numTrans = log(numTrans+1),
                        numIntlTrans = log(numIntlTrans+1),
                        creditLine = log(creditLine+1)))

# Compute correlations on log transformations of the numeric columns, but perform the transformation in SQL
sqlQuery <- 'select log(balance+1) as balance, log(numTrans+1) as numTrans, log(numIntlTrans+1) as numIntlTrans, log(creditLine+1) as creditLine from RDB.dbo.FraudSmall'
# Instead of pointing to a specific table in SQL (as was the case before), we now provide a query that will execute once we call `rxCor` (or any other analysis function). We do so by replacing the `table` argument with the `sqlQuery` argument in the function call below
sqlFraudDS_new <- RxSqlServerData(connectionString = sqlConnString, rowsPerRead = sqlRowsPerRead, colInfo = ccColInfo, sqlQuery = sqlQuery)

rxCor( ~ balance + numTrans + numIntlTrans + creditLine, data = sqlFraudDS_new)

# You can wrap the above two calls to `rxCor` inside system.time() to see which one runs faster. What is your guess?

# Take a random sample of the data, but start with the whole data in R (innefficient)
fraudSample <- rxDataStep(sqlFraudDS, 
                         transforms = list(u = runif(.rxNumRows)),
                         rowSelection = (u < .1))
# Plot a scatterplot matrix of these four columns for a sample of the data
num_vars <- c("balance", "numTrans", "numIntlTrans", "creditLine")
pairs(fraudSample[, num_vars])

# Take a random sample of the data, but sample the data in SQL and bring the sample into R (more efficient):
sqlFraudDS_sample <- RxSqlServerData(connectionString = sqlConnString,
                                  rowsPerRead = sqlRowsPerRead,
                                  colInfo = ccColInfo,
                                  sqlQuery = 'select top 10 percent * from RDB.dbo.FraudSmall order by newid()')
fraudSmall <- rxImport(sqlFraudDS_sample)
# Plot a scatterplot matrix of these four columns for a sample of the data
pairs(fraudSmall[ , num_vars])

# If we want more personalized plots, we need to use ggplot2
# Plot balance against creditLine, but color-code it by gender
library(ggplot2)
pl <- ggplot(aes(x = log(balance), y = log(creditLine), col = gender), data = fraudSmall)
pl <- pl + geom_point()
pl

# The above example is fine, but it gets better. With some rearranging, we can not only create the plot in-database but also store it directly inside a SQL table

scatterPlot <- function(inDataSource) {
  ds <- rxImport(inDataSource)
  require(ggplot2)
  pl <- ggplot(aes(x = log(balance), y = log(creditLine), col = gender), data = ds)
  pl <- pl + geom_point()
  return(list(myplot = pl))
}

# We can recreate our plot now, to make sure it works
scatterPlot(sqlFraudDS_sample)

# But more importantly, we can ask for this computation to be performed in-database

# For this to run `ggplot2` needs to be installed on the SQR R install. We need to launch Rgui.exe as an administrator, set the `.libPaths()` to be the location where libraries should go, and then install the package. This should usually be done by an admin, not by individual users.
rxSetComputeContext(sqlCompute)
myplots <- rxExec(scatterPlot, sqlFraudDS_sample, timesToRun = 1, packagesToLoad = 'ggplot2')
plot(myplots[[1]][["myplot"]])

###########################################################
## Part 6: Running some statistical tests
###########################################################

# There are certain RevoScaleR functions for running statistical tests, but the list is not exhaustive by any means, so what do we do when we need to run an R function not in RevoScaleR against data in SQL?

# The problem we have is that unlike RevoScaleR functions, other R functions are not compute-context-aware and they do not necessarily work with external data sources, only a `data.frame`. If the data is small we can always load it in the current R session as a data.frame:

fraudDF <- rxImport(sqlFraudDS)
x <- subset(fraudDF, gender == "Male", select = "balance")
y <- subset(fraudDF, gender == "Female", select = "balance")
t.test(x, y, conf.level = 0.99)

# In some cases, we may be lucky and use RevoScaleR to compute all the data points needed to perform the test, and then hard-code it ourselves:

sumOut <- rxSummary(formula = balance ~ gender, data = sqlFraudDS)
sumOut <- sumOut$categorical[[1]]
# We can manually compute the t-statistic using results found by `rxSummary`
# Source: https://en.wikipedia.org/wiki/Welch%27s_t-test
t_stat <- diff(sumOut$Means) / sqrt(sum(sumOut$StdDev^2 / sumOut$ValidObs))
t_stat

# But the above approach doesn't always work, although it is worth considering it because sometimes the size of the data is too large for us to perform the computation using non-RevoScaleR functions, as they don't always scale well.

# The right approach would be to perform the above computation in-database. To do so, we wrap the above code chunk into a function and pass that function to `rxExec`. `rxExec` is a RevoScaleR function and it is compute-context aware, so if the CC is set to remote (and the data is remote), it will run the computation remotely and return only the results.

t_test <- function(data) {
  bal_df <- rxImport(data)
  x <- subset(bal_df, gender == "Male", select = "balance")
  y <- subset(bal_df, gender == "Female", select = "balance")
  t.test(x, y, conf.level = 0.99)
}

# To be more efficient, we will limit the data to only the two columns we need
sqlFraudDS_subset <- sqlFraudDS
sqlFraudDS_subset@table <- NULL
sqlFraudDS_subset@sqlQuery <- 'select balance, gender from RDB.dbo.FraudSmall'
# Pass the computation to `rxExec` to run it remotely
t_test_res <- rxExec(t_test, data = sqlFraudDS_subset)
t_test_res 
t_test_res[[1]]$statistic

# We saw what a t-test can do, and combined with other R functions, we can do some nifty automation tasks with little effort

# Run a separate t-test for each state
library(dplyr)
library(broom)
fraudDF %>% 
  group_by(state) %>% 
  do(tidy(t.test(balance ~ gender, data = .))) %>%
  select(state, conf.low, conf.high)

# Same as above, but done in-database with the help of `rxExec`
t_test_by_state <- function(data) {
  bal_df <- rxImport(data)
  bal_df %>% 
    group_by(state) %>% 
    do(tidy(t.test(balance ~ gender, data = .))) %>%
    select(state, conf.low, conf.high)
}
# Pass the computation to `rxExec` to run it remotely
t_test_res <- rxExec(t_test_by_state, data = sqlFraudDS, packagesToLoad = c('dplyr', 'broom'))
t_test_res

# For more complicated cases, we may have to dynamically generate queries before we pass them to SQL, which is relatively easy in R (no special macro language is needed).

# Create a `t_test` function to compare each state with each other state
t_test_bw_states <- function(data, left, right) {
  lidx <- which(stateAbb == left)
  ridx <- which(stateAbb == right)
  data_subset <- data
  data_subset@table <- NULL
  data_subset@sqlQuery <- sprintf("select state, balance from RDB.dbo.FraudSmall where state = %s or state = %s", lidx, ridx)
  bal_df <- rxImport(data_subset)
  x <- subset(bal_df, state == left, select = "balance")
  y <- subset(bal_df, state == right, select = "balance")
  list(left = left, right = right, t.test(x, y, conf.level = 0.99))
}

# Example (local)
t_test_bw_states(sqlFraudDS, left = "CA", right = "FL")
# Example (remote)
rxExec(t_test_bw_states, data = sqlFraudDS, left = "CA", right = "FL", execObjects = "stateAbb")

# Find all the combinations of pairs of states and run the above function on them
xy <- combn(important_states, 2)
t_test_res <- rxExec(t_test_bw_states, data = sqlFraudDS, left = rxElemArg(xy[1, ]), right = rxElemArg(xy[2, ]), execObjects = "stateAbb")
t_test_res

###########################################################
## Part 7: Modeling and scoring example
###########################################################

# Let's take another look at the data
rxGetInfo(sqlFraudDS, numRows = 10)
rxSummary(~ fraudRisk, data = sqlFraudDS)

# Build a logistic regression model that predicts fraudRisk using balance and creditLine
modlogit <- rxLogit(fraudRisk ~ balance + creditLine, data = sqlFraudDS)
summary(modlogit)

# To understand how the model is predicting, let's generate a data.frame with a range of values for balance and creditLine
pred_df <- expand.grid(list(balance = seq(0, 10000, 1000), creditLine = seq(0, 100, 20)))
head(pred_df, 50)
# We can now pass the model to `rxPredict` to make predictions (in this case, the probability of being a creditRisk). Because we are doing this computation locally, we need to set the CC back to local.
rxSetComputeContext(RxLocalSeq())
pred_df <- rxPredict(modlogit, pred_df, writeModelVars = TRUE)
head(pred_df, 50)

# Visualize the predictions to see the effect of balance and creditLine on the predictions
library(ggplot2)
ggplot(aes(x = balance, y = fraudRisk_Pred, col = as.factor(creditLine)), data = pred_df) + 
  geom_line(size = 1)

# How do we persist this model?
# The not-SQL way would be to save it on the local file system
save(modlogit, file = 'modlogit.RData')
# To retrieve it we can then use the load object
load(file = 'modlogit.RData')

# Using `rxExec` we could save the file remotely, but we would need to have write permission to the file system of the VM host (probably a bad idea)
# So here's the right way of doing it:
modelbin <- serialize(modlogit, NULL)
modelbinstr <- paste(modelbin, collapse = "")

# Persist model by calling a stored procedure from SQL
library(RODBC)
odbcCloseAll()
conn <- odbcDriverConnect(sqlConnString)
q <- paste("EXEC PersistModel @m='", modelbinstr, "'", sep = "")
sqlQuery(conn, q)

# Set the compute context back to SQL Server so we can now predict for all the cases in the data
rxSetComputeContext(sqlCompute)
sqlFraudScoresDS <- sqlFraudDS
sqlFraudScoresDS@table <- "FraudScores"

rxPredict(modlogit, data = sqlFraudDS, outData = sqlFraudScoresDS, overwrite = TRUE, writeModelVars = TRUE)
