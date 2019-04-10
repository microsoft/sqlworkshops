POD=$(oc get pods | grep mssql-deployment | awk {'print $1'})
echo $POD
oc cp ./WideWorldImporters-Full.bak $POD:/var/opt/mssql/WideWorldImporters-Full.bak
