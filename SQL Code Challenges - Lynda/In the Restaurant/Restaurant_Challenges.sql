
/*********************** Time to Celebrate Restaurant Anniversary ***************************************/

/**************************************************************/
/* Create invitations for a party                             */
/**************************************************************/
SELECT FirstName, LastName, Email
FROM Customers
ORDER BY LastName;


/**************************************************************/
/* Create a table to store information                        */
/**************************************************************/
CREATE TABLE PartyAttendees(
CustomerID INTEGER,
PartySize INTEGER,
FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID)
);


/**************************************************************/
/* Print a menu							                      */
/**************************************************************/
SELECT * FROM Dishes
LIMIT 2;

SELECT DISTINCT(Type)
FROM Dishes;

/*All items sorted by price, low to high*/
SELECT *
FROM Dishes
ORDER BY Price;

/*Appetiers and beverages, by type*/
SELECT *
FROM Dishes
WHERE Type IN ("Beverage", "Appetizer")
ORDER BY Type;

/*All items except beverages, by type*/
SELECT *
FROM Dishes
WHERE Type NOT IN ("Beverage")
ORDER BY Type;


/**************************************************************/
/* Sign a cutomer up for your loyalty program                 */
/**************************************************************/
INSERT INTO Customers(FirstName, LastName, Email, Address, City, State, Phone, Birthday)
VALUES ('Vivian', 'Fong', 'vf@email.com', '123 forest street', 'Singapore', 'ABC', '123-456', '27-08-2000');

SELECT * FROM Customers
ORDER BY CustomerID DESC;


/**************************************************************/
/* Update Customer Personal Information                       */
/**************************************************************/
SELECT CustomerID, FirstName, LastName, Address, City, State
FROM Customers WHERE FirstName = "Taylor" AND LastName = "Jenkins";

UPDATE Customers
SET Address = "74 Pine St", City = "New York", State = "NY"
WHERE CustomerID = 26;

SELECT * FROM Customers
WHERE CustomerID = 26;


/**************************************************************/
/* Remove Customer Record                                     */
/**************************************************************/
SELECT CustomerID, FirstName, LastName, Email, Phone
FROM Customers WHERE FirstName = "Taylor" AND LastName = "Jenkins";

DELETE
FROM Customers
WHERE CustomerID = 4;


/**************************************************************/
/* Log Customer Responses                                     */
/**************************************************************/
INSERT INTO PartyAttendees(CustomerID, PartySize)
VALUES( 
	(SELECT CustomerID FROM Customers WHERE Email LIKE 'atapley2j@kinetecoinc.com')
	,3
);

SELECT * FROM PartyAttendees;


/**************************************************************/
/* Look up Reservations                                       */
/**************************************************************/
SELECT r.*, c.FirstName, c.LastName, c.Email, c.Phone
FROM Reservations r
JOIN Customers c
ON r.CustomerID = c.CustomerID
WHERE c.LastName LIKE 'Ste%'
ORDER BY r.Date DESC;


/**************************************************************/
/* Take a Reservation                                         */
/**************************************************************/
SELECT * FROM Customers 
WHERE Email = 'smac@rouxacademy.com';

INSERT INTO Customers(FirstName, LastName, Email, Phone)
VALUES('Same', 'McAdams', 'smac@rouxacademy.com', '(555)555-1212)');

INSERT INTO Reservations(CustomerID, Date, PartySize)
VALUES('102','2020-07-14 18:00:00','5');

SELECT * FROM Reservations 
WHERE CustomerID = 102;


/**************************************************************/
/* Take a Delivery Order                                      */
/**************************************************************/
/* check cusotmer exist or not */
SELECT * FROM Customers
WHERE FirstName = 'Loretta' AND LastName = 'Hundey';

/* check dishes */
SELECT * FROM Dishes;

/* create order */
INSERT INTO Orders(CustomerID, OrderDate)
VALUES(
	(SELECT CustomerID FROM Customers WHERE FirstName = 'Loretta' AND LastName = 'Hundey'),
	'27-08-2020 20:00:00'
);

/* check the latest order of that customer */
SELECT OrderID FROM Orders WHERE CustomerID IN 
		(SELECT CustomerID FROM Customers WHERE FirstName = 'Loretta' AND LastName = 'Hundey')
ORDER BY OrderID DESC
LIMIT 1;


/* Create order dishes */
INSERT INTO OrdersDishes(OrderID, DishID)
VALUES(
	(SELECT OrderID FROM Orders WHERE CustomerID IN 
		(SELECT CustomerID FROM Customers WHERE FirstName = 'Loretta' AND LastName = 'Hundey')
	ORDER BY OrderID DESC
	LIMIT 1),
	(SELECT DishID FROM Dishes WHERE Name LIKE 'House Salad' )
);

INSERT INTO OrdersDishes(OrderID, DishID)
VALUES(
	(SELECT OrderID FROM Orders WHERE CustomerID IN 
		(SELECT CustomerID FROM Customers WHERE FirstName = 'Loretta' AND LastName = 'Hundey')
	ORDER BY OrderID DESC
	LIMIT 1),
	(SELECT DishID FROM Dishes WHERE Name LIKE 'Mini Cheeseburgers' )
);

INSERT INTO OrdersDishes(OrderID, DishID)
VALUES(
	(SELECT OrderID FROM Orders WHERE CustomerID IN 
		(SELECT CustomerID FROM Customers WHERE FirstName = 'Loretta' AND LastName = 'Hundey')
	ORDER BY OrderID DESC
	LIMIT 1),
	(SELECT DishID FROM Dishes WHERE Name LIKE 'Tropical Blue Smoothie' )
);

/* Calculate Total Cost */
SELECT d.Name, SUM(d.Price)
FROM OrdersDishes od
LEFT JOIN Dishes d 
ON od.DishID = d.DishID
WHERE od.OrderID == 1001;


/**************************************************************/
/* Track Customer Favourite                                   */
/**************************************************************/

SELECT *
FROM Customers
WHERE FirstName = 'Cleo' AND LastName = 'Goldwater';


UPDATE Customers
SET FavoriteDish = (SELECT DishID FROM Dishes WHERE Name LIKE 'Quinoa Salmon Salad')
WHERE FirstName = 'Cleo' AND LastName = 'Goldwater';


SELECT *
FROM Customers c
JOIN Dishes d
ON c.FavoriteDish = d.DishID
WHERE FirstName = 'Cleo' AND LastName = 'Goldwater';


/**************************************************************/
/* Report of Top 5 Customers                                  */
/**************************************************************/
SELECT FirstName, LastName, Email, COUNT(OrderID) AS NumberOfOrders
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID
ORDER BY 4 DESC
LIMIT 5;
