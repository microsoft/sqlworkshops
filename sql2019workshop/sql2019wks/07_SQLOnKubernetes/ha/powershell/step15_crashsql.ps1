$Service = kubectl get service | Select-String -Pattern mssql-service | Out-String
$Service = $Service.split(" ")
$Server+="-S"
$Server+=$Service[9]
$Server+=",31433"
sqlcmd '-Usa' '-PSql2019isfast' $Server '-Q"SHUTDOWN WITH NOWAIT"'
