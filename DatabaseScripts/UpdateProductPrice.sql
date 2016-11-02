USE [NORTHWND]
GO
/****** Object:  StoredProcedure [dbo].[UpdateProductPrice]    Script Date: 2016-11-02 14:32:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateProductPrice] (@ProductID int, @UnitPrice money)
AS
	UPDATE Products
		SET UnitPrice = @UnitPrice
	WHERE ProductID = @ProductID
	