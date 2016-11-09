CREATE PROCEDURE [dbo].[InsertProduct] (@ProductName nvarchar(40), @SupplierID int, @CategoryID int, @QuantityPerUnit nvarchar(20), @UnitPrice money, @UnitsInStock int, @UnitsOnOrder int, @ReorderLevel int, @Discontinued bit)
AS

INSERT INTO [dbo].[Products](ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
     VALUES
           (@ProductName, @SupplierID, @CategoryID, @QuantityPerUnit, @UnitPrice, @UnitsInStock, @UnitsOnOrder, @ReorderLevel, @Discontinued)
