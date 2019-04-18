USE master
GO
RESTORE DATABASE TutorialDB
FROM DISK = 'c:\demos\sql2019\python\TutorialDB.bak'
WITH
MOVE 'TutorialDB' TO 'c:\demos\sql2019\python\TutorialDB.mdf',
MOVE 'TutorialDB_log' TO 'c:\demos\sql2019\python\TutorialDB.ldf'
GO