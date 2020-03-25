/**********************************************************************/
/* SQL Queries: Practice your SQL Knowledge! */
/**********************************************************************/

/**********************************************************************/
/* Credit to Schema : https://github.com/AndrejPHP/w3schools-database */
/**********************************************************************/
/* Run w3schools.sql to set up database, tables and data*/

/*
----Schema----
Customers (CustomerID, CustomerName, ContactName, Address, City, PostalCode, Country)
Categories (CategoryID,CategoryName, Description)
Employees (EmployeeID, LastName, FirstName, BirthDate, Photo, Notes)
OrderDetails(OrderDetailID, OrderID, ProductID, Quantity)
Orders (OrderID, CustomerID, EmployeeID, OrderDate, ShipperID)
Products(ProductID, ProductName, SupplierID, CategoryID, Unit, Price)
Shippers (ShipperID, ShipperName, Phone)
*/

/**** Advanced Level *****/

/*1. Select customer name together with each order the customer made*/
SELECT CustomerName, OrderID
FROM customers c
JOIN orders o
ON c.CustomerID = o.CustomerID;

/*2. Select order id together with name of employee who handled the order*/
SELECT o.OrderID, e.EmployeeID, e.FirstName, e.LastName
FROM orders o
JOIN employees e
ON o.EmployeeID = e.EmployeeID;

/*3. Select customers who did not placed any order yet*/
SELECT c.CustomerID, c.CustomerName, o.OrderID
FROM customers c
LEFT JOIN orders o
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL;

/*4. Select order id together with the name of products*/
SELECT o.OrderID, p.ProductID, p.ProductName
FROM orders o
JOIN order_details od ON o.OrderID = od.OrderID
JOIN products p ON p.ProductID = od.ProductID
ORDER BY o.OrderID;

/*5. Select products that no one bought*/
SELECT p.ProductID, p.ProductName, od.OrderID
FROM products p
LEFT JOIN order_details od ON p.ProductID = od.ProductID
WHERE od.OrderID IS NULL;

/*6. Select customer together with the products that he bought*/
SELECT c.CustomerID, c.CustomerName, p.ProductName
FROM customers c
JOIN orders o ON o.CustomerID = c.CustomerID
JOIN order_details od ON od.OrderID = o.OrderID
JOIN products p ON p.ProductID = od.ProductID
ORDER BY c.CustomerID, p.ProductName ASC;

/*7. Select product names together with the name of corresponding category*/
SELECT p.ProductID, p.ProductName, c.CategoryName
FROM products p
JOIN categories c
ON p.CategoryID = c.CategoryID;

/*8. Select orders together with the name of the shipping company*/
SELECT o.OrderID, o.CustomerID, o.EmployeeID, o.OrderDate, shp.ShipperName
FROM orders o
JOIN shippers shp
ON o.ShipperID = shp.ShipperID
ORDER BY o.OrderID;

/*9. Select customers with id greater than 50 together with each order they made*/
SELECT c.CustomerID, c.CustomerName, o.OrderID
FROM customers c
JOIN orders o
ON c.CustomerID = o.CustomerID
WHERE c.CustomerID > 50;

/*10. Select employees together with orders with order id greater than 10400*/
SELECT o.OrderID, e.EmployeeID, e.FirstName, e.LastName
FROM orders o
JOIN employees e
ON o.EmployeeID = e.EmployeeID
WHERE o.OrderID > 10400;
