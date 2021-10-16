USE Northwind_SPP

--1
SELECT * 
  FROM Shippers;

--2
SELECT CategoryName, 
       Description 
  FROM Categories;

--3
SELECT FirstName, 
       LastName, 
	   HireDate 
  FROM Employees 
 WHERE Title = 'Sales Representative';

--4
SELECT FirstName, 
       LastName, 
	   HireDate 
  FROM Employees 
 WHERE Title = 'Sales Representative'
   AND Country = 'USA';

--5
SELECT OrderId, 
       OrderDate 
  FROM Orders
 WHERE EmployeeID = 5;

--6
SELECT SupplierID, 
       ContactName, 
	   ContactTitle
  FROM Suppliers
 WHERE ContactTitle != 'Marketing Manager';
 
--7
SELECT ProductID, 
       ProductName
  FROM Products
 WHERE ProductName LIKE '%queso%';

--8
SELECT OrderID,
       CustomerID, 
	   ShipCountry
  FROM Orders
 WHERE ShipCountry = 'France' 
    OR ShipCountry = 'Belgium';

--9
SELECT OrderID, 
       CustomerID, 
	   ShipCountry
  FROM Orders
 WHERE ShipCountry IN ( 'Brazil', 'Mexico', 'Argentina', 'Venezuela' );

--10
SELECT FirstName, 
       LastName, 
	   Title, 
	   BirthDate
  FROM Employees
 ORDER BY BirthDate;

--11
SELECT FirstName, 
       LastName, 
	   Title, 
	   CONVERT(DATE, BirthDate)
  FROM Employees
 ORDER BY BirthDate;

 --12
 SELECT FirstName, 
        LastName, 
		CONCAT(FirstName, ' ', LastName) AS FullName 
  FROM Employees;

--13
SELECT OrderID,
       ProductID,
	   UnitPrice,
	   Quantity,
	   UnitPrice*Quantity AS TotalPrice
  FROM OrderDetails
 ORDER BY OrderID, ProductID;

 --14
SELECT COUNT(CustomerID) AS TotalCustomers
  FROM Customers;

--15
SELECT MIN(OrderDate) AS FirstOrder
  FROM Orders;

--16
SELECT DISTINCT Country
  FROM Customers
 ORDER BY Country;

--17
SELECT ContactTitle, 
       COUNT(ContactTitle) AS TotalContactTitle
  FROM Customers
 GROUP BY ContactTitle
 ORDER BY TotalContactTitle DESC;

 --18
SELECT p.ProductID,
       p.ProductName,
	   s.CompanyName
  FROM Products p
       JOIN Suppliers s 
	     ON p.SupplierID = s.SupplierID
 ORDER BY p.ProductID;

 --19
SELECT o.OrderID,
       CONVERT(DATE, o.OrderDate) AS OrderDate,
	   s.CompanyName AS Shipper
  FROM Orders o
       JOIN Shippers s
	     ON o.ShipVia = s.ShipperID
 WHERE o.OrderID < 10270
 ORDER BY o.OrderID;

 --20
SELECT c.CategoryName,
       COUNT(p.ProductName) AS TotalProducts
  FROM Categories c
       JOIN Products p
	     ON p.CategoryID = c.CategoryID
 GROUP BY c.CategoryName
 ORDER BY TotalProducts DESC;

--21
SELECT Country,
       City,
	   COUNT(City) AS TotalCustomers
  FROM Customers
 GROUP BY Country, City
 ORDER BY TotalCustomers DESC;

--22
SELECT ProductID,
       ProductName,
	   UnitsInStock,
	   ReorderLevel
  FROM Products
 WHERE UnitsInStock <= ReorderLevel
 ORDER BY ProductID;

--23
SELECT ProductID,
       ProductName,
	   UnitsInStock,
	   UnitsOnOrder,
	   ReorderLevel,
	   Discontinued
  FROM Products
 WHERE UnitsInStock + UnitsOnOrder <= ReorderLevel
   AND Discontinued = 0
 ORDER BY ProductID;

--24
SELECT CustomerID,
       CompanyName,
	   Region
  FROM Customers
 ORDER BY CASE
            WHEN region IS NULL THEN 1
            ELSE 0
          END,
          Region,
          CustomerID;

--25	
SELECT TOP 3 ShipCountry,
             AVG(Freight) AS AverageFreight
  FROM Orders
 GROUP BY ShipCountry
 ORDER BY AverageFreight DESC;

--26
SELECT TOP 3 ShipCountry,
             AVG(Freight) AS AverageFreight
  FROM Orders
 WHERE OrderDate >= '2015-01-01 00:00:00' 
   AND OrderDate < '2016-01-01 00:00:00'
 GROUP BY ShipCountry
 ORDER BY AverageFreight DESC;

 --27
 --OrderID = 10806

