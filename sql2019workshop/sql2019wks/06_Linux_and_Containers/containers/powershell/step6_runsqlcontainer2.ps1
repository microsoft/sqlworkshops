docker run `
 -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=Sql2019isfast' `
 --hostname sql2019ga2 `
 -p 1402:1433 -v `
 sql2019volume2:/var/opt/mssql `
 --name sql2019ga2 `
 -d `
 mcr.microsoft.com/mssql/server:2019-GA-ubuntu-16.04