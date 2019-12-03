sudo docker run -e\
  'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=Sql2019isfast'\
 --hostname sql2019ga\
 -p 1401:1433\
 -v sql2019volume:/var/opt/mssql\
 --name sql2019ga\
 -d\
 mcr.microsoft.com/mssql/server:2019-GA-ubuntu-16.04
