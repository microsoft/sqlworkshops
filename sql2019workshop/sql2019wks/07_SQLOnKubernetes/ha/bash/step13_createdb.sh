SERVERIP=$(kubectl get services -o=jsonpath='{.items[0].status.loadBalancer.ingress[0].ip}')
PORT=31433
sqlcmd -Usa -PSql2019isfast -S$SERVERIP,$PORT -Q"CREATE DATABASE sqlk8s;SELECT name FROM sys.databases"