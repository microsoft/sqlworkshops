POD=$(oc get pods | grep mssql-deployment | awk {'print $1'})
oc cp ./WideWorldImporters-Full.bak $POD:/var/opt/mssql/WideWorldImporters-Full.bak
