/************ 2) Simple Exercises *********/
/* List all emmployees */
SELECT * FROM employees LIMIT 10;

/* How many departments? */
SELECT COUNT(*) FROM departments;

/* How many times has Employee 10001 has a raise? */
SELECT COUNT(*) AS Number_of_raises FROM salaries
WHERE emp_no = 10001;

/* What title has 10006 has? */
SELECT title FROM titles
WHERE emp_no = 10006;

/***************** 5) Column Concat *****************/
SELECT CONCAT(emp_no, ' is  a ', title) AS "EmpTitle" FROM titles
LIMIT 5;

SELECT emp_no, 
		CONCAT(first_name, ' ', last_name) AS "Full Name"
FROM employees
LIMIT 5;

/************** 6) Types of Functions in SQL *************/
/*
Aggerate - operate on MANY records to produce ONE value, example: SUM of salaries
Scalar - operate on EACH record Independently, example: CONCAT , it doesn't return result of concat values as one value.
*/

/*********** 7) Aggregate Functions ************/
/*
AVG()
COUNT()
MIN()
MAX()
SUM()
*/
SELECT COUNT(*) FROM employees;

SELECT MIN(emp_no) FROM employees;

/* Get the highest salary avaliable */
SELECT MAX(salary) AS Max_Salary FROM salaries;

/* Get the total amount of salaries paid */
SELECT SUM(salary) AS Total_Salary_Paid FROM salaries;

/********** 9) Commenting your queries *******/
SELECT * FROM employees
WHERE first_name='Mayumi' AND last_name='Schueller';

/*********** 11) Filtering Data ***********/
/* Get the list of all female employees */
SELECT * FROM employees
WHERE gender = 'F'
LIMIT 10;

/********** 12) AND OR *************/
SELECT *
FROM employees
WHERE (first_name = 'Georgi' AND last_name='Facello' AND hire_date='1986-06-26')
OR (first_name='Bezalel' AND last_name='Simmel');

/* 13) How many female customers do we have from state of Oregon or New York? */
SELECT COUNT(*) AS "NumberOfFemaleCustomers" 
FROM customers
WHERE gender='F' AND (state LIKE 'OR' OR state LIKE 'NY');

/******** 15) NOT ***********/
/* How many customers aren't 55? */
SELECT COUNT(age) FROM customers
WHERE NOT age=55;


/***** 16) Comparison Operators *******/
/* 17) Exercises */
/* How many female customers do we have from the state of Oregon (OR)? */
SELECT COUNT(*)
FROM customers
WHERE gender='F' AND state='OR';

/* Who over the age of 44 has an income of 100 000 or more? */
SELECT * 
FROM customers
WHERE age > 44 AND income=100000;

/* Who between the ages of 30 and 50 has an income of less than 50 000? */
SELECT *
FROM customers
WHERE age BETWEEN 30 AND 50
AND income < 50000;

/* What is the average income between the ages of 20 and 50? */
SELECT AVG(income)
FROM customers
WHERE age BETWEEN 20 AND 50;


/***** 18) Logical Operators AND OR NOT *****/
/* 
Order of Operations 
FROM => WEHRE => SELECT 
*/

/***** 19) Operator Precedence ******/
/* 
(most importance to least importance)

Parentheses
Multiplication / Division
Subtraction / Addition
NOT
AND
OR

If operators have equal precedence, then the operators are evaluated directionally.
From Left to Right or Right to Left.

check Operators Precedence.png
*/

SELECT state, gender FORM customers
WHERE gender ='F' AND (state='NY' OR state='OR');

/****** 20) Operator Precedence 2 ********/
SELECT *
FROM customers
WHERE (
	income > 10000 AND state='NY'
	OR (
		(age > 20 AND age < 30)
		AND income <=20000
	)
) AND gender='F';

/*Select people either under 30 or over 50 with an income above 50000 that are from either Japan or Australia*/
SELECT *
FROM customers
WHERE (age < 30 OR age > 50)
AND income > 50000
AND (country = 'Japan' OR country = 'Australia');

/*What was our total sales in June of 2004 for orders over 100 dollars?*/
SELECT SUM(totalamount)
FROM orders
WHERE totalamount > 100
AND orderdate='2004/06';

