SQL Server R Services Workshop
======================================

Welcome to the SQL Server R Services Repository. You can find the latest materials from the workshop here. This course is intended for data scientists and SQL analysts interested in the R Services feature that was released with SQL Server 2016. We review the two [common architectures](https://msdn.microsoft.com/en-us/library/mt604885.aspx) that R and SQL Server use to communicate with each other. We see how we can do in-database analytics directly from our favorite R IDE (Visual Studio with RTVS or RStudio). We see how Microsoft R's `RevoScaleR` package can help us scale the analytics when the data is large. We examine different use cases and in the process of implementing them we learn about some best practices to follow to take full advantage of both SQL Server and R.

You will find all the rendered course content in `student_resources`. If you wish to run the code you can open the Rmd files in `instructor_resources` in your R IDE.

## Class Links

+ [gitter page](https://gitter.im/sqlrservices)
    * We use gitter as a discussion forum for anything related to the course materials, or Microsoft R more generally.

+ [R and Data Optimization (R Services)](https://msdn.microsoft.com/en-us/library/mt723575.aspx)

+ [SQL Server R Services Performance Tuning](https://msdn.microsoft.com/en-us/library/mt723573.aspx)

+ [Model management with SQL Server R Services](https://blogs.technet.microsoft.com/dataplatforminsider/2016/10/17/sql-server-as-a-machine-learning-model-management-system/)

+ [Displaying R plots in SSRS](https://www.mssqltips.com/sqlservertip/4127/sql-server-2016-r-services-display-r-plots-in-reporting-services/)


## Course Outline

In this course we learn the two ways that SQL R Services can be invoked one from the R IDE via the ScaleR package; and as a stored procedure directly from SQL Server Management Studio. We learn how either scenario works and what is the intended use-case. We also learn R programming best practices to follow when working against data stored in SQL Server databases.

### About the Course

Fetching data from a relational database such as SQL Server is not new to R. Through ODBC connection, R users can connect to a database and load data into an R session. However, ODBC connections are notoriously slow, especially when the data has to travel over the network (network IO). Moreover transferring data like this can often expose it to security vulnerabilities.

With SQL R Services, R users now have the ability to do their analytics in-database. That is to say that we take the analytics (R code) to the data instead of the other way around. Moreover, with Microsoft R Server's RevoScaleR package, the data scientist can develop and run all of their code from the comfort of their R IDE. Once the code is ready for deployment, it can then be turned into a stored procedure which other applications call at will.

In this course we delve into the details of the SQL Server R Services architecture, run example codes and learn R programming best practices to follow. We see how the RevoScaleR package and its data-processing and analytics functions can give us a best-of-both-worlds advantage, but also how to send any R code to run in-database. We learn how to use SQL Server to store R artifacts (such as model objects) and retrieve them later by R stored procedures (scoring new data with an R model) or SSRS (for rendering an R plot in a report).

## Course Prerequisites

 - Familiarity with R is helpful, but not required, as we run through the R code without too much explanation but R code can still look pretty straightforward and easy to follow to the novice.
 - Familiarity with the RevoScaleR package is a plus, and in particular its distributed data processing and analytics functions, but we only cover a few examples.
 - Basic knowledge of SQL Server administration and familiarity with the SQL language is required.

There are a few things you will need in order to properly follow the course materials:

 - Have SQL Server 2016 Developer with Service Pack 1 (Release date 11/15/2016) installed.
 - Have SSRS installed along with [Report Builder](https://aka.ms/x56pr9)
 - Download and install the [Microsoft R Client](http://aka.ms/rclient/download)

Download and install one of the following (technically optional but highly recommended):

 - Visual Studio with [R Tools](https://aka.ms/rtvs-current)
 - [RStudio Desktop](http://www.rstudio.com/products/rstudio/download/)

Since the release of Microsoft R Server version 9 and until it comes bundled with the SQL R Services release, we need to upgrade our instance of R Services manually. If you wish to have SQL Server running on your personal laptops (not required) to run these examples, here's instructions to do so. You will need to have an MSDN account to download and install the following items. Links are not provided.

 - Install **SQL Server 2016 SP1**
 - Install **Cumulative Updates 1 (KB3208177)** by running `SQLServer2016-KB3208177-x64.exe`
 - Install **Microsoft R Server for Windows** by running `en_r_server_901_for_windows_x64_9649035.exe`
 - Bind the R server instance to the R Services instance by running cmd as administator and doing the following:

    ```
    > cd C:\Program Files\Microsoft\R Server\Setup
    > SqlBindR.exe /list
    > # copy the name of your SQL Server 2016 instance and past below
    > SqlBindR.exe /bind SQLSERVER
    ```
