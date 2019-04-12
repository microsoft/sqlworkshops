oc delete deployment mssql-deployment
oc delete secret mssql
oc delete PersistentVolumeClaim mssql-data
oc delete service mssql-service
oc delete project mssql
oc project default