--28
SELECT TOP 3 ShipCountry,
             AVG(Freight) AS AverageFreight
  FROM Orders
 WHERE OrderDate <= (SELECT MAX(OrderDate) 
                     FROM Orders)
   AND OrderDate > DATEADD(YEAR, -1, (SELECT MAX(OrderDate) 
                                      FROM Orders))
 GROUP BY ShipCountry
 ORDER BY AverageFreight DESC;

 --29
SELECT o.EmployeeID,
       e.LastName,
	   o.OrderID,
	   p.ProductName,
	   od.Quantity
  FROM OrderDetails AS od
       JOIN Orders o
         ON o.OrderID = od.OrderID
       JOIN Employees e
         ON e.EmployeeID = o.EmployeeID	
       JOIN Products p
         ON p.ProductID = od.ProductID
 ORDER BY o.OrderID, p.ProductID;

--30
SELECT CustomerID
  FROM Customers
 WHERE CustomerID NOT IN (SELECT CustomerID
                          FROM Orders);

--31
SELECT CustomerID
  FROM Orders
 WHERE CustomerID NOT IN (SELECT CustomerID
                          FROM Orders
                          WHERE EmployeeID = 4)
 GROUP BY CustomerID;

 --32
SELECT c.CustomerID,
       c.CompanyName,
	   o.OrderID,
	   SUM(od.UnitPrice*od.Quantity) AS TotalOrderAmount 
  FROM Customers c
       JOIN Orders o
	     ON c.CustomerID = o.CustomerID
	   JOIN OrderDetails od
	     ON o.OrderID = od.OrderID
 WHERE OrderDate >= '2016-01-01 00:00:00' 
   AND OrderDate < '2017-01-01 00:00:00'
 GROUP BY c.CustomerID, c.CompanyName, o.OrderID
HAVING SUM(od.UnitPrice*od.Quantity) >= 10000
 ORDER BY TotalOrderAmount DESC;

 --33
SELECT c.CustomerID,
       c.CompanyName,
       SUM(od.UnitPrice*od.Quantity) AS TotalOrderAmount 
  FROM Customers c
       JOIN Orders o
	     ON c.CustomerID = o.CustomerID
	   JOIN OrderDetails od
	     ON o.OrderID = od.OrderID
 WHERE OrderDate >= '2016-01-01 00:00:00' 
   AND OrderDate < '2017-01-01 00:00:00'
 GROUP BY c.CustomerID, c.CompanyName
HAVING SUM(od.UnitPrice*od.Quantity) >= 15000
 ORDER BY TotalOrderAmount DESC;

--34
SELECT c.CustomerID,
       c.CompanyName,
	   SUM(od.UnitPrice*od.Quantity) AS TotalsWithoutDiscount,
	   SUM((od.UnitPrice*od.Quantity)*(1-od.Discount)) AS TotalsWithDiscount
  FROM Customers c
       JOIN Orders o
	     ON c.CustomerID = o.CustomerID
	   JOIN OrderDetails od
	     ON o.OrderID = od.OrderID
 WHERE OrderDate >= '2016-01-01 00:00:00' 
   AND OrderDate < '2017-01-01 00:00:00'
 GROUP BY c.CustomerID, c.CompanyName
HAVING SUM((od.UnitPrice*od.Quantity)*(1-od.Discount)) >= 15000
 ORDER BY TotalsWithDiscount DESC;

 --35
SELECT EmployeeID,
       OrderID,
	   OrderDate
  FROM Orders
 WHERE OrderDate = EOMONTH(OrderDate)
 ORDER BY EmployeeID, OrderID;


--36
SELECT TOP 10 OrderID,
              COUNT(OrderID) AS TotalOrderDetails
  FROM OrderDetails
 GROUP BY OrderID
 ORDER BY TotalOrderDetails DESC;

--37
SELECT TOP 2 PERCENT OrderID,
                     ABS(CHECKSUM(NEWID())) AS Random
  FROM Orders
 ORDER BY Random;

--38
SELECT OrderID
  FROM OrderDetails
 WHERE Quantity >= 60
 GROUP BY OrderID, Quantity
HAVING COUNT(Quantity) > 1
 ORDER BY OrderID;

--39
WITH Duplicates
     AS (SELECT OrderID,
                Quantity
           FROM OrderDetails
          WHERE Quantity >= 60
          GROUP BY OrderID,
                   Quantity
         HAVING COUNT(Quantity) > 1)
