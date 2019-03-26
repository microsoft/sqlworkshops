sudo docker run\
 -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=Sql2017isfast'\
  --hostname sql2\
  -p 1402:1433\
  -v sqlvolume2:/var/opt/mssql\
  --name sql2\
  -d\
  mcr.microsoft.com/mssql/server:2017-latest-ubuntu