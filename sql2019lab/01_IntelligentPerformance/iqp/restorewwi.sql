restore database WideWorldImporters from disk = 'c:\sql_sample_databases\WideWorldImporters-Full.bak' with
move 'WWI_Primary' to 'c:\sql_sample_databases\WideWorldImporters.mdf',
move 'WWI_UserData' to 'c:\sql_sample_databases\WideWorldImporters_UserData.ndf',
move 'WWI_Log' to 'c:\sql_sample_databases\WideWorldImporters.ldf',
move 'WWI_InMemory_Data_1' to 'c:\sql_sample_databases\WideWorldImporters_InMemory_Data_1',
stats=5
go