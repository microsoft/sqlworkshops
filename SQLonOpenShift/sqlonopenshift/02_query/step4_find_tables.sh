SERVERIP=$(oc get service | grep mssql-service | awk {'print $4'})
PORT=31433
sqlcmd -Usa -PSql2019isfast -S$SERVERIP,$PORT -Q"USE WideWorldImporters;SELECT name, SCHEMA_NAME(schema_id) as schema_name FROM sys.objects WHERE type = 'U' ORDER BY name" -Y30
