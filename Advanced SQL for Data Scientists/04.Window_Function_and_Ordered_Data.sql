/******** Windows Functions and Ordered Data ************/

-- allows us to make sql statements about rows that are related to current row during processing.
-- somewhat similar to Sub Query.


--------------------- OVER (PARTITION BY) ---------------------------

/* employee salary vs average salary of his/her department */
SELECT 
	department, 
	last_name, 
	salary,
	AVG(salary) OVER (PARTITION BY department)
FROM staff;


/* employee salary vs max salary of his/her department */
SELECT 
	department, 
	last_name, 
	salary,
	MAX(salary) OVER (PARTITION BY department)
FROM staff;


/* employee salary vs min salary of his/her Company Region */
SELECT 
	company_regions, 
	last_name, 
	salary,
	MIN(salary) OVER (PARTITION BY company_regions)
FROM vw_staff_div_reg;



---------------------  FIRST_VALUE()  ---------------------------
-- FIRST_VALUE returns first value of the partition conditions, in this case decending order of salary group by department

SELECT
	department,
	last_name,
	salary,
	FIRST_VALUE(salary) OVER (PARTITION BY department ORDER BY salary DESC)
FROM staff;


/* this is same as above one, but above query is much cleaner and shorter */
SELECT
	department,
	last_name,
	salary,
	MAX(salary) OVER (PARTITION BY department)
FROM staff
ORDER BY department ASC, salary DESC;

---------------

/* compare with the salary of person whose last name is in ascenidng in that department */
SELECT
	department,
	last_name,
	salary,
	FIRST_VALUE(salary) OVER (PARTITION BY department ORDER BY last_name ASC)
FROM staff;


---------------------  RANK ()  ---------------------------

-- give the rank by salary decending oder withint the specific department group.
-- the ranking 1, 2, 3 will restart when it reaches to another unique group.
-- works same as Row_Number Function
SELECT
	department,
	last_name,
	salary,
	RANK() OVER (PARTITION BY department ORDER BY salary DESC)
FROM staff;



---------------------  ROW_NUBMER ()  ---------------------------
-- same as above
SELECT
	department,
	last_name,
	salary,
	ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC)
FROM staff;	
	

--------------------- LAG() function ---------------------------
-- to reference rows relative to the currently processed rows.
-- LAG() allows us to compare condition with the previous row of current row.

/* we want to know person's salary and next lower salary in that department */
/* that is an additional column LAG. First row has no value because there is no previous value to compare.
So it continues to next row and lag value of that second row will be the value of previous row, etc.
It will restart again when we reache to another department.
*/
SELECT 
	department,
	last_name,
	salary,
	LAG(salary) OVER(PARTITION BY department ORDER BY salary DESC)
FROM staff;



--------------------- LEAD() function ---------------------------
-- opposite of LAG()
-- LEAD() allows us to compare condition with the next row of current row.
-- now the last line of that department's LEAD value is empty because there is no next row value to compare.
SELECT 
	department,
	last_name,
	salary,
	LEAD(salary) OVER(PARTITION BY department ORDER BY salary DESC)
FROM staff;


--------------------- NTILE(bins number) function ---------------------------
-- allows to create bins/ bucket

/* there are bins (1-10) assigned each employees based on the decending salary of specific department
and bin number restart for another department agian */
SELECT 
	department,
	last_name,
	salary,
	NTILE(10) OVER(PARTITION BY department ORDER BY salary DESC)
FROM staff;

