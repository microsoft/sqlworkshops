restore database WideWorldImporters from disk = 'C:\sql_sample_databases\WideWorldImporters-Full.bak' with
move 'WWI_Primary' to 'c:\temp\WideWorldImporters.mdf',
move 'WWI_UserData' to 'c:\temp\WideWorldImporters_UserData.ndf',
move 'WWI_Log' to 'c:\temp\WideWorldImporters.ldf',
move 'WWI_InMemory_Data_1' to 'c:\temp\WideWorldImporters_InMemory_Data_1',
stats=5
go