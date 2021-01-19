/******** Commonly Used Functions for Time Series ***********/

--------------------- LAG() function ---------------------------
-- to reference rows relative to the currently processed rows.
-- LAG() looks backwards and allows us to compare condition with the previous nth row of current row.

SELECT dept_id, server_id, cpu_utilization,
	LAG(cpu_utilization) OVER (PARTITION BY dept_id ORDER BY cpu_utilization DESC)
FROM time_series.vw_utilization
WHERE event_time BETWEEN '2019-03-05' AND '2019-03-06';


-- with offset of 10, looking backwards to previous 10th row from the current one
SELECT dept_id, server_id, cpu_utilization,
	LAG(cpu_utilization, 10) OVER (PARTITION BY dept_id ORDER BY cpu_utilization DESC)
FROM time_series.vw_utilization
WHERE event_time BETWEEN '2019-03-05' AND '2019-03-06';