/***** 22) Checking for NULL Values ****/
/*
	NULL = NULL (output: NULL)
	NULL != NULL (output: NULL)
	
No Matter what you do with NULL, it will always be NULL (subtract, add, equal, etc)
*/
SELECT NULL=NULL;
SELECT NULL <> NULL;

-- returns true
SELECT 1=1; 

/******** 23) IS Keyword *********/
SELECT * FROM departments
WHERE dept_name = '' IS FALSE; -- meaning FALSE, but not a good way to write it.

SELECT * FROM departments
WHERE dept_name = '' IS NOT FALSE; -- meaning TRUE, but not a good way to write it.

SELECT * FROM salaries
WHERE salary < 150000 IS FALSE; -- basically saying > 150000


/******* 24) NULL Value Substituion NULL Coalesce *****/
/*
	SELECT coalesce(<column>, 'Empty') AS column_alias
	FROM <table>
	
	
	SELECT coalesce(
		<column1>,
		<column2>,
		<column3>,
		'Empty') AS combined_columns
	FROM <table>
	
Coalsece returns first NON NULL value.

*/

-- default age at 20, if there is no age avaliable
SELECT SUM(COALESCE(age, 20))
FROM students;

/*Assuming a student's minimum age for the class is 15, what is the average age of a student?*/
SELECT AVG(COALESCE(age, 15)) AS avg_age
FROM students;

/*Replace all empty first or last names with a default*/
SELECT COALESCE(first_name, 'DEFAULT') AS first_name,
COALESCE(last_name, 'DEFAULT') AS last_name
FROM students;


/******* 28) BETWEEN AND ********/
/*
	SELECT <column>
	FROM <table>
	WHERE <column> BETWEEN X AND Y
*/


/******* 29) IN Keyword *******/
/*
	SELECT *
	FROM <table>
	WHERE <column> IN (value1, vlaue2, ...)
*/
SELECT *
FROM employees
WHERE emp_no IN (100001, 100006, 11008);


/******* 31) LIKE ***********/

SELECT first_name
FROM employees
WHERE first_name LIKE 'M%';

/*
	PATTERN MATCHING
	
	LIKE '%2'				: Fields that end with 2
	LIKE '%2%'				: Fields that have 2 anywhere in the value
	LIKE '_00%'				: Fields that have 2 zero's as the second and third character and anything after
	LIKE '%200%'			: Fields that have 200 anywhere in the value
	LIKE '2_%_%'			: Fields any values that start with 2 and are at least 3 characters in length
	LIKE '2___3'			: Find any values in a five-digit number that start with 2 and end with 3
*/

/****** CAST *******/
/* Postgres LIKE ONLY does text comparison so we must CAST whatever we use to TEXT */
CAST (salary AS text);  -- method 1
salary::text			-- method 2

/******** Case Insensitive Matching ILIKE *********/
name ILIKE 'BR%'; -- matching for br, BR, Br, bR

SELECT * FROM employees
WHERE first_name ILIKE 'G%GER';

SELECT * FROM employees
WHERE first_name LIKE 'g%'; -- returns nothing because casesensitive

SELECT * FROM employees
WHERE first_name ILIKE 'g%';


/*********** 33) Dates and Timezones **********/

/* Set current postgres's session to UTC */
SHOW TIMEZONE;

SET TIME ZONE UTC;

/********* 34) Setting up Timezones ***********/
ALTER USER postgres SET TIMEZONE='UTC';


/******** 35) How do we format Date and Time *********/
/* 
		Postgres uses IS0-8601
		YYYY-MM-DDTHH:MM:SS
		2021-05-04T11:01:45+08:00
*/


/******* 36) Timestamps ***********/
/* A timestamp is a date with time and timezone info */

SELECT NOW(); -- 2021-05-04 11:05:37.567804+08

CREATE TABLE timezones_tmp(
	ts TIMESTAMP WITHOUT TIME ZONE,
	tz TIMESTAMP WITH TIME ZONE
);

INSERT INTO timezones_tmp
VALUES(
	TIMESTAMP WITHOUT TIME ZONE '2000-01-01 10:00:00',
	TIMESTAMP WITH TIME ZONE '2000-01-01 10:00:00+00'
);

