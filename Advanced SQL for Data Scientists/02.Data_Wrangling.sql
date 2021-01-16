/**************** Data Wrangling / Data Munging *************/

SELECT DISTINCT(department)
FROM staff
ORDER BY department;


/********* Reformatting Characters Data *********/

SELECT DISTINCT(UPPER(department))
FROM staff
ORDER BY 1;


SELECT DISTINCT(LOWER(department))
FROM staff
ORDER BY 1;


/*** Concatetation ***/
SELECT 
	last_name,
	job_title || ' - ' || department AS title_with_department 
FROM staff;

/*** Trim ***/
SELECT
	TRIM('    data sciece rocks !    ');

-- with trim is 19 characters
SELECT
	LENGTH(TRIM('    data sciece rocks !    '));
	
-- without trim is 27 characters
SELECT
	LENGTH('    data sciece rocks !    ');


/* How many employees with Assistant roles */
SELECT
	COUNT(*) AS employees_with_Assistant_role
FROM staff
WHERE job_title LIKE '%Assistant%';


/* What are those Assistant roles? */
SELECT DISTINCT(job_title)
FROM staff
WHERE job_title LIKE '%Assistant%'
ORDER BY 1;


/* let's check which roles are assistant role or not */
SELECT 
	DISTINCT(job_title),
	job_title LIKE '%Assistant%' is_assistant_role
FROM staff
ORDER BY 1;

--------------------------------------------------------------------------------------------


/********* Extracting Strings from Characters *********/
-- SUBSTRING('string' FROM position FOR how_many)

---------------------- SubString words ----------------------------------------------------
SELECT 'abcdefghijkl' as test_string;


SELECT 
	SUBSTRING('abcdefghikl' FROM 5 FOR 3) as sub_string;


SELECT 
	SUBSTRING('abcdefghikl' FROM 5) as sub_string;


SELECT job_title
FROM staff
WHERE job_title LIKE 'Assistant%';


/* We want to extract job category from the assistant position which starts with word Assisant */
SELECT 
	SUBSTRING(job_title FROM LENGTH('Assistant')+1) AS job_category,
	job_title
FROM staff
WHERE job_title LIKE 'Assistant%';


/* As there are several duplicated ones, we want to know only unique ones */
SELECT 
	DISTINCT(SUBSTRING(job_title FROM LENGTH('Assistant')+1)) AS job_category,
	job_title
FROM staff
WHERE job_title LIKE 'Assistant%';


---------------------- Replacing words ----------------------------------------------------

/* we want to replace word Assistant with Asst.  */
SELECT
	OVERLAY(job_title PLACING 'Asst.' FROM 1 FOR LENGTH('Assistant')) AS shorten_job_title
FROM staff
WHERE job_title LIKE 'Assistant%';


--------------------------------------------------------------------------------------------

/********* Filtering with Regualar Expressions *********/
-- SIMILAR TO

/* We want to know job title with Assistant with Level 3 and 4 */
-- we will put the desired words into group
-- Pipe character | is for OR condition 
SELECT
	job_title
FROM staff
WHERE job_title SIMILAR TO '%Assistant%(III|IV)';


/* now we want to know job title with Assistant, started with roman numerial I, follwed by 1 character
it can be II,IV, etc.. as long as it starts with character I 

underscore _ : for one character */

SELECT
	DISTINCT(job_title)
FROM staff
WHERE job_title SIMILAR TO '%Assistant I_';


/* job title starts with either E, P or S character , followed by any characters*/
SELECT job_title
FROM staff
WHERE job_title SIMILAR TO '[EPS]%';

--------------------------------------------------------------------------------------------

/********* Reformatting Numerics Data *********/
-- TRUNC() Truncate values Note: trunc just truncate value, not rounding value.
-- CEIL
-- FLOOR
-- ROUND

SELECT 
	department, 
	AVG(salary) AS avg_salary, 
	TRUNC(AVG(salary)) AS truncated_salary,
	TRUNC(AVG(salary), 2) AS truncated_salary_2_decimal,
	ROUND(AVG(salary), 2) AS rounded_salary,
	CEIL(AVG(salary)) AS ceiling_salary,
	FLOOR(AVG(salary)) AS floor_salary
FROM staff
GROUP BY department;





