-- Enable external scripts.
-- No restart is required in SQL Server 2019!
EXEC sp_configure 'ahow advanced options', 1
GO
RECONFIGURE
EXEC sp_configure 'external scripts enabled', 1
GO
RECONFIGURE
GO
-- Create a database and populate some data
--
DROP DATABASE IF EXISTS JavaTest
GO
CREATE DATABASE JavaTest
GO
USE JavaTest
GO
DROP TABLE IF exists reviews;
GO
CREATE TABLE reviews(
	id int NOT NULL,
	"text" nvarchar(30) NOT NULL)

INSERT INTO reviews(id, "text") VALUES (1, 'AAA BBB CCC DDD EEE FFF')
INSERT INTO reviews(id, "text") VALUES (2, 'GGG HHH III JJJ KKK LLL')
INSERT INTO reviews(id, "text") VALUES (3, 'MMM NNN OOO PPP QQQ RRR')
GO