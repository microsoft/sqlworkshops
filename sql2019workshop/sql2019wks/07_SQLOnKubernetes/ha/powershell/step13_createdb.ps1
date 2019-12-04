$Service = kubectl get services -o=jsonpath='{.items[0].status.loadBalancer.ingress[0].ip}'
$Server+="-S"
$Server+=$Service
$Server+=",31433"
sqlcmd '-Usa' '-PSql2019isfast' $Server '-Q"CREATE DATABASE sqlk8s;SELECT name FROM sys.databases"'
