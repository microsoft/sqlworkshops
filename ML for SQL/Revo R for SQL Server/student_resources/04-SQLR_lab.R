
airline_xdf <- RxXdfData('C:/Program Files/Microsoft/R Client/R_SERVER/library/RevoScaleR/SampleData/AirlineDemoSmall.xdf')

# problem 1:
# copy the above dataset (XDF) into SQL Server
# point to the data in R, making sure that DayOfWeek is a factor column but only specify week days as valid factor levels

# problem 2:
# build a linear model that predicts arrival delay based on the other two columns
# usually we would split the data into training and test set, but we can skip that here as we're not interested in validating our model
# make sure that the model is built in-database

# problem 3:
# score the following data with the model created above:
score_data <- expand.grid(list(DayOfWeek = five_days, CRSDepTime = 5:23))

# problem 4:
# here's how we can visualize the predictions by plotting delay against departure time for each day of the week
library(ggplot2)
ggplot(aes(x = CRSDepTime, y = PredictedDelay, col = DayOfWeek), data = score_data) + 
  geom_line()
# what can you say about predicted delay? do the predictions seem realistic?

# problem 5:
# how can we improve the model
# 1. why should the relationship between delay and departure time be linear
#    so use polynomial regression with a squared term for hour of the day
#    here's the formula: ArrDelay ~ CRSDepTime + I(CRSDepTime ^ 2) + DayOfWeek
# 2. why should the effect of the day of the week be only and upward or downward shift regardless of time of day?
#    so look at interaction of day of week and departure time instead
#    here's the formula: ArrDelay ~ CRSDepTime + CRSDepTime*DayOfWeek
# 3. combine the above two effects to build a new model that incorporates both

# problem 6:
# with the new model created in the last step
# visualize the predictions by plotting delay against departure time for each day of the week
# what can you say about predicted delay? do the predictions seem realistic?

# problem 7:
# save (insert) the new model object in a SQL Server table (as a serialzed object)

# problem 8:
# score the original data with the model created in the last step
# you can either do so in T-SQL or within R












# solutions

airline_xdf <- RxXdfData('C:/Program Files/Microsoft/R Client/R_SERVER/library/RevoScaleR/SampleData/AirlineDemoSmall.xdf')

# solution to problem 1:
# copy the above dataset (XDF) into SQL Server
# point to the data in R, making sure that DayOfWeek is a factor column but only specify week days as valid factor levels

SQLSERVERNAME <- "MININT-1NA9NJM"
sqlConnString <- sprintf("Driver=SQL Server;Server=%s;Database=RDB;Uid=ruser;Pwd=ruser", SQLSERVERNAME)
sqlRowsPerRead <- 100000
sqlTable <- "AirlineSmall"

airline_sql <- RxSqlServerData(connectionString = sqlConnString,
                           rowsPerRead = sqlRowsPerRead, 
                           table = sqlTable)


rxDataStep(airline_xdf, airline_sql, overwrite = TRUE)

rxGetInfo(airline_sql, getVarInfo = TRUE)

five_days <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")
ccColInfo <- list(DayOfWeek = list(type = "factor", levels = five_days))
airline_sql <- RxSqlServerData(connectionString = sqlConnString, rowsPerRead = sqlRowsPerRead,
                               table = sqlTable, colInfo = ccColInfo)

rxGetInfo(airline_sql, getVarInfo = TRUE)

# solution to problem 2:

# build a linear model that predicts arrival delay based on the other two columns
# usually we would split the data into training and test set, but we can skip that here as we're not interested in validating our model
# make sure that the model is built in-database

sqlShareDir <- paste("C:/AllShare/", Sys.getenv("USERNAME"), sep = "")
sqlWait <- TRUE
sqlConsoleOutput <- TRUE
sqlCC <- RxInSqlServer(connectionString = sqlConnString, shareDir = sqlShareDir,
                       wait = sqlWait, consoleOutput = sqlConsoleOutput)
rxSetComputeContext(sqlCC)

system.time(
  rxlm <- rxLinMod(ArrDelay ~ CRSDepTime + DayOfWeek, data = airline_sql)
)
summary(rxlm)

# solution to problem 3:
# score the following data with the model created above:

