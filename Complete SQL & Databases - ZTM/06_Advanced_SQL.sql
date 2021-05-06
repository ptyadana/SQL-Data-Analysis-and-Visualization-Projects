/******** 1) GROUP BY  **********/
/*
	When we group by, we apply the function PER GROUP,	NOT on the ENTIRE DATA SET.
	Group by use Split, Apply, Combine strategry.
*/

/* How many employees worked in each department ? */
SELECT d.dept_name AS "Department Name" ,COUNT(e.emp_no) AS "Number Of Employee"
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON d.dept_no = de.dept_no
GROUP BY d.dept_no
ORDER BY 1;

/*------------------------------------------------------------------------------------------------------------*/

/************ 2) HAVING Keyword *************/
/*
	"Having" applies filters to a group as a whole
	
	**** Order of Operations ****
		FROM
		WHERE
		GROUP BY
		HAVING
		SELECT
		ORDER
*/

/* How many employees worked in each department, but with employees more than 25000 ? */
SELECT d.dept_name AS "Department Name" ,COUNT(e.emp_no) AS "Number Of Employee"
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON d.dept_no = de.dept_no
GROUP BY d.dept_name
HAVING COUNT(e.emp_no) > 25000
ORDER BY 1;

/* How many Female employees worked in each department, but with employees more than 25000 ? */
SELECT d.dept_name AS "Department Name" ,COUNT(e.emp_no) AS "Number Of Employee"
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON d.dept_no = de.dept_no
WHERE e.gender='F'
GROUP BY d.dept_name
HAVING COUNT(e.emp_no) > 25000
ORDER BY 1;

/*------------------------------------------------------------------------------------------------------------*/

/********** 3) Ordering Group Data **********/
SELECT d.dept_name AS "Department Name" ,COUNT(e.emp_no) AS "Number Of Employee"
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON d.dept_no = de.dept_no
GROUP BY d.dept_name
HAVING COUNT(e.emp_no) > 25000
ORDER BY 2 DESC;


/********* 4) GROUP BY Mental Model ***********/

/* What are the 8 employees who got the most salary bumps? */
-- SELECT e.emp_no, CONCAT(e.first_name, e.last_name) AS "Name", s.salary, s.from_date, s.to_date
SELECT emp_no, MAX(from_date)
FROM salaries
GROUP BY emp_no;


/*------------------------------------------------------------------------------------------------------------*/

/*********** 5) GROUPING SETS**********/

/******* UNION / UNION ALL *********/
/*
	SELECT col1, SUM(col2)
	FROM table
	GROUP BY col1
	
	UNION / UNION ALL
	
	SELECT SUM(col2)
	FROM table
	
	
 	UNION ALL doesn't remove DUPLICATE Records.
*/
SELECT NULL AS "prod_id", sum(ol.quantity)
FROM orderlines AS ol

UNION

SELECT prod_id AS "prod_id", sum(ol.quantity)
FROM orderlines AS ol
GROUP BY prod_id
ORDER BY prod_id DESC;

/*------------------------------------------------------------------------------------------------------------*/

/*********** GROUPING SETS ***********/
/* 
	A Subclause of GROUP BY that allows you to define multiple grouping
	It is very useful when we want to combine multiple grouping 
*/

-- same result as using above UNION code, but in same query
-- here we are combining Two Sets (one for getting Total, one for per each product)
SELECT prod_id, sum(ol.quantity)
FROM orderlines AS ol
GROUP BY
	GROUPING SETS(
		(),
		(prod_id)
	)
ORDER BY prod_id DESC;


/* we can add in multiple groups as we need */
SELECT prod_id, orderlineid, sum(ol.quantity)
FROM orderlines AS ol
GROUP BY
	GROUPING SETS(
		(),
		(prod_id),
		(orderlineid)
	)
ORDER BY prod_id DESC, orderlineid DESC;

/*------------------------------------------------------------------------------------------------------------*/

/************ GROUPING SETS for info from High Level to Details Level ***********/

SELECT
	EXTRACT(YEAR FROM orderdate) AS "YEAR",
	EXTRACT(MONTH FROM orderdate) AS "MONTH",
	EXTRACT(DAY FROM orderdate) AS "DAY",
	SUM(quantity)AS "TOTAL QUANTITY"
FROM orderlines
GROUP BY 
	GROUPING SETS(
		(EXTRACT(YEAR FROM orderdate)), 		-- yearly
		(EXTRACT(MONTH FROM orderdate)), 		-- monthly
		(EXTRACT(DAY FROM orderdate)),			-- daily
		(
			EXTRACT(YEAR FROM orderdate),		-- month and year
			EXTRACT(MONTH FROM orderdate)
		),
		(
			EXTRACT(MONTH FROM orderdate),		-- month and day
			EXTRACT(DAY FROM orderdate)
		),
		(
			EXTRACT(YEAR FROM orderdate),		-- year, month and day
			EXTRACT(MONTH FROM orderdate),
			EXTRACT(DAY FROM orderdate)
		),
		()										-- nothing in particular (TOTAL AMOUNT)
	)
ORDER BY 1,2,3;

/*------------------------------------------------------------------------------------------------------------*/

