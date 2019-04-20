SERVERIP=$(oc get service | grep ag1-primary | awk {'print $4'})
PORT=1433
sqlcmd -Usa -PSql2019isfast -S$SERVERIP,$PORT -itestag.sql