SELECT * FROM timezones_tmp;


/********* 37) Date Functions **********/

SELECT NOW(); 									/* 2021-05-04 11:17:30.418998+08 */

SELECT NOW()::date; 							/* 2021-05-04 */
SELECT NOW()::time; 							/* 11:18:22.483492 */

SELECT CURRENT_DATE; 							/* 2021-05-04 */
SELECT CURRENT_TIME; 							/* 11:19:11.726931+08:00 */

/********* Format Modifier *********/
/*
	D		: Day
	M		: Month
	Y 		: Year
	Check postgres doc for full details.
*/

SELECT TO_CHAR(CURRENT_DATE, 'dd/mm/yyyy');   	/* 04/05/2021 */
SELECT TO_CHAR(CURRENT_DATE, 'ddd'); 			/* 124 */


/*********** 38) Date Difference and Casting ***********/

SELECT NOW() - '1800/01/01';               	/* 80842 days 10:11:08.965674 */
SELECT DATE '1800/01/01';  					/* 1800-01-01 */

SELECT AGE(DATE '1800/01/01');				/* 221 years 4 mons 3 days */
SELECT AGE(DATE '1990/06/30');

/* difference between two dates */
SELECT AGE(DATE '1992/11/13', DATE '1800/01/01');		/* 192 years 10 mons 12 days */


/*********** 40) Extracting Information ************/

SELECT EXTRACT (DAY FROM DATE '1992/11/13') AS DAY; 		/* 13 */
SELECT EXTRACT (MONTH FROM DATE '1992/11/13') AS MONTH;
SELECT EXTRACT (YEAR FROM DATE '1992/11/13') AS YEAR;


/******** ROUND A DATE (Date_Trunc) **********/
SELECT DATE_TRUNC('year', DATE '1992/11/13');			/* 1992-01-01 00:00:00+08 */
SELECT DATE_TRUNC('month', DATE '1992/11/13');			/* 1992-11-01 00:00:00+08 */
SELECT DATE_TRUNC('day', DATE '1992/11/13');			/* 1992-11-13 00:00:00+08 */


/********* 41) Intervals *********/
/* It can store and manipulate a period of time in years, months, days, hours, minutes, seconds, etc */
INTERVAL '1 year 2 months 3 days'
INTERVAL '2 weeks ago'
INTERVAL '1 year 3 hours 20 minutes'

/* <30 days before the given date */
SELECT * FROM orders
WHERE purchaseDate <= NOW() - INTERVAL '30 days';

SELECT NOW() - INTERVAL '30 days'; /* 2021-04-04 11:46:09.447478+08 */
SELECT NOW() - INTERVAL '1 year 2 months 3 days';
SELECT NOW() + INTERVAL '1 year';

/* Extracting intervals data */
-- returns 6 because nearly 6 years
SELECT EXTRACT (
	YEAR 
	FROM INTERVAL '5 years 20 months'
);

-- returns 8, because nearest rounded months is 8 (20 months % 12)
SELECT EXTRACT (
	MONTH 
	FROM INTERVAL '5 years 20 months'
);


/********** 43) DISTINCT *************/
/* 
	remove duplicates 
	SELECT
		DISTINCT <col1>, <col2>
	FROM <table>
*/

SELECT DISTINCT salary, from_date
FROM salaries
ORDER BY salary DESC;


/********* 45) Sorting Data ********/
/*
	SELECT * FROM Customers
	ORDER BY <column> [ASC/DESC]
*/

SELECT first_name, last_name
FROM employees
ORDER BY first_name, last_name DESC
LIMIT 10;

/******** Using Expressions *******/
SELECT DISTINCT last_name, LENGTH(last_name)
FROM employees
ORDER BY LENGTH(last_name) DESC;

/********* 46) Multi Tables SELECT *********/
SELECT e.emp_no, 
	CONCAT(e.first_name, e.last_name) AS full_name,
	s.salary,
	s.from_date, s.to_date
FROM employees as e, salaries as s
WHERE e.emp_no = s.emp_no
ORDER BY e.emp_no;


