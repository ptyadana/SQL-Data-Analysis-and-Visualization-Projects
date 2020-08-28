/******************* In the Library *********************/

/*******************************************************/
/* find the number of availalbe copies of Dracula      */
/*******************************************************/

/* check total copies of the book */
SELECT *, COUNT(BookID) AS TotalCopies
FROM Books
WHERE Title LIKE '%Dracula%';

/* current total loans of the book */
SELECT *, COUNT(LoanID) AS TotalLoans
FROM Loans
WHERE BookID IN (
	SELECT BookID FROM Books WHERE Title LIKE '%Dracula%'
)
AND ReturnedDate IS NULL;

/* total available book */

SELECT
	(SELECT COUNT(BookID) AS TotalCopies
	FROM Books
	WHERE Title LIKE '%Dracula%')
	-
	(SELECT COUNT(LoanID) AS TotalLoans
	FROM Loans
	WHERE BookID IN (
		SELECT BookID FROM Books WHERE Title LIKE '%Dracula%'
	)
	AND ReturnedDate IS NULL)
AS AvailableBooks;


/*******************************************************/
/* Add new books to the library                        */
/*******************************************************/

INSERT INTO Books(Title, Author, Published, Barcode)
VALUES
('Dracula', 'Bram Stoker', 1897, 4819277482),
('Gulliver''s Travel', 'Johnathan Swift',1729,4899254401);


/*******************************************************/
/* Check out Books                                     */
/*******************************************************/

INSERT INTO Loans(BookID, PatronID, LoanDate, DueDate)
VALUES
(
	(SELECT BookID FROM Books WHERE Barcode = 4043822646),
	(SELECT PatronID FROM Patrons WHERE Email LIKE 'jvaan@wisdompets.com'),
	'2020-08-25',
	'2020-09-08'
),
(
	(SELECT BookID FROM Books WHERE Barcode = 2855934983),
	(SELECT PatronID FROM Patrons WHERE Email LIKE 'jvaan@wisdompets.com'),
	'2020-08-25',
	'2020-09-08'
);

SELECT * FROM Loans
ORDER BY LoanID DESC
LIMIT 5;


/********************************************************/
/* Check books for Due back                             */
/* generate a report of books due back on July 13, 2020 */
/* with patron contact information                      */
/********************************************************/

SELECT p.FirstName, p.LastName, p.Email, b.Title, l.LoanDate, l.DueDate
FROM Loans l
JOIN Books b ON l.BookID = b.BookID
JOIN Patrons p ON l.PatronID = p.PatronID
WHERE l.DueDate = '2020-07-13'
AND ReturnedDate IS NULL;


/*******************************************************/
/* Return books to the library                         */
/*******************************************************/
SELECT * FROM Loans
WHERE BookID IN (SELECT BookID FROM Books
WHERE Barcode = 6435968624)
AND ReturnedDate IS NULL;

UPDATE Loans
SET ReturnedDate = '2020-07-05'
WHERE BookID IN 
	(SELECT BookID FROM Books WHERE Barcode = 6435968624)
AND ReturnedDate IS NULL;


/*******************************************************/
/* Encourage Patrons to check out books                */
/* generate a report of showing 10 patrons who have
checked out the fewest books.                          */
/*******************************************************/
SELECT p.FirstName, p.LastName, p.Email, COUNT(p.PatronID) AS Total_Loans
FROM Patrons p
LEFT JOIN Loans l
ON p.PatronID = l.PatronID
GROUP BY p.PatronID
ORDER BY 4 ASC
LIMIT 10;


/*******************************************************/
/* Find books to feature for an event                  
 create a list of books from 1890s that are
 currently available                                    */
/*******************************************************/
SELECT b.BookID, b.Title, b.Author, b.Published, COUNT(b.BookID) AS TotalAvailableBooks
FROM Books b
LEFT JOIN Loans l
ON b.BookID = l.BookID
WHERE ReturnedDate IS NOT NULL
AND b.Published BETWEEN 1890 AND 1899
GROUP BY b.BookID
ORDER BY b.BookID;


/*******************************************************/
/* Book Statistics 
/* create a report to show how many books were 
published each year.                                    */
/*******************************************************/
SELECT Published, COUNT(DISTINCT(Title)) AS TotalNumberOfPublishedBooks
FROM Books
GROUP BY Published
ORDER BY TotalNumberOfPublishedBooks DESC;


/*************************************************************/
/* Book Statistics                                           */
/* create a report to show 5 most popular Books to check out */
/*************************************************************/
SELECT b.Title, b.Author, b.Published, COUNT(b.Title) AS TotalTimesOfLoans
FROM Books b
JOIN Loans l
ON b.BookID = l.BookID
GROUP BY b.Title
ORDER BY 4 DESC
LIMIT 5;
