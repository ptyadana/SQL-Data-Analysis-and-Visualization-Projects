/******** Commonly Used Functions for Time Series ***********/

/* we will assume last digit of server_id is department id */
CREATE VIEW time_series.vw_utilization AS(
	SELECT *, server_id % 10 AS dept_id
	FROM time_series.utilization
);

SELECT * FROM time_series.vw_utilization
LIMIT 5;



--------------------- LEAD() function ---------------------------
-- LEAD() looks forwards and allows us to compare condition with the next nth row of current row.
-- we can also put offset of how many next rows we want to get.

-- next 1 row
SELECT dept_id, server_id, cpu_utilization,
	LEAD(cpu_utilization) OVER (PARTITION BY dept_id ORDER BY cpu_utilization DESC)
FROM time_series.vw_utilization
WHERE event_time BETWEEN '2019-03-05' AND '2019-03-06';

-- next 3 row
SELECT dept_id, server_id, cpu_utilization,
	LEAD(cpu_utilization, 3) OVER (PARTITION BY dept_id ORDER BY cpu_utilization DESC)
FROM time_series.vw_utilization
WHERE event_time BETWEEN '2019-03-05' AND '2019-03-06';
