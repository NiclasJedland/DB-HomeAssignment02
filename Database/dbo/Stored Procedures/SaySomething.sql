--SET STATISTICS IO ON






/* 
-----------------------SELECT-----------------------
select categoryid, 
		categoryname, 
		description 
	from Categories

select * from products 
	where productname like '%ö%' and 
	productname like '%s%'
	

SELECT ProductName, UnitPrice, CategoryName
	FROM Products p INNER JOIN Categories c 
	ON  p.CategoryID = c.CategoryID 
	WHERE c.CategoryName = 'Beverages'
	ORDER BY p.UnitPrice
	
SELECT CategoryName,
		(SELECT COUNT(*) FROM Products p WHERE p.categoryID = c.CategoryID) AS ProductCount
	FROM Categories c


SELECT CategoryName
	FROM Categories c
	WHERE NOT EXISTS(
		SELECT * FROM Products p )
-----------------------


SELECT c.CategoryName, 
	(SELECT COUNT(*) FROM Products p WHERE p.CategoryID = c.CategoryID)
FROM Categories c

SELECT c.CategoryName, COUNT(*)
FROM Categories c
	LEFT OUTER JOIN Products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName

SELECT c.CompanyName, MIN(o.OrderID)
FROM Customers c
	INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CompanyName

SELECT p.ProductName, p.UnitPrice
FROM Products p
WHERE p.UnitPrice > (SELECT AVG(UnitPrice) FROM Products)


SELECT        Customers.CompanyName, Orders.OrderID, [Order Details].UnitPrice, Products.ProductName
FROM            Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                         Products ON [Order Details].ProductID = Products.ProductID


SELECT        Products.ProductName, COUNT(*) AS AntalRader
FROM            Products INNER JOIN
                         [Order Details] ON Products.ProductID = [Order Details].ProductID
GROUP BY Products.ProductName


SELECT        Orders.OrderID, SUM([Order Details].UnitPrice * 
								[Order Details].Quantity * 
								(1 - [Order Details].Discount)) AS Expr1
FROM            Orders INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID
GROUP BY Orders.OrderID
HAVING SUM([Order Details].UnitPrice * 
								[Order Details].Quantity * 
								(1 - [Order Details].Discount)) > 1000


-----------------------SUBQUERIES-----------------------


	Vilka kunder har aldrig beställt någonting?
SELECT c.ContactName, c.CompanyName
	FROM Customers c
	WHERE NOT EXISTS (SELECT * FROM Orders o WHERE o.CustomerID = c.CustomerID)

	
	Visa ordernummer, orderdatum och antal orderrader för alla beställningar.
SELECT o.OrderID, o.OrderDate, 
	(SELECT COUNT(*) FROM [Order Details] od WHERE o.OrderID = od.OrderID ) AS OrderCount
	FROM Orders o


	Hur många produkter säljer respektive leverantör? Visa leverantörens namn samt antal produkter.
SELECT s.CompanyName, 
		(SELECT COUNT(*) FROM Products p WHERE s.SupplierID = p.SupplierID) AS ProductCount
	FROM Suppliers s


	Ta fram det lägsta pris någon produkt har sålts för dvs. priset på orderraden (order details). Visa produktens namn och pris.	
SELECT p.ProductName, 
		(SELECT MIN(UnitPrice) FROM [Order Details] od WHERE od.ProductID = p.ProductID) AS MinPrice
	FROM Products pn


	Visa en lista på alla produkter med namn och pris. Visa även högsta och lägsta pris för respektive produkt.
SELECT p.ProductName, p.UnitPrice,
		(SELECT MIN(UnitPrice) FROM [Order Details] od WHERE od.ProductID = p.ProductID) AS MinPrice,
		(SELECT MAX(UnitPrice) FROM [Order Details] od WHERE od.ProductID = p.ProductID) AS MaxPrice
			FROM Products p


	Vilka leverantörer säljer någon produkt i prisintervallet 8 till 10?
SELECT s.CompanyName
	FROM Suppliers s
	WHERE EXISTS 
		(SELECT p.UnitPrice FROM Products p 
			WHERE p.UnitPrice BETWEEN 8 AND 10 AND p.SupplierID = s.SupplierID)


	Vilken leverantör har det högsta postnumret? Visa postnummer och leverantörens namn.
SELECT TOP(1) 
	s.CompanyName, s.PostalCode
	FROM Suppliers s 
	ORDER BY s.PostalCode DESC


	Vilka beställningar har gjorts? Visa orderdatum samt kundens namn.
SELECT o.OrderDate, 
		(SELECT c.ContactName FROM Customers c WHERE o.CustomerID = c.CustomerID) AS CustomerName
FROM ORDERS o


	Visa alla kunder och hur många beställningar respektive kund har.
SELECT c.ContactName,
	(SELECT COUNT(*) FROM Orders o WHERE o.CustomerID = c.CustomerID) AS CountOrder
FROM Customers c


	Visa alla produkter, antalet orderrader samt totalt sålt i antal.
SELECT p.ProductName, 
	(SELECT COUNT(*) FROM [Order Details] od WHERE od.ProductID = p.ProductID) AS OrderCount,
	(SELECT SUM(od.Quantity) FROM [Order Details] od WHERE od.ProductID = p.ProductID) AS TotalSold
FROM Products p


	Visa alla länder och regioner för kunder och leverantörer. Sortera på land i bokstavsordning.
SELECT c.CompanyName, s.CompanyName, c.Country, c.Region
	FROM Customers c
	INNER JOIN Suppliers s ON c.Country = s.Country
ORDER BY Country


	Vilket är det första och sista orderdatumet?
SELECT 
	(SELECT TOP(1) o.OrderDate FROM Orders o ORDER BY o.OrderDate DESC) AS Latest,
	(SELECT TOP(1) o.OrderDate FROM Orders o ORDER BY o.OrderDate) AS Earliest


-----------------------GROUP BY / HAVING-----------------------


--Visa alla produkter och dess medel-, högsta och lägsta ordervärde samt vilken leverantör respektive produkt tillhör.
SELECT			Products.ProductName, Suppliers.CompanyName, 
				AVG([Order Details].UnitPrice) AS AvgPrice,
				MIN([Order Details].UnitPrice) AS MinPrice,
				MAX([Order Details].UnitPrice) AS MaxPrice

FROM            Products INNER JOIN
                         [Order Details] ON Products.ProductID = [Order Details].ProductID INNER JOIN
                         Suppliers ON Products.SupplierID = Suppliers.SupplierID
GROUP BY Products.ProductName, Suppliers.CompanyName
ORDER BY AvgPrice


--Vilka kunder har gjort mer än 10 beställningar? Visa kundens namn och antalet beställningar.
SELECT        Customers.CompanyName, COUNT(Orders.OrderID) AS OrderCount
FROM            Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CompanyName
HAVING        (COUNT(Orders.OrderID) > 10)


--Vilka tre produkter har sålt flest i antal? Sortera i fallande ordning.
SELECT Top 3       Products.ProductName, COUNT([Order Details].Quantity) AS ProductCount
FROM            Products INNER JOIN
                         [Order Details] ON Products.ProductID = [Order Details].ProductID
GROUP BY Products.ProductName
ORDER BY ProductCount DESC


--Vilka tre produkter har sålt för högst ordervärde? Sortera i fallande ordning.
SELECT TOP 3       Products.ProductName, MAX([Order Details].UnitPrice) AS Cost
FROM            Products INNER JOIN
                         [Order Details] ON Products.ProductID = [Order Details].ProductID
GROUP BY Products.ProductName
ORDER BY MAX([Order Details].UnitPrice) DESC


--Vilka tre leverantörer har sålt för lägst ordervärde?
SELECT        TOP (3) Suppliers.CompanyName, MIN([Order Details].UnitPrice) AS MinPrice
FROM            Suppliers INNER JOIN
                         Products ON Suppliers.SupplierID = Products.SupplierID INNER JOIN
                         [Order Details] ON Products.ProductID = [Order Details].ProductID
GROUP BY Suppliers.CompanyName
ORDER BY MinPrice


--Vilken anställd har sålt för störst ordervärde?
SELECT   TOP 1     MAX([Order Details].UnitPrice) AS Cost, Employees.FirstName, Employees.LastName
FROM            Employees INNER JOIN
                         Orders ON Employees.EmployeeID = Orders.EmployeeID INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID
GROUP BY Employees.FirstName, Employees.LastName
ORDER BY Cost DESC


--Vilken genomsnittlig rabatt har getts per land?
SELECT        AVG([Order Details].Discount) AS Discount, Customers.Country
FROM            [Order Details] INNER JOIN
                         Orders ON [Order Details].OrderID = Orders.OrderID INNER JOIN
                         Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Customers.Country
ORDER BY Discount DESC


--Visa ordernummer och ordervärde för alla beställningar som har ett ordervärde som är större än 100.
SELECT			Orders.OrderID, 
				SUM([Order Details].UnitPrice) * (1-[Order Details].Discount) AS TotalPrice, 
				[Order Details].Quantity, [Order Details].Discount
FROM            Orders INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID
GROUP BY Orders.OrderID, [Order Details].Quantity, [Order Details].Discount
HAVING        (SUM([Order Details].UnitPrice) > 100)


--Vilka beställningar innehåller fler än två produkter? Visa ordernummer, ordervärde samt antal produkter som beställningen innehåller.
SELECT			[Order Details].OrderID,
				SUM([Order Details].UnitPrice) AS TotalPrice, 
				COUNT([Order Details].Quantity) AS Quantity
FROM            [Order Details] INNER JOIN
                         Orders ON [Order Details].OrderID = Orders.OrderID
GROUP BY [Order Details].OrderID
HAVING        (COUNT([Order Details].Quantity) > 1)


--Vilka leverantörer säljer fler än två produkter? Visa leverantörens namn och antalet produkter som de levererar.
SELECT        Suppliers.CompanyName, COUNT(Products.ProductID) AS ProductCount
FROM            Products INNER JOIN
                         Suppliers ON Products.SupplierID = Suppliers.SupplierID
GROUP BY Suppliers.CompanyName
HAVING        (COUNT(Products.ProductID) > 2)

*/
--Ta fram en lista på alla produkter. Visa produktens namn och pris. Visa också en prisklass-kolumn. Är priset på produkten mindre än fyra ska prisklassen anges som 'Lågt pris'. Är priset 4 eller över men mindre än 10 ska prisklass anges 'Medelpris'. Är priset 10 eller över ska prisklassen anges som 'Högt pris'.



