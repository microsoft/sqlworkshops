restore database WideWorldImporters from disk = 'd:\sql_sample_databases\WideWorldImporters-Full.bak' with
move 'WWI_Primary' to 'd:\sql_sample_databases\WideWorldImporters.mdf',
move 'WWI_UserData' to 'd:\sql_sample_databases\WideWorldImporters_UserData.ndf',
move 'WWI_Log' to 'd:\sql_sample_databases\WideWorldImporters.ldf',
move 'WWI_InMemory_Data_1' to 'd:\sql_sample_databases\WideWorldImporters_InMemory_Data_1',
stats=5
go