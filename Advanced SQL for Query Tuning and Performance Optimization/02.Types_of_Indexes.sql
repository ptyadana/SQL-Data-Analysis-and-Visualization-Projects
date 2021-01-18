/***************** Types of Indexes ************************/
/*
B-tree indexes
Bitmap indexes
Hash indexes
PostgreSQL specific indexes
*/



/************** B-tree Indexing (Binary Tree Indexing) ******************/

-- check on full table scan
EXPLAIN SELECT * FROM staff
WHERE email = 'bphillips5@time.com';


-- create index
CREATE INDEX idx_email ON staff(email);

EXPLAIN SELECT * FROM staff
WHERE email = 'bphillips5@time.com';


/******************** Bit Map Indexing *********************/

-- get all unique job titles
SELECT DISTINCT(job_title)
FROM staff
ORDER BY job_title;


EXPLAIN SELECT *
FROM staff
WHERE job_title = 'Operator';

-- create index
CREATE INDEX idx_staff_job_title ON staff(job_title);


/* 
now we can see query plan is used Bitmap Heap Scan using Bitmap index 
In postgreSQL, we don't need to explicty create bitmap index. 
postgreSQL will create on the fly if it finds situation if bitmap index is needed.
*/
EXPLAIN SELECT *
FROM staff
WHERE job_title = 'Operator';


/************** Hash Index ******************/

-- create index
CREATE INDEX idx_staff_email ON staff USING HASH(email);

EXPLAIN SELECT * FROM staff
WHERE email = 'bphillips5@time.com';


/************** PostgreSQL specific indexes ******************/
/*
GIST
SP-GIST
GIN
BRIN
*/