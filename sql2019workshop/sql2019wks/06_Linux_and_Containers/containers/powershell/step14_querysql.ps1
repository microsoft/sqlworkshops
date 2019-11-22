sqlcmd '-Usa' '-Slocalhost,1401' '-Q"USE WideWorldImporters;SELECT * FROM [Application].[People];"' '-PSql2019isfast'
sqlcmd '-Usa' '-Slocalhost,1401' '-Q"SELECT @@VERSION"' '-PSql2019isfast'

