DECLARE @x int
SET @x = 0
BEGIN TRAN
WHILE (@x < 100)
BEGIN
SET @x = @x + 1
INSERT INTO SalesLT.OrderRating
(SalesOrderID, OrderRatingDT, OrderRating, OrderRatingComments)
VALUES (@x, getdate(), 5, 'This was a great order')
END
COMMIT TRAN
GO