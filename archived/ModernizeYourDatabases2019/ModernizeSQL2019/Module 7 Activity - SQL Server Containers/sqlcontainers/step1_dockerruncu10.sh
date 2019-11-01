sudo docker run -e\
  'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=Sql2017isfast'\
 --hostname sql2017cu10\
 -p 1401:1433\
 -v sqlvolume:/var/opt/mssql\
 --name sql2017cu10\
 -d\
 mcr.microsoft.com/mssql/server:2017-CU10-ubuntu
