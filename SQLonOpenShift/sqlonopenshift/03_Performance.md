![](../graphics/microsoftlogo.png)

# Workshop: SQL Server on OpenShift

#### <i>A Microsoft workshop from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/textbubble.png"> <h2>SQL Server Performance</h2>

You'll cover the following topics in this Module:

<dl>

  <dt><a href="#3-0">3.0 SQL Server Intelligent Query Processing</a></dt>
  
</dl>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="3-0">3.0 SQL Server Intelligent Query Processing</a></h2>

In this module you will learn about the Intelligent Query processing capabilities new to SQL Server 2019. You will use activities to learn these concepts against the SQL Server container you have deployed in OpenShift. This demonstrates the compatibility of the SQL Server engine across multiple platforms as this entire module could be used against SQL Server 2019 running on Windows, Linux, and containers.

Intelligent Query processing is a suite of features built into the query processor for SQL Server 2019 allowing developers and data professionals to accelerate database performance automatically without any application changes. T-SQL queries simply need to be run with a database compatibility level of 150 to take advantage of these enhancements.

You can read more about database compatibility at https://docs.microsoft.com/en-us/sql/t-sql/statements/alter-database-transact-sql-compatibility-level?view=sql-server-2017#compatibility-levels-and-sql-server-upgrades.

The following is a diagram showing the features of Intelligent Query Processing including capabilities from SQL Server 2017

![iqp diagram](../graphics/IQP_diagram.png)

You can read the documentation for a description and example of all of these features at https://docs.microsoft.com/en-us/sql/relational-databases/performance/intelligent-query-processing

**Note**: One of the features of Intelligent Query Processing, approximate count distinct, does not require database compatibility of 150.

Proceed to the Activity to learn an example of how Intelligent Query Processing can accelerate query performance automatically with no application changes.

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b><a name="aks">Activity: SQL Server Intelligent Query Processing</a></b></p>

Follow these steps to learn more about SQL Server Intelligent Query Processing. **Note**: this module assumes you have completed all the steps in Module 01 and 02.

In this activity, you will learn how to use the built-in capabilities of Intelligent Query Processing in SQL Server 2019 simply by changing the database compatibility of WideWorldImporters to version 150 with no application changes.

You have been provided a stored procedure called **CustomerProfits** which you will deploy in the **Facts** schema of the WideWorldImporters database. The stored procedure uses a concept called a table variable to store interim results from a user table and then use that table variable to join with other data in the WideWorldImporters database. In past releases of SQL Server, this design pattern can be a problem as SQL Server would always estimate the table variable only contains 1 row of data. This can cause issues with building the optimal query plan for fast performance. 

SQL Server 2019 Intelligent Query Processing includes a capability called deferred table variable compilation to improve the performance of stored procedures like these by ensuring the stored procedure is created in a database with a compatibility level of 150, which is the default for SQL Server 2019.

The WideWorldImporters database example was created with SQL Server 2016 which had a default database compatibility level of 130. When a database is restored from a previous version oF SQL Server, the compatibility level of the database is preserved to help reduce the risk of upgrades.

You will observe the performance of the CustomerProfits stored procedure with database compatibility level of 130 on SQL Server 2019. You will the compare the performance of the same procedure with no changes with the database compatibility of 150 which will enable the query processor to use deferred table variable compilation.

You will be running a series of SQL Server T-SQL statements to observe performance. You have two choices to run the T-SQL statements with the Azure Data Studio tool:

- Use the T-SQL scripts provided
- Use the new SQL notebook experience which will walk you through each step.

The first step  is to find the SQL Server connection information.

1. To connect to the SQL Server deployed on OpenShift, run the following command to get the IP address and port of the Load Balancer service associated with the SQL Server container

    `oc get service mssql-service`

    You should see results like the following

    <pre>NAME            TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)           AGE
    mssql-service   LoadBalancer   172.30.166.56   168.61.45.217   31433:30738/TCP   1h</pre>

    Take note of the EXTERNAL-IP and PORT. You will use these to connect to SQL Server

2. Launch the Azure Data Studio application. Look for the icon

    <p><img style="margin: 0px 30px 15x 0px;" src="../graphics/azure_data_studio_icon.png" width="50" height="50">

3. The first time you launch Azure Data Studio, you may see the following choices. For the purposes of this workshop, select No to not load the preview feature and use x to close out the 2nd choice to collect usage data
    
    <p><img style="margin: 0px 30px 15x 0px;" src="../graphics/ADS_initial_prompts.jpg" width="250" height="150">

4. You will now be presented with the following screen to enter in your connection details for SQL Server. For Server, put in the values for EXTERNAL IP, PORT from step 1 above. Change the Authentication type to SQL Login, Put in a User name of sa with the Password you used for the secret in Module 01 when you deployed SQL Server. I also recommend you click the checkbox for Remember Password so you will not have to do it again for future connections. Click the Connect button to connect. An example of a connection looks like the following

    <p><img style="margin: 0px 30px 15x 0px;" src="../graphics/Azure_Data_Studio_Connect.jpg" width="300" height="350">

