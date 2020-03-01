/*What if I want
full names?*/
SELECT CONCAT(author_fname,' ',author_lname)
FROM books;

/*concat_ws with seperator between all specified columns*/
SELECT CONCAT_WS(' - ',author_fname,author_lname)
FROM books;

/*result: hell*/
SELECT SUBSTRING('Hello World',1,4);

/*World*/
SELECT SUBSTRING('Hello World', 7);

/*rld*/
SELECT SUBSTRING('Hello World', -3);

/*SUBSTRING = SUBSTR*/
SELECT SUBSTR('hello world',-3);

/*shorten book's title ...*/
SELECT
	CONCAT(SUBSTR(title,1,10),'...')
FROM books;

/*replace Hell with %$#@ 
Result => %$#@o World
*/
SELECT REPLACE('Hello World', 'Hell', '%$#@');

/*replace ' ' wit ' and '
Result => cheese and bread and coffee and milk*/
SELECT REPLACE('cheese bread coffee milk', ' ', ' and ');

/*Result => dlroW olleH*/
SELECT REVERSE('Hello World');

/*Result => 11*/
SELECT CHAR_LENGTH('Hello World');

/*HELLO WORLD*/
SELECT UPPER('Hello World');

/*hello world*/
SELECT LOWER('Hello World');

/* ---------------------------- */

/*Reverse and Uppercase the following sentence
"Why does my cat look at me with such hatred?"*/
SELECT REVERSE(UPPER('Why does my cat look at me with such hatred?'));

/*
'I-like-cats'
*/
SELECT
  REPLACE
  (
  CONCAT('I', ' ', 'like', ' ', 'cats'),
  ' ',
  '-'
  );


/*Replace spaces in titles with '->'*/
SELECT REPLACE(title,' ','->')
FROM books;


/*reverse author_lname*/
SELECT author_lname AS forwards, REVERSE(author_lname) AS backwards
FROM books;


/*full name in caps*/
SELECT UPPER(CONCAT_WS(' ',author_fname,author_lname))
FROM books;


/*title + release year
+--------------------------------------------------------------------------+
| blurb                                                                    |
+--------------------------------------------------------------------------+
| The Namesake was released in 2003                                        |
----------------------------------------------------------------------------
*/
SELECT concat(title,' was released in ',released_year) AS blurb
FROM books;


/*Print book titles and the length of each title
+-----------------------------------------------------+-----------------+
| title                                               | character count |
+-----------------------------------------------------+-----------------+
| The Namesake                                        |              12 |
-------------------------------------------------------------------------
*/
SELECT title,LENGTH(title) AS 'character count'
FROM books;

/*
+---------------+-------------+--------------+
| short title   | author      | quantity     |
+---------------+-------------+--------------+
| American G... | Gaiman,Neil | 12 in stock  |
| A Heartbre... | Eggers,Dave | 104 in stock |
+---------------+-------------+--------------+
*/
SELECT CONCAT(SUBSTR(title,1,10),'...') AS 'short title',
	CONCAT(author_lname,',',author_fname) AS author,
	CONCAT(stock_quantity,' in stock') AS quantity
FROM books
ORDER BY 1;

