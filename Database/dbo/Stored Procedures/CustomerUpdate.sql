CREATE PROCEDURE CustomerUpdate (@CustomerID nvarchar(5), @CompanyName nvarchar(50), @ContactName nvarchar(50), @ContactTitle nvarchar(50), @Address nvarchar(50), @City nvarchar(50), @Region nvarchar(50), @PostalCode nvarchar(50), @Country nvarchar(50), @Phone nvarchar(50), @Fax nvarchar(50))
AS
	UPDATE Customers
	SET CompanyName = @CompanyName, ContactName = @ContactName,ContactTitle = @ContactTitle, Address = @Address, 
	City = @City, Region = @Region, PostalCode = @PostalCode, Country = @Country, Phone = @Phone, Fax = @Fax
	WHERE CustomerID = @CustomerID