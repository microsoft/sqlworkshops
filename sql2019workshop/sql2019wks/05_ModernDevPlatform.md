![](../graphics/microsoftlogo.png)

# Workshop: SQL Server 2019 Workshop

#### <i>A Microsoft workshop from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=true"><b>     SQL Server 2019 Modern Development Platform</b></h2>

SQL Server 2019 includes new capabilities to solve challenges of the Modern Data Developer including:

- Support for a variety of programming languages such as C#, Java, Node.js, php, Python, Ruby, and Go.
- Support for UTF-8 encoding
- Enhancements to Machine Learning Services
- Extending the T-SQL language with SQL Server Language Extensions.

You can read more details about all of these enhancements at https://docs.microsoft.com/en-us/sql/sql-server/what-s-new-in-sql-server-ver15?view=sqlallproducts-allversions.

You will cover the following topics in this Module:

<dl>

  <dt><a href="#3-0">5.0 Extending the T-SQL Language with Java</a></dt>
   
</dl>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><b><a name="3-0">     5.0 Extending the T-SQL Language with Java</a></b></h2>

SQL Server 2019 provides solutions to extend the T-SQL language using Java running under the same framework as SQL Server Machine Learning Services.

<h3><b><a name="challenge">The Challenge</a></b></h3>

T-SQL is a robust language but in some cases my not have the capabilities required by developes looking to write "server-side code". Developers need a way to extend the T-SQL language based on their own language preference. They need the ability to run their code integrated with results of a T-SQL query and run this code on the same computer as SQL Server but in a secure and isolated fashion.

<h3><b><a name="solution">The Solution</a></b></h3>

To meet the challenge of extending the T-SQL language for requirements not met with T-SQL today we have built a framework called **SQL Server Language Extensions**. Using the same architecture as SQL Server Machine Learning Services called the **extensibility framework**, we now allow for new languages to be accessed via T-SQL as seen in the following diagram:

![SQL Server Language Extensions](./graphics/SQL_Language_Extensions.jpg)

You can read more about SQL Server Language Extensions at https://docs.microsoft.com/en-us/sql/language-extensions/language-extensions-overview.

In SQL Server 2019, we have shipped Java as an example of using SQL Server Language Extensions called the **Microsoft Extensibility SDK for Java**. As part of the Java installation, we now include an open-source, full-supported version of Java from Azul.

A few key points should be considered for those who are concerned with running Java code in this framework:

- The extensibility framework runs any Java code OUTSIDE of the SQL Server process space. These process run under a low privileged account using application isolation methods on Windows and Linux.
- These processes (called satellite processes) are blocked from sending network traffic out of the server by default. Changing these rules requires OS level admin access.
- The only way to run a Java class is to install the SQL Server Language Extension feature and enable the capability through sp_configure.
- The only way to run the Java class is to use the **sp_execute_external_script** system stored procedure which requires the EXECUTE ANY EXTERNAL SCRIPT permission. This permission is not granted to all users by default.
- Resource governor is integrated into the solution allows you to control CPU, memory, and affinity for satellite processes. You can read more about how to manage satellite process resource usage with resource governor at https://docs.microsoft.com/en-us/sql/advanced-analytics/administration/resource-governor?view=sql-server-ver15#manage-resources-with-resource-governor.

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="activityadr">     Activity: Using Regular Expression Parsing with T-SQL</a></b></h2>

