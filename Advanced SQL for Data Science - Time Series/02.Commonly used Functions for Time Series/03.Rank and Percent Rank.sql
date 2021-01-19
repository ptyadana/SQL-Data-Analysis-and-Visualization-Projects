---------------------  RANK ()  ---------------------------

-- we use Rank() when we want to know the relative oder of particular rows relative to other rows. (such as 1, 2, 3, etc.)
-- the ranking 1, 2, 3 will restart when it reaches to another unique group.
-- works same as Row_Number Function


SELECT dept_id, server_id, cpu_utilization,
	RANK() OVER (PARTITION BY dept_id ORDER BY cpu_utilization DESC)
FROM time_series.vw_utilization
WHERE event_time BETWEEN '2019-03-05' AND '2019-03-06';


---------------------  PERCENT_RANK ()  ---------------------------
-- it is the rank divided by total numbers of rows (example: 0.0002, etc)

SELECT dept_id, server_id, cpu_utilization,
	PERCENT_RANK() OVER (PARTITION BY dept_id ORDER BY cpu_utilization DESC)
FROM time_series.vw_utilization
WHERE event_time BETWEEN '2019-03-05' AND '2019-03-06';



