POD=$(oc get pods | grep mssql | awk {'print $1'})
oc logs $POD
