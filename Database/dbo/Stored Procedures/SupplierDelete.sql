CREATE PROCEDURE SupplierDelete(@SupplierID INT)
AS
	DELETE FROM Suppliers
	WHERE(SupplierID = @SupplierID)