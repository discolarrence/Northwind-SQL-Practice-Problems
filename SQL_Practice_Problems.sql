USE Northwind_SPP

--1
SELECT * 
  FROM Shippers

--2
SELECT CategoryName, 
	   Description 
  FROM Categories

--3
SELECT FirstName, 
	   LastName, 
	   HireDate 
  FROM Employees 
 WHERE Title = 'Sales Representative'

--4
SELECT FirstName, 
	   LastName, 
	   HireDate 
  FROM Employees 
 WHERE Title = 'Sales Representative'
   AND Country = 'USA'

--5
SELECT OrderId, 
	   OrderDate 
  FROM Orders
 WHERE EmployeeID = 5

--6
SELECT SupplierID, 
	   ContactName, 
	   ContactTitle
  FROM Suppliers
 WHERE ContactTitle != 'Marketing Manager'

--7
SELECT ProductID, 
	   ProductName
  FROM Products
 WHERE ProductName LIKE '%queso%'

--8
SELECT OrderID, 
	   CustomerID, 
	   ShipCountry
  FROM Orders
 WHERE ShipCountry = 'France' 
    OR ShipCountry = 'Belgium'

--9
SELECT OrderID, 
	   CustomerID, 
	   ShipCountry
  FROM Orders
 WHERE ShipCountry IN ( 'Brazil', 'Mexico', 'Argentina', 'Venezuela' )

--10
SELECT FirstName, 
	   LastName, 
	   Title, 
	   BirthDate
  FROM Employees
ORDER BY BirthDate

--11
SELECT FirstName, 
	   LastName, 
	   Title, 
	   CONVERT(DATE, BirthDate)
  FROM Employees
 ORDER BY BirthDate

 --12
 SELECT FirstName, 
	   LastName, 
	   CONCAT(FirstName, ' ', LastName) AS FullName 
  FROM Employees

--13
SELECT OrderID,
	   ProductID,
	   UnitPrice,
	   Quantity,
	   UnitPrice*Quantity AS TotalPrice
  FROM OrderDetails
 ORDER BY OrderID, ProductID

 --14
SELECT COUNT(CustomerID) AS TotalCustomers
  FROM Customers

--15
SELECT MIN(OrderDate) AS FirstOrder
  FROM Orders

--16
SELECT DISTINCT Country
  FROM Customers
 ORDER BY Country

--17
SELECT ContactTitle, 
	   COUNT(ContactTitle) AS TotalContactTitle
  FROM Customers
 GROUP BY ContactTitle
 ORDER BY TotalContactTitle DESC

 --18
SELECT p.ProductID,
	   p.ProductName,
	   s.CompanyName
  FROM Products p
	   JOIN Suppliers s 
	   ON p.SupplierID = s.SupplierID
 ORDER BY p.ProductID