sudo docker exec -d sql2017cu10\
  /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'Sql2017isfast' -Q 'RESTORE DATABASE WideWorldImp$