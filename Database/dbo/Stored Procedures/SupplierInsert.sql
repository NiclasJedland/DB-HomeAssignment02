CREATE PROCEDURE SupplierInsert (@CompanyName nvarchar(50),  @ContactName nvarchar(50),  @ContactTitle nvarchar(50), 
								 @Address nvarchar(50),  @City nvarchar(50),  @Region nvarchar(50), @PostalCode nvarchar(50),
								 @Country nvarchar(50),  @Phone nvarchar(50), @Fax nvarchar(50), @HomePage nvarchar(50))
AS
	INSERT INTO Suppliers
         (CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax, HomePage)
VALUES (@CompanyName, @ContactName, @ContactTitle, @Address, @City, @Region, @PostalCode, @Country, @Phone, @Fax, @HomePage)
SELECT TOP 1 s.SupplierID
FROM Suppliers s
ORDER BY SupplierID DESC