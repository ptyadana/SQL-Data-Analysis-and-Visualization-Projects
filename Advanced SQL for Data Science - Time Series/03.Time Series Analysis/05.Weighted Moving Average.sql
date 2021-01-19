/********* Weighted Moving Average ************/

/*
The idea is you want to give MORE weight to the MORE RECENT events than the past events.

We want to weight the average temp of last 3 days. so we need to sum up of those last 3 days.
*/
WITH daily_avg_temp AS (
	SELECT
		DATE_TRUNC('day', event_time) as event_date,
		ROUND(AVG(temp_celcius),2) AS avg_temp
	FROM time_series.location_temp
	GROUP BY DATE_TRUNC('day', event_time)
)
SELECT
	event_date, avg_temp,
	(SELECT ROUND(avg_temp,2) * 0.5
	 FROM daily_avg_temp d2
	 WHERE d2.event_date = d1.event_date - INTERVAL '1' day
	) + 
	(SELECT ROUND(avg_temp,2) * 0.333
	 FROM daily_avg_temp d3
	 WHERE d3.event_date = d1.event_date - INTERVAL '2' day
	) +
	(SELECT ROUND(avg_temp,2) * 0.167
	 FROM daily_avg_temp d4
	 WHERE d4.event_date = d1.event_date - INTERVAL '3' day
	) AS three_days_weighted_avg_temp
FROM daily_avg_temp d1
