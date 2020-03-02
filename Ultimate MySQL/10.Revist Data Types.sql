/* data prep */
CREATE TABLE people (name VARCHAR(100), birthdate DATE, birthtime TIME, birthdt DATETIME);

INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES('Padma', '1983-11-11', '10:07:35', '1983-11-11 10:07:35');

INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES('Larry', '1943-12-25', '04:10:42', '1943-12-25 04:10:42');

SELECT * FROM people;


/*-----------------------------------*/
/*
Date time functions

CURDATE()	- gives current date

CURTIME()	- gives current time

NOW()		- gives current datetime

Date time format


DAY()

DAYNAME()

DAYOFWEEK()

DAY OF YEAR()
*/


/*MM-dd-YY*/
select birthdate, DATE_FORMAT(birthdate,'%m-%d-%y at %h:%m') AS 'after formatted'
FROM people;
/*
# birthdate, after formatted
'2020-03-01', '03-01-20 at 12:03'
'1943-12-25', '12-25-43 at 12:12'
'1943-12-25', '12-25-43 at 12:12'

*/

SELECT birthdate, DATEDIFF(NOW(), birthdate) AS 'number of days between today and birthdate'
FROM people;

/*-----------------------------------*/

INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES('Richard', CURDATE(), CURTIME(), NOW());

SELECT birthdate, DAYOFYEAR('2020-03-01')
FROM people;

/*-----------------------------------*/


/*Date Time Specifier*/
/*Sunday October 2009*/
SELECT DATE_FORMAT('2009-10-04 22:23:00', '%W %M %Y');

/*MM-dd-YY	=> '2020-03-01'	=> '03-01-20 at 12:03'*/
select birthdate, DATE_FORMAT(birthdate,'%m-%d-%y at %h:%m') AS 'after formatted'
FROM people;


/*-----------------------------------*/
/*
** DATE Math / Arithmetic **

DATEDIFF()
DATE_ADD()
+ or -
*/

/* result : 1 */
SELECT DATEDIFF('2007-12-31 23:59:59','2007-12-30');

/* '2020-03-01 19:28:23' =>  '2020-03-31 19:28:23'*/
SELECT birthdt, DATE_ADD(birthdt, INTERVAL 30 DAY) AS 'after adding 30days'
FROM people;

/*'2020-03-01 19:28:23' => '2020-03-11 19:28:23'*/
SELECT birthdt, birthdt + INTERVAL 10 DAY AS 'after adding 10days'
FROM people;

/*'2020-03-01 19:28:23' => '2020-02-01 19:28:23'*/
SELECT birthdt, birthdt - INTERVAL 1 MONTH AS 'after subtracting 1 month'
FROM people;


/*-------------------------------------*/
/*--- Timestamp -----------*/

CREATE TABLE comments(
	comment VARCHAR(150) NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	change_at TIMESTAMP DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO comments(comment)
VALUES('I like cats'),
	('today is pretty hot'),
	('I can\'t stop watching movies :)');


UPDATE comments
SET comment = 'I like cats and dogs'
WHERE comment = 'I like cats';

/*-------------------------------------*/

/*-------------- Challenges -----------------------*/

/*What's a good use case for CHAR?
It can be used for text which we know in advance that it will have fixed length.
Example: gender (M/F) for CHAR(1)
*/

/*
Fill In The Blanks
CREATE TABLE inventory (
    item_name ____________,
    price ________________,
    quantity _____________
);
(price is always < 1,000,000)
*/
CREATE TABLE inventory (
    item_name VARCHAR(100),
    price DECIMAL(8,2),
    quantity INT
);

/*Print Out The Current Time*/
SELECT CURTIME();

/*Print Out The Current Date (but not time)*/
SELECT CURDATE();

/*Print Out The Current Day Of The Week (the number)*/
SELECT DAY(NOW());
SELECT DAYOFWEEK(CURDATE());
SELECT DAYOFWEEK(NOW());
SELECT DATE_FORMAT(NOW(), '%w') + 1;

/*Print Out The Current Day Of The Week (The Day Name)*/
SELECT DAYNAME(NOW());
SELECT DATE_FORMAT(NOW(), '%W');

/*Print out the current day and time using this format:mm/dd/yyyy*/
SELECT DATE_FORMAT(NOW(), '%m/%d/%Y');
SELECT DATE_FORMAT(CURDATE(), '%m/%d/%Y');

/*Print out the current day and time using this format:
January 2nd at 3:15 O/ April 1st at 10:18
https://www.w3resource.com/mysql/date-and-time-functions/mysql-date_format-function.php
*/
SELECT DATE_FORMAT(NOW(),'%M %D at %H:%m');
SELECT DATE_FORMAT(NOW(), '%M %D at %h:%i');

/*Create a tweets table that stores:
The Tweet content
A Username
Time it was created*/
CREATE TABLE tweets(
	tweet VARCHAR(140) NOT NULL,
	username VARCHAR(100) NOT NULL,
	created_at	TIMESTAMP DEFAULT NOW()
);