SELECT OrderID,
       ProductID,
       UnitPrice,
       Quantity,
       Discount
  FROM OrderDetails
 WHERE OrderID IN (SELECT OrderID
                     FROM Duplicates); 

--40
SELECT DISTINCT od.OrderID, 
                ProductID, 
	            UnitPrice, 
	            Quantity, 
	            Discount
  FROM OrderDetails od
       JOIN (SELECT OrderID
               FROM OrderDetails
			  WHERE Quantity >= 60
			  GROUP BY OrderID, Quantity
			  HAVING COUNT(*) > 1) d
         ON d.OrderID = od.OrderID
 ORDER BY OrderID, ProductID;

--41
SELECT OrderID,
       OrderDate,
	   RequiredDate,
	   ShippedDate
  FROM Orders
 WHERE RequiredDate < ShippedDate;

--42
WITH LateOrders
     AS (SELECT OrderID,
                OrderDate,
                RequiredDate,
                ShippedDate
           FROM Orders
          WHERE RequiredDate <= ShippedDate)
SELECT o.EmployeeID,
       e.LastName,
       COUNT(o.EmployeeID) AS TotalLateOrders
  FROM Orders o
       JOIN Employees e
         ON e.EmployeeID = o.EmployeeID
 WHERE o.OrderID IN (SELECT OrderID
                       FROM LateOrders)
 GROUP BY o.EmployeeID,
          e.LastName
 ORDER BY TotalLateOrders DESC; 

--43
WITH LateOrders
     AS (SELECT EmployeeID,
                COUNT(EmployeeID) AS LateOrders
           FROM Orders
          WHERE RequiredDate <= ShippedDate
          GROUP BY EmployeeID),
     TotalOrders
	 AS (SELECT EmployeeID,
                COUNT(EmployeeID) AS AllOrders
           FROM Orders
          GROUP BY EmployeeID)
SELECT e.EmployeeID,
       e.LastName,
	   t.AllOrders,
       l.LateOrders	   
  FROM Employees e
	   JOIN TotalOrders t
	     ON t.EmployeeID = e.EmployeeID
	   JOIN LateOrders l
	     ON t.EmployeeID = l.EmployeeID
 ORDER BY EmployeeID; 

 --44
WITH LateOrders
     AS (SELECT EmployeeID,
                COUNT(EmployeeID) AS LateOrders
           FROM Orders
          WHERE RequiredDate <= ShippedDate
          GROUP BY EmployeeID),
     TotalOrders
	 AS (SELECT EmployeeID,
                COUNT(EmployeeID) AS AllOrders
           FROM Orders
          GROUP BY EmployeeID)
SELECT e.EmployeeID,
       e.LastName,
	   t.AllOrders,
       l.LateOrders	   
  FROM Employees e
	   JOIN TotalOrders t
	     ON t.EmployeeID = e.EmployeeID
	   LEFT JOIN LateOrders l
	          ON t.EmployeeID = l.EmployeeID
 ORDER BY EmployeeID;

 --45
WITH LateOrders
     AS (SELECT EmployeeID,
                COUNT(EmployeeID) AS LateOrders
           FROM Orders
          WHERE RequiredDate <= ShippedDate
          GROUP BY EmployeeID),
     TotalOrders
	 AS (SELECT EmployeeID,
                COUNT(EmployeeID) AS AllOrders
           FROM Orders
          GROUP BY EmployeeID)
SELECT e.EmployeeID,
       e.LastName,
	   t.AllOrders,
       ISNULL(l.LateOrders, 0)	   
  FROM Employees e
	   JOIN TotalOrders t
	     ON t.EmployeeID = e.EmployeeID
	   LEFT JOIN LateOrders l
	          ON t.EmployeeID = l.EmployeeID
 ORDER BY EmployeeID;

 --46
WITH LateOrders
     AS (SELECT EmployeeID,
                COUNT(EmployeeID) AS LateOrders
           FROM Orders
          WHERE RequiredDate <= ShippedDate
          GROUP BY EmployeeID),
     TotalOrders
	 AS (SELECT EmployeeID,
                COUNT(EmployeeID) AS AllOrders
           FROM Orders
          GROUP BY EmployeeID)
SELECT e.EmployeeID,
       e.LastName,
	   t.AllOrders,
       ISNULL(l.LateOrders, 0) AS LateOrders,
	   ISNULL(CONVERT(float, l.LateOrders)/CONVERT(float, t.AllOrders), 0) AS PercentLateOrders
  FROM Employees e
	   JOIN TotalOrders t
	     ON t.EmployeeID = e.EmployeeID
	   LEFT JOIN LateOrders l
	          ON t.EmployeeID = l.EmployeeID
 ORDER BY EmployeeID;

