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
FROM (CONTENT = 'D:\repos\sql2019workshop\sql2019wks\05_ModernDevPlatform\java_extensibility\sqlregex.jar')
WITH (LANGUAGE = 'Java');
GO