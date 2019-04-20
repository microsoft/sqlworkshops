SERVERIP=$(kubectl get service | grep mssql-service | awk {'print $4'})
PORT=31433
sqlcmd -Usa -PSql2019isfast -S$SERVERIP,$PORT -Q"SHUTDOWN WITH NOWAIT"