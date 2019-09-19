# SQL Server Demo for the Java Extension

This is a demo to show the Java Extension capability in SQL Server 2019 and later. This demo shows how to run Java code on SQL Server on Windows. The same code will work with SQL Server Java on Linux. Demo for this scenario coming soon.

## Requirements

1. Install SQL Server 2019 CTP 2.0 on Windows or later following the guidance on this page for Java.

https://docs.microsoft.com/en-us/sql/advanced-analytics/java/extension-java?view=sqlallproducts-allversions#install-on-windows

2. Follow the rest of the steps on this page to install all dependencies

https://docs.microsoft.com/en-us/sql/advanced-analytics/java/extension-java?view=sqlallproducts-allversions#install-on-windows

## Demo Steps

1. I used the sample code from https://docs.microsoft.com/en-us/sql/advanced-analytics/java/java-first-sample?view=sqlallproducts-allversions and included the 3 Java class source: **InputRow.java**, **OutputRow.java**, **Ngram.java**

2. I compiled the Java classes using the script **buildjava8.cmd** with Java 8 SDK (so it will be compatible with Linux). The compiled code is placed into C:\java\pkg. You can adjust this to whatever directory  you need but you will need to make edits in the following steps.

3. You need to setup permissions for the folder for your compiled classes. Use the instructions per the documentation at https://docs.microsoft.com/en-us/sql/advanced-analytics/java/java-first-sample?view=sqlallproducts-allversions#6---set-permissions

4. Run the **javasetup.sql** script to create the database and objects.

5. Run the **javangramdemo.sql** to execute the Java code. This script assumes the class files are in c:\java\pkg. I recommend you keep the pkg subdirectory. If you need to have the classes in a different parent folder, modify this part of the script SET @myClassPath = N'C:\java'