--Ta fram en lista på alla leverantörer. Visa leverantörens namn. Visa också en kontinent-kolumn som visar om leverantören finns i Nordamerika eller Europa. Är land lika med 'USA' ska kolumnen få värdet 'Nordamerika'. Om land ingår i ('England', 'Germany' eller 'France') ska värdet 'Europa' användas.



/*
-----------------------INSERT-----------------------

insert into categories (CategoryName)
	values ('Test1')

insert into products (productname)
	values ('test2'), ('test3')

-----------------------UPDATE-----------------------
update Categories
	set categoryname = 'Test2'
	where categoryid = 10

update products
	set productname = 'test5'
	where productname = 'test1'

update products
	set productname = 'Test6', 
		QuantityPerUnit = '13 stuff'
	where productname = 'Test5'

UPDATE Products
SET UnitPrice = UnitPrice * 1.05
FROM Products p
	INNER JOIN Categories c
	ON p.CategoryID = c.CategoryID
	WHERE c.CategoryName = 'Beverages'

	----LINQPAD
from p in Products
orderby p.Category.CategoryName, p.ProductName ascending
select new { p.Category.CategoryName, p.ProductName, p.UnitPrice }

var beverages = (from c in Categories 
				where c.CategoryName == "Beverages"
				select c).First();
foreach(var p in beverages.Products)
{
	p.UnitPrice *= 1.05m;
}

-----------------------DELETE-----------------------
delete from Categories
	where categoryid = 10

delete from products
	where productname = 'raawr'

delete from products
	where productname like '%test%'

-----------------------DECLARE-----------------------
DECLARE @myInt int;
SET @myInt = 15;
PRINT @myInt;

DECLARE @myString nvarchar(max),
	@myOtherSTring nvarchar(25);
SET @myString = 'This is myString';
SET @myOtherString = (select productname from northwnd.dbo.products where productid = 9);
PRINT @myString + ' <- first   second -> ' + @myOtherString

DECLARE @myDate DATETIME
SET @myDate = DATEFROMPARTS(1982, 10, 18)
PRINT @myDate
SELECT DATEDIFF(dd, @myDate, GETDATE()) 

--dd = days, --mm = months, yy = years, --ss = seconds

DECLARE @myDate DATETIME
SET @myDate = GETDATE()
PRINT @myDate
SELECT DATEDIFF(dd, OrderDate, @myDate) AS Days 
	FROM Orders
	WHERE DATEDIFF(dd, OrderDate, @myDate) > 7000

	*/
-----------------------PROCEDURES-----------------------


CREATE PROCEDURE SaySomething(@message NVARCHAR(50), @counter INT)
AS
	
	WHILE(@counter > 0)
	BEGIN
		PRINT @message + ' ' + CAST(@counter AS NVARCHAR(2))
		SET @counter = @counter - 1
	END











-----------------------END-----------------------






