/*"Select all books NOT published in 2017"*/
SELECT * FROM books
WHERE released_year NOT IN(2017);

SELECT title FROM books WHERE released_year != 2017;


/*Select all birthdays between 1990 and 1992*/
SELECT name,birthdate
FROM people
WHERE YEAR(birthdate) NOT BETWEEN 1990 AND 1992;


/*Select books with titles that don't start with 'W'*/
SELECT * FROM books
WHERE title NOT LIKE 'W%';


/*Select books released after the year 2000*/
SELECT * FROM books
WHERE released_year > 2000;


/*result: 1*/
SELECT 99 > 1;


/*Select books released before the year 2000*/
SELECT * FROM books
WHERE released_year < 2000;


/*SELECT books written by Dave Eggers, published after the year 2010*/
SELECT * FROM books
WHERE author_fname = 'Dave'
AND author_lname = 'Eggers'
AND released_year > 2010;


/* AND equals && */
SELECT * FROM books
WHERE author_fname = 'Dave'
&& author_lname = 'Eggers'
&& released_year > 2010;


/* OR equals || */
SELECT * FROM books
WHERE author_lname='Eggers' ||
released_year > 2010;


/*Select all books written by...
Carver
Lahiri
Smith*/
SELECT * FROM books
WHERE author_lname IN ('Carver','Lahiri','Smith');

SELECT * FROM books
WHERE author_lname = 'Carver' OR author_lname = 'Lahiri' OR author_lname = 'Smith';


/*Select all books not published in
2000,
2002,
2004,
2006,
2008,
2010,
2012,
2014,
2016*/
SELECT * FROM books
WHERE released_year NOT IN (2000,2002,2004,2006,2008,2010,2012,2014,2016);


/*I only want books released after 2000 and year is even number*/
SELECT * FROM books
WHERE released_year > 2000
AND released_year % 2 = 0;


/*
+-----------------------------------------------------+---------------+------------------+
| title                                               | released_year | GENRE            |
+-----------------------------------------------------+---------------+------------------+
| The Namesake                                        |          2003 | Modern Lit       |
| Norse Mythology                                     |          2016 | Modern Lit       |
| American Gods                                       |          2001 | Modern Lit       |
| Interpreter of Maladies                             |          1996 | 20th Century Lit |
| A Hologram for the King: A Novel                    |          2012 | Modern Lit       |
+-----------------------------------------------------+--------------------------+-------+*/
SELECT title,released_year,
	CASE
		WHEN released_year >= 2000 THEN 'Modren Lit'
		ELSE '20th Century Lit'
	END AS 'GENRE'
FROM books;



/*
0 - 50 	 : 1 star
51 - 100 : 2 stars
> 100	 : 3 stars
+-----------------------------------------------------+----------------+-------+
| title                                               | stock_quantity | STOCK |
+-----------------------------------------------------+----------------+-------+
| The Namesake                                        |             32 | *     |
| Norse Mythology                                     |             43 | *     |
| American Gods                                       |             12 | *     |
| Interpreter of Maladies                             |             97 | **    |
| A Hologram for the King: A Novel                    |            154 | ***   |
| The Circle                                          |             26 | *     |
| The Amazing Adventures of Kavalier & Clay           |             68 | **    |
| Just Kids                                           |             55 | **    |
| A Heartbreaking Work of Staggering Genius           |            104 | ***   |
| Coraline                                            |            100 | **    |
| What We Talk About When We Talk About Love: Stories |             23 | *     |
| Where I'm Calling From: Selected Stories            |             12 | *     |
| White Noise                                         |             49 | *     |
| Cannery Row                                         |             95 | **    |
| Oblivion: Stories                                   |            172 | ***   |
| Consider the Lobster                                |             92 | **    |
| 10% Happier                                         |             29 | *     |
| fake_book                                           |            287 | ***   |
| Lincoln In The Bardo                                |           1000 | ***   |
+-----------------------------------------------------+----------------+-------+
*/

SELECT title, stock_quantity, 
	CASE
		WHEN stock_quantity > 100 THEN '***'
		WHEN stock_quantity >= 50 AND stock_quantity <= 100 THEN '**'
		ELSE '*'
	END AS STOCK
FROM books;

-- OR --

SELECT title, stock_quantity,
    CASE 
        WHEN stock_quantity BETWEEN 0 AND 50 THEN '*'
        WHEN stock_quantity BETWEEN 51 AND 100 THEN '**'
        ELSE '***'
    END AS STOCK