One example of extending the T-SQL language is regular expression parsing. The T-SQL language provides some built-in capabilities to search for patterns in strings such as the LIKE clause and T-SQL string functions (see https://docs.microsoft.com/en-us/sql/t-sql/functions/string-functions-transact-sql). Regular expressions or *regex* (see https://en.wikipedia.org/wiki/Regular_expression) provides a more robust search pattern experience. Java is a language that can be used to implement regular expression parsing. **SQL Server Language Extensions** and the **Microsoft Extensibility SDK for Java** for SQL Server allow a developer to build a Java class to perform a regular expression search on string data in SQL Server columns. 

>**NOTE**: *If at anytime during the Activities of this Module you need to "start over" you can go back to the first Activity in 5.0 and run through all the steps again.*

This activity assumes you have installed SQL Server Language extensions and enabled external scripts per the documentation:

Windows - https://docs.microsoft.com/en-us/sql/language-extensions/install/install-sql-server-language-extensions-on-windows?view=sql-server-ver15

Linux - https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-language-extensions?view=sql-server-ver15

<h3><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b><a name="activitysteps3.0">Activity Steps</a></b></h3>

To go through the steps for this Activity follow all the instructions in the tutorial as found in the SQL Server documentation at  https://docs.microsoft.com/en-us/sql/language-extensions/tutorials/search-for-string-using-regular-expressions-in-java. The following files have been provided to match what you can use from the tutorial in the **sql2019workshop\05_ModernDevPlatform\java_extensibility** folder:

- **RegexSample.java**

This is the Java class code to implement regular expression parsing and use the Microsoft Extensibility SDK for Java. It is the same code as found in the tutorial in the documentation.

- **buildclass.cmd**

This is a script to create the necessary directories, compile the Java class, and create a .jar file for the new Java class. There are several ways to compile the Java Code. One way is to download the OpenJDK from Azul from https://www.azul.com/downloads/zulu-community/?&architecture=x86-64-bit&package=jdk.

The script runs these commands

```powershell
del -r pkg
mkdir pkg
del *.class
del *.jar
javac -cp "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Binn\mssql-java-lang-extension.jar" .\RegexSample.java
copy RegexSample.class pkg
jar -cf sqlregex.jar pkg\*.class
```
The path for the mssql-java-lang-extension.jar file may be different in your environment or on Linux.

- **sampledata.sql**

This is a T-SQL script used to create the database, a table, and sample data:

```sql
CREATE DATABASE javatest;
GO
USE javatest;
GO
CREATE TABLE testdata (
    id int NOT NULL,
    "text" nvarchar(100) NOT NULL
);
GO
-- Insert data into test table
INSERT INTO testdata(id, "text") VALUES (1, 'This sentence contains java');
INSERT INTO testdata(id, "text") VALUES (2, 'This sentence does not');
INSERT INTO testdata(id, "text") VALUES (3, 'I love Java!');
GO
```

- **setuplanguage.sql**

This is a T-SQL script to create the external language for Java and then external libraries for the Microsoft Extensibility SDK for Java and the Regular Expression class compiled from RegexSample.java:

```sql
USE javatest;
GO
DROP EXTERNAL LIBRARY javasdk;
DROP EXTERNAL LIBRARY sqlregex;
DROP EXTERNAL LANGUAGE Java;
GO
CREATE EXTERNAL LANGUAGE Java
FROM
(CONTENT = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Binn\java-lang-extension.zip', FILE_NAME = 'javaextension.dll');
GO
CREATE EXTERNAL LIBRARY javasdk
FROM (CONTENT = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Binn\mssql-java-lang-extension.jar')
WITH (LANGUAGE = 'Java');
GO
CREATE EXTERNAL LIBRARY sqlregex
FROM (CONTENT = 'C:\demos\sql2019\java\sqlregex.jar')
WITH (LANGUAGE = 'Java');
GO
```
These directories may be different for your installation or on Linux. For more information on how to create the Java external language for Linux see the documentation at https://docs.microsoft.com/en-us/sql/language-extensions/tutorials/search-for-string-using-regular-expressions-in-java?view=sql-server-ver15#create-external-language.

- **sqlregex.sql**

This is the T-SQL script to create a stored procedure that uses sp_execute_external_script to call the Java class passing in a query and regex expression:

```sql
USE javatest;
go
CREATE OR ALTER PROCEDURE [dbo].[java_regex] @expr nvarchar(200), @query nvarchar(400)
AS
BEGIN
--Call the Java program by giving the package.className in @script
--The method invoked in the Java code is always the "execute" method
EXEC sp_execute_external_script
  @language = N'Java'
, @script = N'pkg.RegexSample'
, @input_data_1 = @query
, @params = N'@regexExpr nvarchar(200)'
, @regexExpr = @expr
with result sets ((ID int, text nvarchar(100)));
END;
GO
--Now execute the above stored procedure and provide the regular expression and an input query
EXECUTE [dbo].[java_regex] N'[Jj]ava', N'SELECT id, text FROM testdata';
GO
```
Your results should look like the following:

<pre>ID text
1  This sentence contains java
3  I love Java!</pre>

When you are done proceed to the **Activity Summary** section for the Activity below.

<h3><b><a name="activitysummary">Activity Summary</a></b></h3>

In this activity you used a Java class to extend the T-SQL language to provide regex capabilities. You used the system stored procedure sp_execute_external_script to pass a T-SQL query that includes columns with string data and a regex expression. The Java class is called to process the regex expression on each row and return regex results. The Microsoft Extensibility SDK for Java is used to build the Java class and integrate this into the extensibility framework of SQL Server Language Extensions.

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/owl.png?raw=true"><b>     For Further Study</b></h2>

- [Build an App using SQL Server](https://aka.ms/sqldev)

- [What is SQL Server Language Extensions?](https://docs.microsoft.com/en-us/sql/language-extensions/language-extensions-overview?view=sql-server-ver15)

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/geopin.png?raw=true"><b>     Next Steps</b></h2>

Next, Continue to <a href="06_Linux_and_Containers.md" target="_blank"><i>Linux_and_Containers</i></a>.
