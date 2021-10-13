USE Northwind_SPP

--1
SELECT * 
  FROM Shippers

--2
SELECT CategoryName, Description 
  FROM Categories

--3
SELECT FirstName, LastName, HireDate 
  FROM Employees 
 WHERE Title = 'Sales Representative'

--4
SELECT FirstName, LastName, HireDate 
  FROM Employees 
 WHERE Title = 'Sales Representative'
		AND Country = 'USA'

--5
SELECT OrderId, OrderDate 
  FROM Orders
 WHERE EmployeeID = 5

--6
SELECT SupplierID, ContactName, ContactTitle
  FROM Suppliers
 WHERE ContactTitle != 'Marketing Manager'

--7
SELECT ProductID, ProductName
FROM Products
WHERE ProductName LIKE '%queso%'

GO

--8
SELECT OrderID, CustomerID, ShipCountry
FROM Orders
WHERE ShipCountry = 'France' OR ShipCountry = 'Belgium'

GO

--9
SELECT OrderID, CustomerID, ShipCountry
FROM Orders
WHERE ShipCountry IN ('Brazil', 'Mexico', 'Argentina', 'Venezuela')

GO

--10
SELECT FirstName, LastName, Title, BirthDate
FROM Employees
ORDER BY BirthDate

GO

--11
SELECT FirstName, LastName, Title, BirthDate
FROM Employees
ORDER BY BirthDate

GO