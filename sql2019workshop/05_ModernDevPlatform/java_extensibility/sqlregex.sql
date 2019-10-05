use javatest
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
END
GO
--Now execute the above stored procedure and provide the regular expression and an input query
EXECUTE [dbo].[java_regex] N'[Jj]ava', N'SELECT id, text FROM testdata'
GO
-- Alternative in context of master since I get perms problems running it outside of master
-- and...I can't get the GRANT syntax working
USE master
GO
EXEC sp_execute_external_script
  @language = N'Java'
, @script = N'pkg.RegexSample'
, @input_data_1 = N'SELECT id, text FROM Javatest.dbo.testdata'
, @params = N'@regexExpr nvarchar(200)'
, @regexExpr = N'[Jj]ava'
with result sets ((ID int, text nvarchar(100)));
GO