/************			6) ROLLUP			***************/

/* roll up can provide a very similar result as above using grouping sets, but with less code */
SELECT
	EXTRACT(YEAR FROM orderdate) AS "YEAR",
	EXTRACT(MONTH FROM orderdate) AS "MONTH",
	EXTRACT(DAY FROM orderdate) AS "DAY",
	SUM(quantity)AS "TOTAL QUANTITY"
FROM orderlines
GROUP BY 
	ROLLUP(
		EXTRACT(YEAR FROM orderdate),
		EXTRACT(MONTH FROM orderdate),
		EXTRACT(DAY FROM orderdate)
	)
ORDER BY 1,2,3;

/*------------------------------------------------------------------------------------------------------------*/

/******************** 8/9) WINDOW Functions ******************/
/*
	Window functions CREATE a NEW COLUMN based on functions performed on a SUBSET or "WINDOW" of the data.
	
	window_function(agr1, agr2) OVER(
		[PARTITION BY partition_expression]
		[ORDER BY sort_expression [ASC | DESC] [NULLS {FIRST | LAST}]]
	)
*/

-- Here we can see in the result that max salary is 158,220. Because query returns all data, then LIMIT say cut it off for 100 rows only. 
-- That's why OVER() is calculated on the window or subset of data (in this case the entire data were returned).
SELECT *,
	MAX(salary) OVER()
FROM salaries
LIMIT 100;

-- in this case, the maximum salary is 69,999. Because of WHERE conditions, the data were filtered out.
-- and OVER() is using on that subset or window of the returned data (in this case the results of WHERE filtered data).
SELECT 
	*,
	MAX(salary) OVER() 
FROM salaries
WHERE salary < 70000
ORDER BY salary DESC;


/******************** 10) PARTITON BY ******************/
/*
	Divide Rows into Groups to apply the function against (Optional)
*/

/* Employee salary compairing average salary of departments */
SELECT 
	s.emp_no, s.salary,d.dept_name,
	AVG(s.salary)
	OVER(
		PARTITION BY(d.dept_name)
	)
FROM salaries s
JOIN dept_emp de ON s.emp_no = de.emp_no
JOIN departments d ON d.dept_no = de.dept_no;


/******************** 11) ORDER BY ******************/
/*
	ORDER BY changes the FRAME of the window
	It tells SQL to take into account of everything before up until to this point (becoming Cumulative)
*/
-- against the window of entire data
SELECT emp_no,
	COUNT(salary) OVER()
FROM salaries;

-- using PARTION BY
-- Counting salary by each unique emp_no partion
SELECT emp_no,
	COUNT(salary) OVER(
		PARTITION BY(emp_no)
	)
FROM salaries;


-- using ORDER BY
-- Count number are becoming Cumulative
SELECT emp_no,
	COUNT(salary) OVER(
		ORDER BY emp_no
	)
FROM salaries;


/********************************* FRAME Clause *******************************************************/
/*
	When using Frame clause in a window function, we can create a SUB-RANGE or FRAME
	
	For example: when we use ORDER BY, we look at the PARTATIONED data in a different len (FRAME).
	
	NOTE: 
	Without ORDER BY, by default the framing is usually ALL PARTITION ROWs (Entire Window)
	With ORDER BY, by default the framing is usually everything before the CURRENT ROW AND the CURRENT ROW (Cumulatively)
	
	|----------------------------------------------------------------------------------------------------
	|			Keys						| 			Meaning 										|
	|---------------------------------------|-----------------------------------------------------------|
	|	ROWS or RANGE						|	Whether you want to use a RANGE or ROWS as a FRAME		|
	|	PRECEDING							|	Rows Before the CURRENT ONE								|
	|	FOLLOWING							|	Rows After the CURRENT ONE								|
	| 	UNBOUNDED PRECEDING or FOLLOWING	|	Returns All Before and After							|
	|	CURRENT ROW							|	Your Current Row										|
	-----------------------------------------------------------------------------------------------------
*/

-- In this case, we can see that every salary is unique. Because we are using ORDER BY, each row is cumulativly
-- counted within the partition of each employee's window. As a result, it like like 1, (1+1 becomes 2), etc.
SELECT emp_no,
	salary,
	COUNT(salary) OVER(
		PARTITION BY emp_no
		ORDER BY salary
	)
FROM Salaries;


-- This one returns the same results as using PARTION BY only. The reason is we are looking at the data through the lends of Range.
-- For range using unbounded precedning and following, we are comparing against data with the entire data within that Partition.
SELECT emp_no,
	salary,
	COUNT(salary) OVER(
		PARTITION BY emp_no
		ORDER BY salary
		RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
	)
FROM Salaries;

-- same reults as RANGE results
SELECT emp_no,
	salary,
	COUNT(salary) OVER(
		PARTITION BY emp_no
		ORDER BY salary
		ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
	)
FROM Salaries;


-- same like ORDER BY
SELECT emp_no,
	salary,
	COUNT(salary) OVER(
		PARTITION BY emp_no
		ORDER BY salary
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	)
FROM Salaries;

/*------------------------------------------------------------------------------------------------------------*/