score_data <- expand.grid(list(DayOfWeek = five_days, CRSDepTime = 5:23))
rxSetComputeContext(RxLocalSeq())
score_data <- rxPredict(rxlm, data = score_data, writeModelVars = TRUE, 
          predVarNames = "PredictedDelay", overwrite = TRUE)

# solution to problem 4:

library(ggplot2)
ggplot(aes(x = CRSDepTime, y = PredictedDelay, col = DayOfWeek), data = score_data) + 
  geom_line()

# solution to problem 5:
# how can we improve the model
# 1. why should the relationship between delay and departure time be linear
#    so use polynomial regression with a squared term for hour of the day
#    here's the formula: ArrDelay ~ CRSDepTime + I(CRSDepTime ^ 2) + DayOfWeek

rxSetComputeContext(sqlCC)
system.time(
  rxlm1 <- rxLinMod(ArrDelay ~ CRSDepTime + I(CRSDepTime ^ 2) + DayOfWeek, data = airline_sql)
)

score_data <- expand.grid(list(DayOfWeek = five_days, CRSDepTime = 5:23))
rxSetComputeContext(RxLocalSeq())
score_data <- rxPredict(rxlm1, data = score_data, writeModelVars = TRUE, 
                        predVarNames = "PredictedDelay", overwrite = TRUE)

library(ggplot2)
ggplot(aes(x = CRSDepTime, y = PredictedDelay, col = DayOfWeek), data = score_data) + 
  geom_line()

# 2. why should the effect of the day of the week be only and upward or downward shift regardless of time of day?
#    so look at interaction of day of week and departure time instead
#    here's the formula: ArrDelay ~ CRSDepTime + CRSDepTime*DayOfWeek

rxSetComputeContext(sqlCC)
system.time(
  rxlm2 <- rxLinMod(ArrDelay ~ CRSDepTime + CRSDepTime:DayOfWeek, data = airline_sql)
)

score_data <- expand.grid(list(DayOfWeek = five_days, CRSDepTime = 5:23))
rxSetComputeContext(RxLocalSeq())
score_data <- rxPredict(rxlm2, data = score_data, writeModelVars = TRUE, 
                        predVarNames = "PredictedDelay", overwrite = TRUE)

library(ggplot2)
ggplot(aes(x = CRSDepTime, y = PredictedDelay, col = DayOfWeek), data = score_data) + 
  geom_line()

# 3. combine the above two effects to build a new model that incorporates both

rxSetComputeContext(sqlCC)
system.time(
  rxlm3 <- rxLinMod(ArrDelay ~ CRSDepTime + I(CRSDepTime ^ 2) + CRSDepTime:DayOfWeek, data = airline_sql)
)

# solution to problem 6:
# with the new model created in the last step
# visualize the predictions by plotting delay against departure time for each day of the week
# what can you say about predicted delay? do the predictions seem realistic?

score_data <- expand.grid(list(DayOfWeek = five_days, CRSDepTime = 5:23))
rxSetComputeContext(RxLocalSeq())
score_data <- rxPredict(rxlm3, data = score_data, writeModelVars = TRUE, 
                        predVarNames = "PredictedDelay", overwrite = TRUE)

library(ggplot2)
ggplot(aes(x = CRSDepTime, y = PredictedDelay, col = DayOfWeek), data = score_data) + 
  geom_line()

# solution to problem 7:
# save (insert) the new model object in a SQL Server table (as a serialzed object)

modelbin <- serialize(rxlm, NULL)
modelbinstr <- paste(modelbin, collapse = "")

library(RODBC)
odbcCloseAll()
conn <- odbcDriverConnect(sqlConnString)
q <- paste("EXEC PersistModel @m='", modelbinstr, "'", sep = "")
sqlQuery(conn, q)

# solution to problem 8:
# score the original data with the model created in the last step
# you can either do so in T-SQL or within R

rxSetComputeContext(sqlCC)
sqlTable <- "AirlineScores"

airline_score <- RxSqlServerData(connectionString = sqlConnString,
                                 rowsPerRead = sqlRowsPerRead, 
                                 table = sqlTable)

rxPredict(rxlm3, data = airline_sql, outData = airline_score, writeModelVars = TRUE, 
          predVarNames = "PredictedDelay", overwrite = TRUE)