5. A successful connection should look like the following

    ![Azure Data Studio Successful Connection](../graphics/Azure_Data_Studio_Successful_Connect.jpg)

    At this point, you can complete this activity through a step by step approach with different query scripts or use a concept called SQL notebooks

    To use the SQL notebook approach, use the following steps. Otherwise, skip to step 7.

6. For SQL notebooks, use the File menu of Azure Data Studio (Open File option) to open the **03_Performance.ipynb** notebook in the **sqlworkshops/SQLOnOpenShift/sqlonopenshift/iqp/03_performance** folder. Follow the steps provided in the notebook to complete the activity.

    The SQL notebook experience looks like the following:

    TODO: Put in screenshot of notebook experience

    If you wan to run each script in the Activity in the Query Editor to observe the performance of the stored procedure, use the following steps.

7. Open the script **proc.sql** by using the File Menu/Open File option of Azure Data Studio. The file can be found in the **sqlworkshops/SQLonOpenShift/sqlonopenshift/03_performance/iqp** folder

    This SQL script defines a stored procedure to calculate the total profits per customer for the WideWorldImporters company through a stored procedure. In this stored procedure, the logic queries data from a table, Sales.InvoiceLInes and stores it into temporary storage called a table variable. Then the procedure will join this data to tables in the database to produce the result. The T-SQL query uses aggregrate functionality to provide the count of customers and sum of profits grouped by customer.

    Click the Run button to execute the script. You will be prompted to pick the connection to execute the script. Select the connection you created in Step 4.

    When you execute this script the results should look like the following

    ![proc created results](../graphics/proc_created_results.jpg)

8. You have been told this procedure executes fairly quickly with a single execution in a few seconds but over several iterations the total duration, over 20 seconds, is not acceptable to the application.

    Open the script **repro130.sql** by using the File Menu/Open File option of Azure Data Studio. The file can be found in the **sqlworkshops/SQLonOpenShift/sqlonopenshift/03_performance/iqp** folder.

    The script looks like the following


    ```sql
    USE master
    GO
    ALTER DATABASE wideworldimporters SET compatibility_level = 130
    GO
    USE WideWorldImporters
    GO
    SET NOCOUNT ON
    GO
    EXEC [Sales].[CustomerProfits]
    GO 25
    SET NOCOUNT OFF
    GO
    ```
    The script will ensure the database is in a compatability mode that is less than 150 so Intelligent Query Processing will NOT be enabled. The script also turns off rowcount messages to be returned to the client to reduce network traffic for this test. Then the script executes the stored procedure. Notice the sytnax of **GO 25**. This is a client tool tip that says to run the batch 25 times (avoids having to construct a loop)

    Click the Run button to execute the script to observe the results. Choose the connection you created for the SQL Server container and click Connect.

    You will see while the query is executing in the bottom status bar the current elapsed execution time, the server connection details, a status of **Executing Query**, and number of rows being returned to the client.

    ![Azure Data Studio Status Bar](../graphics/Azure_Data_Studio_Status_Bar.jpg)

    The query should complete in well over 30 seconds. Given result sets are being sent back to the client, it can take even longer depending on connectivity speeds of your client workstation.

    The final results of Azure Data Studio should look like this

    ![repro 130 results](../graphics/repro_130_results.jpg)

    You can scroll in the RESULTS or MESSAGES pane. If you scroll down to the bottom of the MESSAGES pane, you can see the total execution time (this includes time to execute the stored procedure 25 times on the server but also return results to the client). Your results should look something like this (30 seconds or greater)

    ![repro 130 duration](../graphics/repro_130_duration.jpg)

9. Now let's run the same exact test but with database compatibility of 150. You will not make any changes to the stored procedure.

    Open the script **repro150.sql** by using the File Menu/Open File option of Azure Data Studio. The file can be found in the **sqlworkshops/SQLonOpenShift/sqlonopenshift/03_performance/iqp** folder.

    Use the SQL container connection as you have done in previous steps. The script should look like this


    ```sql
    SE master
    GO
    ALTER DATABASE wideworldimporters SET compatibility_level = 150
    GO
    USE WideWorldImporters
    GO
    SET NOCOUNT ON
    GO
    EXEC [Sales].[CustomerProfits]
    GO 25
    SET NOCOUNT OFF
    GO
    ```
    Notice this is the same script except database compatibility of 150 is used. This time, the query processor in SQL Server will enable table variable deferred compilation so a better query plan can be chosen

10. Run the script and choose the SQL Server container connection. Go through the same steps as in Step 8 to analyze the results. The script should execute far faster than before. Your speeds can vary but should be 15 seconds or less. 

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="../graphics/owl.png"><b>For Further Study</b></p>



<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/geopin.png"><b >Next Steps</b></p>

Next, Continue to <a href="04_HA.md" target="_blank"><i>SQL Server High Availabilty on OpenShift</i></a>.
