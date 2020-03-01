/*new books*/
INSERT INTO books
    (title, author_fname, author_lname, released_year, stock_quantity, pages)
    VALUES ('10% Happier', 'Dan', 'Harris', 2014, 29, 256), 
           ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
           ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);

/* Distinct */
SELECT DISTINCT(author_lname) FROM books;


/*What About DISTINCT Full Names??????*/
SELECT DISTINCT(CONCAT(author_fname,' ',author_lname))
FROM books;

/*---------------------------------------*/

/* Order By*/
SELECT author_lname FROM books ORDER BY author_lname DESC;

SELECT released_year FROM books
ORDER BY released_year DESC;

SELECT title,author_fname,author_lname
FROM books
ORDER BY 3;

/*---------------------------------------*/

SELECT title,author_fname,author_lname
FROM books
ORDER BY author_fname,author_lname
LIMIT 5;


/* LIMIT starting_point, how many records*/
/*get two records start from 1st row*/
/*index start from 0 for row 1... etc*/
SELECT title, released_year FROM books 
ORDER BY released_year DESC LIMIT 0,2;

/*limit starting point, till end of records*/
SELECT * FROM tbl LIMIT 95,18446744073709551615;

/*---------------------------------------*/

SELECT * FROM books
WHERE author_fname LIKE '%da%';


/*MySQL like search is case insensitive.
+--------------------+
| name               |
+--------------------+
| Test               |
| test               |
+--------------------+*/
SELECT name FROM users WHERE name LIKE 't%';



/*To make case sensitive search, use BINARY
+--------------------+
| name               |
+--------------------+
| test               |
+--------------------+*/
SELECT name FROM users WHERE name LIKE BINARY 't%';


/*underscore for each character*/
/*start with D with 2 charcters followed by*/
SELECT * FROM books
WHERE author_fname LIKE 'D__' 

# book_id, title, author_fname, author_lname, released_year, stock_quantity, pages
17, ten percent Happier, Dan, Harris, 2014, 29, 256
13, White Noise, Don, DeLillo, 1985, 49, 320


/*four digit stock quanity*/
SELECT *
FROM books
WHERE stock_quantity LIKE '____';


/*escaping special character*/
SELECT * FROM books
WHERE title LIKE '%\%%';

/*=====================EXERCISES ===============================*/

/*Titles  That contain 'stories'*/

SELECT * FROM books
WHERE title LIKE '%stories%';


/*Find The Longest Book
Print Out the Title and Page Count*/
SELECT title,pages
FROM books
ORDER BY pages DESC
LIMIT 1;


/*Print a summary containing the title and year, for the 3 most recent books
+-----------------------------+
| summary                     |
+-----------------------------+
| Lincoln In The Bardo - 2017 |
| Norse Mythology - 2016      |
| 10% Happier - 2014          |
+-----------------------------+
*/

SELECT CONCAT(title,' ',released_year) AS 'summary'
FROM books
ORDER BY released_year DESC
LIMIT 3;


/*Find all books with an author_lname that contains a space(" ")
+----------------------+----------------+
| title                | author_lname   |
+----------------------+----------------+
| Oblivion: Stories    | Foster Wallace |
| Consider the Lobster | Foster Wallace |
+----------------------+----------------+
*/

SELECT title,author_lname
FROM books
WHERE author_lname LIKE '% %';


/*Find The 3 Books With The Lowest Stock Select title, year, and stock
+-----------------------------------------------------+---------------+----------------+
| title                                               | released_year | stock_quantity |
+-----------------------------------------------------+---------------+----------------+
| American Gods                                       |          2001 |             12 |
| Where I'm Calling From: Selected Stories            |          1989 |             12 |
| What We Talk About When We Talk About Love: Stories |          1981 |             23 |
+-----------------------------------------------------+---------------+----------------+
*/
SELECT title,released_year,stock_quantity
FROM books
ORDER BY stock_quantity
LIMIT 3;


/*Print title and author_lname, sorted first by author_lname and then by title*/
SELECT title,author_lname
FROM books
ORDER BY 2,1;


/*Sorted Alphabetically By Last Name*/
SELECT CONCAT('MY FAVOURITE AUTHOR IS ',UPPER(author_fname),' ',UPPER(author_lname)) AS 'YELL'
FROM books
ORDER BY author_lname;
/*
+---------------------------------------------+
| yell                                        |
+---------------------------------------------+
| MY FAVORITE AUTHOR IS RAYMOND CARVER!       |
| MY FAVORITE AUTHOR IS RAYMOND CARVER!       |
| MY FAVORITE AUTHOR IS MICHAEL CHABON!       |
| MY FAVORITE AUTHOR IS DON DELILLO!          |
| MY FAVORITE AUTHOR IS DAVE EGGERS!          |
| MY FAVORITE AUTHOR IS DAVE EGGERS!          |
| MY FAVORITE AUTHOR IS DAVE EGGERS!          |
| MY FAVORITE AUTHOR IS DAVID FOSTER WALLACE! |
| MY FAVORITE AUTHOR IS DAVID FOSTER WALLACE! |
| MY FAVORITE AUTHOR IS NEIL GAIMAN!          |
| MY FAVORITE AUTHOR IS NEIL GAIMAN!          |
| MY FAVORITE AUTHOR IS NEIL GAIMAN!          |
| MY FAVORITE AUTHOR IS FREIDA HARRIS!        |
| MY FAVORITE AUTHOR IS DAN HARRIS!           |
| MY FAVORITE AUTHOR IS JHUMPA LAHIRI!        |
| MY FAVORITE AUTHOR IS JHUMPA LAHIRI!        |
| MY FAVORITE AUTHOR IS GEORGE SAUNDERS!      |
| MY FAVORITE AUTHOR IS PATTI SMITH!          |
| MY FAVORITE AUTHOR IS JOHN STEINBECK!       |
+---------------------------------------------+
*/