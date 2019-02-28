sudo docker stop sql2017cu10
sudo docker run\
 -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=Sql2017isfast'\
 -p 1401:1433\
 -v sqlvolume:/var/opt/mssql\
 --hostname sql2017latest\
 --name\
 sql2017latest\
 -d\
 mcr.microsoft.com/mssql/server:2017-latest