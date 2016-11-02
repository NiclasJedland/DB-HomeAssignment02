USE [NORTHWND]
GO
/****** Object:  StoredProcedure [dbo].[InsertProduct]    Script Date: 2016-11-02 14:32:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertProduct] (@ProductName nvarchar(40), @SupplierID int, @CategoryID int, @QuantityPerUnit nvarchar(20), @UnitPrice money, @UnitsInStock int, @UnitsOnOrder int, @ReorderLevel int, @Discontinued bit)
AS

INSERT INTO [dbo].[Products](ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
     VALUES
           (@ProductName, @SupplierID, @CategoryID, @QuantityPerUnit, @UnitPrice, @UnitsInStock, @UnitsOnOrder, @ReorderLevel, @Discontinued)
