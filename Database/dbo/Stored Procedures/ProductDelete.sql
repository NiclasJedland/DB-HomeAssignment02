Create PROCEDURE ProductDelete (@ProductID int)
AS
	DELETE FROM [Order Details] WHERE ProductID = @ProductID
	DELETE FROM Products WHERE ProductID = @ProductID