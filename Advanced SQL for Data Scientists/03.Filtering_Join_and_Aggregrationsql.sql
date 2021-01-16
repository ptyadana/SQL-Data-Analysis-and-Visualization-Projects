/********** Filterig, Join and Aggregration ************/

/* we want to know person's salary comparing to his/her department average salary */
SELECT
	s.last_name,s.salary,s.department,
	(SELECT ROUND(AVG(salary),2)
	 FROM staff s2
	 WHERE s2.department = s.department) AS department_average_salary
FROM staff s;


/* how many people are earning above/below the average salary of his/her department ? */
CREATE VIEW vw_salary_comparision_by_department
AS
	SELECT 
	s.department,
	(
		s.salary > (SELECT ROUND(AVG(s2.salary),2)
					 FROM staff s2
					 WHERE s2.department = s.department)
	)AS is_higher_than_dept_avg_salary
	FROM staff s
	ORDER BY s.department;
	
	
SELECT * FROM vw_salary_comparision_by_department;

SELECT department, is_higher_than_dept_avg_salary, COUNT(*) AS total_employees
FROM vw_salary_comparision_by_department
GROUP BY 1,2;


----------------------------------------------------------------------------------------------

/* Assume that people who earn at latest 100,000 salary is Executive.
We want to know the average salary for executives for each department.

Data Interpretation: it seem like Sports department has the highest average salary for Executives
where Movie department has the lowest.*/
SELECT department, ROUND(AVG(salary),2) AS average_salary
FROM staff
WHERE salary >= 100000
GROUP BY department
ORDER BY 2 DESC;


/* who earn the most in the company? 
It seems like Stanley Grocery earns the most.
*/
SELECT last_name, department, salary
FROM staff
WHERE salary = (
	SELECT MAX(s2.salary)
	FROM staff s2
);



/* who earn the most in his/her own department */
SELECT s.department, s.last_name, s.salary
FROM staff s
WHERE s.salary = (
	SELECT MAX(s2.salary)
	FROM staff s2
	WHERE s2.department = s.department
)
ORDER BY 1;
	
----------------------------------------------------------------------------------------------

SELECT * FROM company_divisions;

/* full details info of employees with company division
Based on the results, we see that there are only 953 rows returns. We know that there are 1000 staffs.
*/
SELECT s.last_name, s.department, cd.company_division
FROM staff s
JOIN company_divisions cd
	ON cd.department = s.department;
	
	
/* now all 1000 staffs are returned, but some 47 people have missing company - division.*/
SELECT s.last_name, s.department, cd.company_division
FROM staff s
LEFT JOIN company_divisions cd
	ON cd.department = s.department;
	
	
/* who are those people with missing company division? 
Data Interpretation: it seems like all staffs from "books" department have missing company division.
We may want to inform our IT team to add Books department in corresponding company division.
*/
SELECT s.last_name, s.department, cd.company_division
FROM staff s
LEFT JOIN company_divisions cd
	ON cd.department = s.department
WHERE company_division IS NULL;
	

----------------------------------------------------------------------------------------------

CREATE VIEW vw_staff_div_reg AS
	SELECT s.*, cd.company_division, cr.company_regions
	FROM staff s
	LEFT JOIN company_divisions cd ON s.department = cd.department
	LEFT JOIN company_regions cr ON s.region_id = cr.region_id;


SELECT COUNT(*)
FROM vw_staff_div_reg;


/* How many staffs are in each company regions */
SELECT company_regions, COUNT(*) AS total_employees
FROM vw_staff_div_reg
GROUP BY 1
ORDER BY 1;


SELECT company_regions, company_division, COUNT(*) AS total_employees
FROM vw_staff_div_reg
GROUP BY 1,2
ORDER BY 1,2;


/***** Grouping Sets *****************/
-- Grouping Sets : allows to have more than one grouping in the results table
-- there is no need to seperately use group by per query statement

-- 2 groupings
SELECT company_regions, company_division, COUNT(*) AS total_employees
FROM vw_staff_div_reg
GROUP BY 
	GROUPING SETS(company_regions, company_division)
ORDER BY 1,2;


-- 3 groupings
SELECT company_regions, company_division, gender, COUNT(*) AS total_employees
FROM vw_staff_div_reg
GROUP BY 
	GROUPING SETS(company_regions, company_division, gender)
ORDER BY 1, 2

----------------------------------------------------------------------------------------------


CREATE OR REPLACE VIEW vw_staff_div_reg_country AS
	SELECT s.*, cd.company_division, cr.company_regions, cr.country
	FROM staff s
	LEFT JOIN company_divisions cd ON s.department = cd.department
	LEFT JOIN company_regions cr ON s.region_id = cr.region_id;

/* employees per regions and country */
SELECT company_regions, country, COUNT(*) AS total_employees
FROM vw_staff_div_reg_country
GROUP BY 
	company_regions, country
ORDER BY country, company_regions;

-------------- ROLL UP & CUBE to create Sub Totals ----------------------------------------
-- both are sub clauses of Group by


-------------- ROLL UP ----------------
-- is used to generate sub totals and grand totals

/* number of employees per regions & country, Then sub totals per Country, Then toal for whole table*/
SELECT country,company_regions, COUNT(*) AS total_employees
FROM vw_staff_div_reg_country
GROUP BY
	ROLLUP(country, company_regions)
ORDER BY country, company_regions;


----------- CUBE -------------------
SELECT company_division, company_regions, COUNT(*) AS total_employees
FROM vw_staff_div_reg_country
GROUP BY 
	CUBE(company_division, company_regions)
ORDER BY company_division, company_regions;


-------------------------------------------------------------------------------

/* Difference between Roll Up and Cube 

Reference: https://www.postgresqltutorial.com/postgresql-rollup/

For example, the CUBE (c1,c2,c3) makes all eight possible grouping sets:
(c1, c2, c3)
(c1, c2)
(c2, c3)
(c1,c3)
(c1)
(c2)
(c3)
()


However, the ROLLUP(c1,c2,c3) generates only four grouping sets, assuming the hierarchy c1 > c2 > c3 as follows:

(c1, c2, c3)
(c1, c2)
(c1)
()

*/

SELECT company_division, company_regions, country, COUNT(*) AS total_employees
FROM vw_staff_div_reg_country
GROUP BY 
	ROLLUP(company_division, company_regions, country)
ORDER BY company_division, company_regions, country;


SELECT company_division, company_regions, country, COUNT(*) AS total_employees
FROM vw_staff_div_reg_country
GROUP BY 
	CUBE(company_division, company_regions, country)
ORDER BY company_division, company_regions, country;


-------------------------------------------------------------------------------

------------ FETCH FIRST ----------
/* 
Fetch First works different from Limit.

For Fetch First, Order By Clause works first for sorting. Then Fetch First selets the rows.

For Limit, Limit acutally limits the rows and then performs the operations.

*/


/* What are the top salary earners ? */
SELECT last_name, salary
FROM staff
ORDER BY salary DESC
FETCH FIRST	10 ROWS ONLY;
	
	
/* Top 5 division with highest number of employees*/
SELECT
	company_division,
	COUNT(*) AS total_employees
FROM vw_staff_div_reg_country
GROUP BY company_division
ORDER BY company_division
FETCH FIRST 5 ROWS ONLY;



SELECT
	company_division,
	COUNT(*) AS total_employees
FROM vw_staff_div_reg_country
GROUP BY company_division
ORDER BY company_division
LIMIT 5;
	