/************* Materialized Views **************/

/* 
if we check on Database > specific Database? Schema > Materialized Views >
there may not be anything if don't have exsisting one.
*/

-- Create new materialized view
CREATE MATERIALIZED VIEW mv_staff AS(
	SELECT s.last_name, s.department, s.job_title, cr.company_regions
	FROM staff s
	JOIN company_regions cr ON cr.region_id = s.region_id
);


-- get data from materialized view
SELECT * FROM mv_staff LIMIT 10;


------------- Limitation of Materialized Views -----------
/*
If there is any changes to source table (in this case staff and company_regions),
our materialzed views data won't be refelected automatically. So data will become stale over time.
Thus, we need to refresh data on materialized view.
*/


------------ Refershing Materialized Views -----------------
/* 
this will rebuild the entire table and repopulate the data.
so we need to consider carefully how often we want to refresh it and may want to space out the frequency.
*/

REFRESH MATERIALIZED VIEW mv_staff;






