--------------------- Analyzing Execution Plan --------------------

/* get explaination 
EXPLAIN won't actually execute query. Instead it try to make estimation.
*/
EXPLAIN SELECT * FROM staff;

/* get details time to build the execution plan and explaination */
EXPLAIN ANALYZE SELECT * FROM staff;

/* now width is 7, which is lower than previous one*/
-- NOTE: if we are working with large amount data, we can use rows and width as a guide to understand the amount of data returned.
EXPLAIN ANALYZE SELECT last_name FROM staff;


/* As EXPLAIN just make estimation, rows=xxx sometimes a bit off by 1 or 2 
when we run the actual query, the rows returned are 717. but using EXPLAIN, it said 715.
*/
EXPLAIN SELECT *
FROM staff
WHERE salary > 75000;


EXPLAIN ANALYZE SELECT *
FROM staff
WHERE salary > 75000;


--------------------- Indexes --------------------

/* create index on salary column*/
CREATE INDEX idx_staff_salary ON staff(salary);


/* list all indexes*/
SELECT
    tablename,
    indexname,
    indexdef
FROM
    pg_indexes
WHERE
    schemaname = 'public'
ORDER BY
    tablename,
    indexname;


/* compare against full table scan (without index) and using indexes */

EXPLAIN SELECT * FROM staff;

/*  
when we check the query plan, we can see full table scan is used instead of using index
the reason is the criteria is fulfilled on many rows and system decided to use full table scan instead of using index.
*/
EXPLAIN ANALYZE SELECT * FROM staff WHERE salary > 75000;

/* here index is used because salary cut off criteria is much more selective */
EXPLAIN ANALYZE SELECT * FROM staff WHERE salary > 150000;
