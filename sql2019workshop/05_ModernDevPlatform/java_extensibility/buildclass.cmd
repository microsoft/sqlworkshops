del -r pkg
mkdir pkg
del *.class
del *.jar
javac -cp "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Binn\mssql-java-lang-extension.jar" .\RegexSample.java
copy RegexSample.class pkg
jar -cf sqlregex.jar pkg\*.class