--47
WITH LateOrders
     AS (SELECT EmployeeID,
                COUNT(EmployeeID) AS LateOrders
           FROM Orders
          WHERE RequiredDate <= ShippedDate
          GROUP BY EmployeeID),
     TotalOrders
	 AS (SELECT EmployeeID,
                COUNT(EmployeeID) AS AllOrders
           FROM Orders
          GROUP BY EmployeeID)
SELECT e.EmployeeID,
       e.LastName,
	   t.AllOrders,
       ISNULL(l.LateOrders, 0) AS LateOrders,
	   ISNULL( CONVERT( decimal(6,2), CONVERT( float, l.LateOrders )/t.AllOrders ) , 0) AS PercentLateOrders
  FROM Employees e
	   JOIN TotalOrders t
	     ON t.EmployeeID = e.EmployeeID
	   LEFT JOIN LateOrders l
	          ON t.EmployeeID = l.EmployeeID
 ORDER BY EmployeeID;

--48
SELECT c.CustomerID,
       c.CompanyName,
       SUM(od.UnitPrice*od.Quantity) AS TotalOrderAmount,
	   CASE 
	       WHEN SUM(od.UnitPrice*od.Quantity) < 1000 THEN 'Low' 
		   WHEN SUM(od.UnitPrice*od.Quantity) >= 1000 
		    AND SUM(od.UnitPrice*od.Quantity) < 5000 THEN 'Medium'
	   	   WHEN SUM(od.UnitPrice*od.Quantity) >= 5000 
		    AND SUM(od.UnitPrice*od.Quantity) < 10000 THEN 'High'
		   ELSE 'Very High'
	   END AS CustomerGroup
  FROM Customers c
       JOIN Orders o
	     ON c.CustomerID = o.CustomerID
	   JOIN OrderDetails od
	     ON o.OrderID = od.OrderID
 WHERE OrderDate >= '2016-01-01 00:00:00' 
   AND OrderDate < '2017-01-01 00:00:00'
 GROUP BY c.CustomerID, c.CompanyName
 ORDER BY CustomerID;

--49
SELECT c.CustomerID,
       c.CompanyName,
       SUM(od.UnitPrice*od.Quantity) AS TotalOrderAmount,
	   CASE 
	       WHEN SUM(od.UnitPrice*od.Quantity) < 1000 THEN 'Low' 
		   WHEN SUM(od.UnitPrice*od.Quantity) >= 1000 
		    AND SUM(od.UnitPrice*od.Quantity) < 5000 THEN 'Medium'
	   	   WHEN SUM(od.UnitPrice*od.Quantity) >= 5000 
		    AND SUM(od.UnitPrice*od.Quantity) < 10000 THEN 'High'
		   ELSE 'Very High'
	   END AS CustomerGroup
  FROM Customers c
       JOIN Orders o
	     ON c.CustomerID = o.CustomerID
	   JOIN OrderDetails od
	     ON o.OrderID = od.OrderID
 WHERE OrderDate >= '2016-01-01 00:00:00' 
   AND OrderDate < '2017-01-01 00:00:00'
 GROUP BY c.CustomerID, c.CompanyName
 ORDER BY CustomerID;

 --50
 WITH CustomerGrouping
      AS( SELECT c.CustomerID,
	             COUNT(c.CustomerID) AS TotalCustomers,
                 SUM(od.UnitPrice*od.Quantity) AS TotalOrderAmount,
	             CASE 
	                 WHEN SUM(od.UnitPrice*od.Quantity) < 1000 THEN 'Low' 
		             WHEN SUM(od.UnitPrice*od.Quantity) >= 1000 
		              AND SUM(od.UnitPrice*od.Quantity) < 5000 THEN 'Medium'
	   	             WHEN SUM(od.UnitPrice*od.Quantity) >= 5000 
		              AND SUM(od.UnitPrice*od.Quantity) < 10000 THEN 'High'
		             ELSE 'Very High'
	             END AS CustomerGroup
            FROM Customers c
            JOIN Orders o
	          ON c.CustomerID = o.CustomerID
	        JOIN OrderDetails od
	          ON o.OrderID = od.OrderID
           WHERE OrderDate >= '2016-01-01 00:00:00' 
             AND OrderDate < '2017-01-01 00:00:00'
           GROUP BY c.CustomerID)
SELECT CustomerGroup,
       COUNT(CustomerGroup) AS TotalInGroup,
	   CONVERT( decimal(6,2), CONVERT( float, COUNT(CustomerGroup))/TotalCustomers) AS PercentageInGroup
  FROM CustomerGrouping
 GROUP BY TotalCustomers, CustomerGroup
 ORDER BY TotalInGroup DESC