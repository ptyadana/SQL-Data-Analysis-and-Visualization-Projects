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
) AND gender='F'

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









