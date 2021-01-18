/***************** Tuning Joins *******************/

--------------- Nested Loop --------------------------------------------------

-- force query plan builder to use nested loop first, just for testing purpose
set enable_nestloop = true;
set enable_hashjoin = false;
set enable_mergejoin = false;

EXPLAIN SELECT s.id,s.last_name,s.job_title,cr.country
FROM staff s
JOIN company_regions cr
ON cr.region_id = s.region_id;


/*
We can see that builder use Nested Lop then Index Scan using primary key (region_id).
As postgreSQL automatically created index on primary key, we will delete this key (for testing purpose)
and see how Nest Loop will full table scan will look like in performance wise.
*/


EXPLAIN SELECT s.id,s.last_name,s.job_title,cr.country
FROM staff s
JOIN company_regions cr
ON cr.region_id = s.region_id;

/* we can see that Cost got increased.

So main take away is when we are using any kind of joins (especially, Nested Loop), it helps to ensure foreign keys
columns and the columns you are trying to matching on are indexed properly.
*/


--------------- Hash Join --------------------------------------------------
set enable_nestloop = false;
set enable_hashjoin = true;
set enable_mergejoin = false;


EXPLAIN SELECT s.id,s.last_name,s.job_title,cr.country
FROM staff s
JOIN company_regions cr
ON cr.region_id = s.region_id;

/*
We can see that in row 3, scanning on staff table.
in row 4, hash table is being buit.
*/

--------------- Merge Join --------------------------------------------------

set enable_nestloop = false;
set enable_hashjoin = false;
set enable_mergejoin = true;


EXPLAIN SELECT s.id,s.last_name,s.job_title,cr.country
FROM staff s
JOIN company_regions cr
ON cr.region_id = s.region_id;
















