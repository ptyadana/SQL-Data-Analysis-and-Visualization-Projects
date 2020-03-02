/*How many books are in the database???!*/
SELECT COUNT(*) FROM books;

/*How many author_fnames?*/
SELECT COUNT(DISTINCT(author_fname))
FROM books;

/*How many author_lfnames?*/
SELECT COUNT(DISTINCT(author_lname))
FROM books;

/*How many titles contain "the"?*/
SELECT COUNT(*) FROM books
WHERE title LIKE '%the%';

/*COUNT how many books each author has written*/
SELECT CONCAT(author_fname,' ',author_lname) AS 'author name',COUNT(*) AS 'number of books'
FROM books
GROUP BY 1
ORDER BY 2 DESC;


/*books count by released years*/
SELECT released_year, COUNT(*) AS 'number of books'
FROM books
GROUP BY released_year
ORDER BY released_year DESC;


/*Find the minimum released_year*/
SELECT MIN(released_year) FROM books;

/*Find the longest book (but took long as 2 quries have to run)*/
SELECT *
FROM books
WHERE pages = (SELECT MAX(pages) FROM books);

/* Faster way */
SELECT * FROM books
ORDER BY pages DESC
LIMIT 1;


/*Find the year each author published their first book*/
SELECT author_fname,author_lname,MIN(released_year)
FROM books
GROUP BY 1,2;

/*Find the longest page count for each author*/
SELECT author_fname,author_lname,MAX(pages)
FROM books
GROUP BY 1,2;


/*Sum all pages in the entire database*/
SELECT SUM(pages) FROM books;

/*Sum all pages each author has written*/
SELECT author_fname,author_lname,SUM(pages)
FROM books
GROUP BY author_fname,author_lname;


/*Calculate the average released_year across all books*/
SELECT AVG(released_year) FROM books;


/*Calculate the average stock quantity for books released in the same year*/
SELECT released_year, AVG(stock_quantity)
FROM books
GROUP BY released_year;

/*-----------------------------------------------------------*/

/*-------------- Challenges --------------------------------*/
/*Print the number of books in the database*/
SELECT COUNT(*) AS 'number of books' FROM books;


/*Print out how many books were released in each year*/
SELECT released_year, COUNT(*) as 'number of books'
FROM books
GROUP BY released_year;


/*Print out the total number of books in stock*/
SELECT SUM(stock_quantity) AS 'total number books in stock'
FROM books;


/*Find the average released_year for each author*/
SELECT author_fname,author_lname,AVG(released_year)
FROM books
GROUP BY author_fname,author_lname;


/*Find the full name of the author who wrote the longest book*/
SELECT CONCAT(author_fname,' ',author_lname) AS 'Author Full Name', title, pages
FROM books
ORDER BY pages DESC
LIMIT 1;

/*
+------+---------+-----------+
| year | # books | avg pages |
+------+---------+-----------+
| 1945 |       1 |  181.0000 |
| 1981 |       1 |  176.0000 |
| 1985 |       1 |  320.0000 |
| 1989 |       1 |  526.0000 |
| 1996 |       1 |  198.0000 |
| 2000 |       1 |  634.0000 |
| 2001 |       3 |  443.3333 |
| 2003 |       2 |  249.5000 |
| 2004 |       1 |  329.0000 |
| 2005 |       1 |  343.0000 |
| 2010 |       1 |  304.0000 |
| 2012 |       1 |  352.0000 |
| 2013 |       1 |  504.0000 |
| 2014 |       1 |  256.0000 |
| 2016 |       1 |  304.0000 |
| 2017 |       1 |  367.0000 |
+------+---------+-----------+
*/
SELECT released_year AS 'year' ,COUNT(*) AS '# books', AVG(pages) AS 'avg pages'
FROM books
GROUP BY released_year;