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


/********** 3) Ordering Group Data **********/
SELECT d.dept_name AS "Department Name" ,COUNT(e.emp_no) AS "Number Of Employee"
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON d.dept_no = de.dept_no
GROUP BY d.dept_name
HAVING COUNT(e.emp_no) > 25000
ORDER BY 2 DESC;


/********* 4) Group by Mental Model ***********/
/* What are the 8 employees who got the most salary bumps? */
-- SELECT e.emp_no, CONCAT(e.first_name, e.last_name) AS "Name", s.salary, s.from_date, s.to_date
SELECT emp_no, MAX(from_date)
FROM salaries
GROUP BY emp_no;

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

/*********** GROUPING SETS ***********/
/* 
	A Subclause of GROUP BY that allows you to define multiple grouping
	It is very useful when we want to combine multiple grouping 
*/

-- same result as using above UNION code
SELECT NULL AS "prod_id", sum(ol.quantity)
FROM orderlines AS ol
GROUP BY
	GROUPING SETS(
		(),
		(prod_id)
	)
ORDER BY prod_id DESC;

/* we can add in multiple groups as we need */
SELECT NULL AS "prod_id", orderlineid, sum(ol.quantity)
FROM orderlines AS ol
GROUP BY
	GROUPING SETS(
		(),
		(prod_id),
		(orderlineid)
	)
ORDER BY prod_id DESC, orderlineid DESC;