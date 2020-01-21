docker stop sql2019ga
docker run `
 -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=Sql2019isfast' `
 -p 1401:1433 `
 -v sql2019volume:/var/opt/mssql `
 --hostname sql2019cu1 `
 --name sql2019cu1 `
 -d `
 mcr.microsoft.com/mssql/server:2019-CU1-ubuntu-16.04