/******** 47) Inner JOIN ************/

SELECT e.emp_no, 
	CONCAT(e.first_name, e.last_name) AS full_name,
	s.salary,
	s.from_date, s.to_date
FROM employees as e
JOIN salaries as s ON s.emp_no = e.emp_no
ORDER BY e.emp_no;


/* 
we want to know the latest salary after title change of the employee
salary raise happen only after 2 days of title change
*/
SELECT e.emp_no,
		CONCAT(e.first_name, e.last_name) AS "Name",
		s.salary,
		t.title,
		t.from_date AS "Promoted on"
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
JOIN titles t ON e.emp_no = t.emp_no
AND t.from_date = (s.from_date + INTERVAL '2 days')
ORDER BY e.emp_no ASC, s.from_date ASC;


/* we want to know the original salary and also the salary at a promotion */
SELECT e.emp_no,
		CONCAT(e.first_name, e.last_name) AS "Name",
		s.salary,
		COALESCE(t.title, 'no title change'),
		COALESCE(t.from_date::text, '-') AS "title take on"
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
JOIN titles t ON e.emp_no = t.emp_no
AND (
	s.from_date = t.from_date								-- original salary
	OR t.from_date = (s.from_date + INTERVAL '2 days')		-- promoted salary
)
ORDER BY e.emp_no ASC, s.from_date ASC;


/********* 48) Self Join *********/
/*
	This usually can be done when a table has a foreign key referencing to its primary key

| id | name	| startDate | supervisorId|
| 1	 | David| 1990/01/01| 2 |
| 2  | Ric  | 1980/06/03|   |
*/

/* we want to see employee info with supervisor name */
SELECT a.id, a.name AS employee_name, a.startDate, 
		b.name AS supervisor_name
FROM employees a
JOIN employees b ON a.supervisorId = b.id;


/********* 49) OUTER JOIN **********/

/* Which employees are manager ? */
SELECT emp.emp_no, dept.emp_no
FROM employees emp
LEFT JOIN dept_manager dept ON emp.emp_no = dept.emp_no
WHERE dept.emp_no IS NOT NULL;

/* How many employees are NOT manager? */
SELECT COUNT(emp.emp_no)
FROM employees emp
LEFT JOIN dept_manager dept ON emp.emp_no = dept.emp_no
WHERE dept.emp_no IS NULL;

/* We want to know every salary raise and also know which ones were a promotion */
SELECT e.emp_no, s.salary, 
	COALESCE(t.title, 'No Title Change'),
	COALESCE(t.from_date::text, '-') AS "Title taken on"
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
LEFT JOIN titles t ON e.emp_no = t.emp_no
	AND (
			t.from_date = s.from_date 
			OR t.from_date = s.from_date + INTERVAL '2 days'
		)
ORDER BY e.emp_no, s.from_date;


/******** 50) Less Common Joins ************/

/***** Cross Join ******/
/*
	Create a combination of every row
*/
CREATE TABLE "cartesianA" (id INT);
CREATE TABLE "cartesianB" (id INT);

INSERT INTO "cartesianA" VALUES (1);
INSERT INTO "cartesianA" VALUES (2);
INSERT INTO "cartesianA" VALUES (3);

INSERT INTO "cartesianB" VALUES (1);
INSERT INTO "cartesianB" VALUES (2);
INSERT INTO "cartesianB" VALUES (4);
INSERT INTO "cartesianB" VALUES (5);
INSERT INTO "cartesianB" VALUES (20);
INSERT INTO "cartesianB" VALUES (30);

SELECT *
FROM "cartesianA"
CROSS JOIN "cartesianB";

/******** Full Outer Join ********/
/*
	Return results from Both whether they match or not
*/

SELECT *
FROM "cartesianA" a
FULL JOIN "cartesianB" b ON a.id = b.id; 


/*********** 52) USING Keyword ************/
/* Simplying the JOIN syntax */

SELECT emp.emp_no, emp.first_name, emp.last_name, d.dept_name
FROM employees emp
JOIN dept_emp dept USING(emp_no)								-- same as ON emp.emp_no = dept.emp_no
JOIN departments d USING(dept_no)
