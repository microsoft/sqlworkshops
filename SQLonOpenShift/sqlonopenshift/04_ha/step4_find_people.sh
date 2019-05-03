SERVERIP=$(oc get service | grep mssql-service | awk {'print $4'})
PORT=31433
sqlcmd -Usa -PSql2019isfast -S$SERVERIP,$PORT -Q"USE WideWorldImporters;SELECT TOP 10 FullName, PhoneNumber, EmailAddress FROM [Application].[People] ORDER BY FullName;" -Y30