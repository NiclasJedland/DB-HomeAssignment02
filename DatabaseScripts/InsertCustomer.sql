USE [NORTHWND]
GO
/****** Object:  StoredProcedure [dbo].[InsertCustomer]    Script Date: 2016-11-02 14:32:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[InsertCustomer] (@CustomerID nchar(5), @CompanyName nvarchar(40), @ContactName nvarchar(30), @ContactTitle nvarchar(30), @Address nvarchar(60), @City nvarchar(15), @Region nvarchar(15), @PostalCode nvarchar(10), @Country nvarchar(15), @Phone nvarchar(24), @Fax nvarchar(24))
AS

INSERT INTO [dbo].[Customers]([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country],[Phone],[Fax])
     VALUES
           (@CustomerID, @CompanyName, @ContactName, @ContactTitle, @Address, @City, @Region, @PostalCode, @Country, @Phone, @Fax)
