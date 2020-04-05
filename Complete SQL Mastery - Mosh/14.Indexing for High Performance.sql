/*****************************************/
/*           INDEXES                     */
/*****************************************/

/*
Cost of Indexes
- increase the database
- slow down the writes
- thus, should only reserves for perfromance critical queries

IMPORTANT: design index based on quries, not based on tables
*/


/*****************************************/
/*   Creating the index                  */
/*****************************************/
USE mosh_sql_store;

-- check out TYPE and ROWS from explain result. This represents how many rows mysql has to check to get the result. ALL is full table scan.
EXPLAIN SELECT customer_id FROM customers WHERE state = 'CA';

CREATE INDEX i_state
ON customers(state);

/* find customers with more than 1000 points */
EXPLAIN SELECT customer_id FROM customers WHERE points > 1000;

CREATE INDEX i_points
ON customers(points);

/*****************************************/
/*   Viewing the index                   */
/*****************************************/

-- ususally use this to calculate and get the correct analysis on table
ANALYZE TABLE customers;

-- Collation A means acending, Cardinalty means number of unique indexes
SHOW INDEXES IN customers;

SHOW INDEXES IN orders;


/*****************************************/
/*   Indexing on strings                 */
/*****************************************/

/*
String columns: CHAR, VARCHAR, TEXT, BLOB
*/

/* how to quickly check optimal value to set for prefix string*/
SELECT 
	COUNT(DISTINCT LEFT(last_name,1)),
    COUNT(DISTINCT LEFT(last_name,5)),
    COUNT(DISTINCT LEFT(last_name,10))
FROM customers;

-- 20 means first 20 characters of last name. For Text and Blob, this parameter is mandatory
CREATE INDEX i_last_name
ON customers(last_name(20));


/*****************************************/
/*   Full Text Indexes                   */
/*****************************************/
USE sql_blog;

CREATE FULLTEXT INDEX idx_title_body
ON posts(title,body);

-- MATCH(columns) must matched with index columns
SELECT *, MATCH(title,body) AGAINST('react redux') AS relavency_scores
FROM posts
WHERE MATCH(title,body) AGAINST('react redux');

-- boolean mode in minus redux and add form
SELECT *
FROM posts
WHERE MATCH(title,body) AGAINST('react -redux +form' IN BOOLEAN MODE);

-- exact string
SELECT *
FROM posts
WHERE MATCH(title,body) AGAINST('"handling a form"' IN BOOLEAN MODE);


/*****************************************/
/* Composite Indexes : multiple columns  */
/*****************************************/
USE mosh_sql_store;

DROP INDEX idx_state_points ON customers;

SHOW INDEXES IN customers;

CREATE INDEX idx_state_points ON customers(state,points);

EXPLAIN SELECT * FROM customers
WHERE state = 'CA' AND points > 1000;

/*****************************************/
/* Index for Sorting                     */
/*****************************************/
SELECT * FROM customers
ORDER BY first_name;

SHOW STATUS LIKE 'last_query_cost';

/*
for (a,b) index => MySQL can use that index for searching
	- a
	- a,b
    - a DESC, b DESC
    - b
otherwise, the cost will be expensive even though there is an index
*/