FROM books;   

-- OR --
SELECT title, stock_quantity,
    CASE 
        WHEN stock_quantity <= 50 THEN '*'
        WHEN stock_quantity <= 100 THEN '**'
        ELSE '***'
    END AS STOCK
FROM books;   


/*-------------------------------------------------*/

/*-------- Challenges ---------------------------*/

-- Result : 0 (False)
SELECT 10 != 10;

-- Result: 1 (True)
SELECT 15 > 14 && 99 - 5 <= 94;

-- Result: 1 (True)
SELECT 1 IN (5,3) || 9 BETWEEN 8 AND 10;


/*Select All Books Written Before 1980 (non inclusive)*/
SELECT * FROM books
WHERE released_year < 1980;


/*Select All Books Written By Eggers Or Chabon*/
SELECT * FROM books
WHERE author_lname IN ('Eggers', 'Chabon');


/*Select All Books Written By Lahiri, Published after 2000*/
SELECT * FROM books
WHERE author_lname = 'Lahiri' AND released_year > 2000;

/*Select All Books Written By Lahiri, Published after 2000*/
SELECT * FROM books
WHERE author_lname = 'Lahiri' && released_year > 2000;


/*Select All books with page counts between 100 and 200*/
SELECT * FROM books
WHERE pages BETWEEN 100 AND 200;


/*Select all books where author_lname  starts with a 'C' or an 'S''*/
SELECT * FROM books
WHERE author_lname LIKE 'C%' OR author_lname LIKE 'S%';

-- OR
/*Select all books where author_lname  starts with a 'C' or an 'S''*/
SELECT * FROM books
WHERE SUBSTR(author_lname,1,1) IN ('C','S');


/*If title contains 'stories'   -> Short Stories
Just Kids and A Heartbreaking Work  -> Memoir
Everything Else -> Novel

+-----------------------------------------------------+----------------+---------------+
| title                                               | author_lname   | TYPE          |
+-----------------------------------------------------+----------------+---------------+
| The Namesake                                        | Lahiri         | Novel         |
| Norse Mythology                                     | Gaiman         | Novel         |
| American Gods                                       | Gaiman         | Novel         |
| Interpreter of Maladies                             | Lahiri         | Novel         |
| A Hologram for the King: A Novel                    | Eggers         | Novel         |
| The Circle                                          | Eggers         | Novel         |
| The Amazing Adventures of Kavalier & Clay           | Chabon         | Novel         |
| Just Kids                                           | Smith          | Memoir        |
| A Heartbreaking Work of Staggering Genius           | Eggers         | Memoir        |
| Coraline                                            | Gaiman         | Novel         |
| What We Talk About When We Talk About Love: Stories | Carver         | Short Stories |
| Where I'm Calling From: Selected Stories            | Carver         | Short Stories |
.....
+-----------------------------------------------------+----------------+---------------+
*/
SELECT title,author_lname,
	CASE
		WHEN title LIKE '%stories%' THEN 'Short Stories'
		WHEN title = 'Just Kids' OR title = 'A Heartbreaking Work of Staggering Genius' THEN 'Memoir'
		ELSE 'Novel'
	END AS 'TYPE'
FROM books;


/*+-----------------------------------------------------+----------------+---------+
| title                                               | author_lname   | COUNT   |
+-----------------------------------------------------+----------------+---------+
| What We Talk About When We Talk About Love: Stories | Carver         | 2 books |
| The Amazing Adventures of Kavalier & Clay           | Chabon         | 1 book  |
| White Noise                                         | DeLillo        | 1 book  |
| A Hologram for the King: A Novel                    | Eggers         | 3 books |
| Oblivion: Stories                                   | Foster Wallace | 2 books |
| Norse Mythology                                     | Gaiman         | 3 books |
| 10% Happier                                         | Harris         | 1 book  |
| fake_book                                           | Harris         | 1 book  |
| The Namesake                                        | Lahiri         | 2 books |
| Lincoln In The Bardo                                | Saunders       | 1 book  |
| Just Kids                                           | Smith          | 1 book  |
| Cannery Row                                         | Steinbeck      | 1 book  |
+-----------------------------------------------------+----------------+---------+
*/

SELECT author_fname, author_lname,CONCAT(CAST(COUNT(*) AS CHAR(4)), ' book(s)') AS 'total books'
FROM books 
GROUP BY author_lname, author_fname;