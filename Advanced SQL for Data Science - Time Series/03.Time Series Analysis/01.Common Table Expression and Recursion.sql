/************ Common Table Expression and Recursion *************/

/* CTE is basically a way of creating Temporary Table */

/* daily average temp */
WITH daily_average_temp AS(
	SELECT DATE_TRUNC('day', event_time) AS event_date,
	AVG(temp_celcius) AS avg_temp
	FROM time_series.location_temp
	GROUP BY DATE_TRUNC('day', event_time)
)
SELECT event_date, avg_temp
FROM daily_average_temp;


