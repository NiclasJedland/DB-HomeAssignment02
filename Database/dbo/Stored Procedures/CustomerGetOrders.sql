CREATE PROCEDURE CustomerGetOrders (@CustomerID nvarchar(5))
AS
	SELECT        Customers.CompanyName, Customers.ContactName, Orders.OrderDate
	FROM            Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID
	WHERE Customers.CustomerID = @CustomerID