
CREATE PROCEDURE [dbo].[UpdateProductPrice] (@ProductID int, @UnitPrice money)
AS
	UPDATE Products
		SET UnitPrice = @UnitPrice
	WHERE ProductID = @ProductID
	
