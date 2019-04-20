SERVERIP=$(oc get service | grep ag1-primary | awk {'print $4'})
PORT=1433
sqlcmd -Usa -PSql2019isfast -S$SERVERIP,$PORT -Q"SELECT 'Connected to Primary = '+@@SERVERNAME;USE testag;SELECT * FROM ilovesql" -Y60
SERVERIP=$(oc get service | grep ag1-secondary | awk {'print $4'})
PORT=1433
sqlcmd -Usa -PSql2019isfast -S$SERVERIP,$PORT -Q"SELECT 'Connected to Secondary = '+@@SERVERNAME;USE testag;SELECT * FROM ilovesql" -K ReadOnly -Y60
