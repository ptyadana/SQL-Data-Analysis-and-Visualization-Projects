/********** Moving Average *************/

/* 
We want to know the hourly cpu utilization.
So we can create a sliding windows to get the average cpu utilization of 1 hour.
In hour case, each log is inserted per 5 minutes. So for 1 hour, we need to gather 12 logs (transactions).

NOTE:
OVER statements basically said order by the event time, then given the current row, go back 12 rows.
With that set of date, apply the average function.
*/

SELECT
	event_time, server_id,
	AVG(cpu_utilization) OVER (ORDER BY event_time ROWS BETWEEN 12 PRECEDING AND CURRENT ROW) AS hourly_cpu_util
FROM time_series.utilization;