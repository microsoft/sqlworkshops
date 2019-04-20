USE master
GO
DROP DATABASE IF EXISTS HumanResources
GO
CREATE DATABASE HumanResources
GO
USE HumanResources
GO
DROP TABLE IF EXISTS Employees
GO
CREATE TABLE Employees
(EmployeeID int primary key clustered,
EmployeeName nvarchar(100) not null,
EmployeeSSN nvarchar(20) not null,
EmployeeEmail nvarchar(100) not null,
EmployeePhone nvarchar(20) not null,
EmployeeHireDate datetime not null
)
INSERT INTO Employees VALUES (1, 'Bob Ward', '123-457-6891', 'bward@microsoft.com', '817-455-0111', '10/27/1993')
INSERT INTO Employees VALUES (2, 'Dak Prescott', '256-908-1234', 'dakprescott@dallascowboys.com', '214-123-9999', '08/01/2016')
INSERT INTO Employees VALUES (3, 'Ryan Ward', '569-28-9123', 'ryan.ward@baylor.edu', '817-623-2391', '03/27/1996')
INSERT INTO Employees VALUES (4, 'Ginger Ward', '971-11-2378', 'ginger.ward@outlook.com', '817-455-9872', '01/01/2000')
INSERT INTO Employees VALUES (5, 'Troy Ward', '567-12-9291', 'troy.ward@tulane.edu', '682-111-2391', '08/30/1993')
GO