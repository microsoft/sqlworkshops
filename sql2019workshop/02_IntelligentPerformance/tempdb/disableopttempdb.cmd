sqlcmd -Usa -idisableopttempdb.sql -Sbwsql2019
net stop mssqlserver
net start mssqlserver