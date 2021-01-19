/***** Comparison (comparing to Previous Period) ********/

-- will compare the avg temp of current day with avg temp of previous day
-- based on this, we can do comparison of month to month, year to year, etc.
WITH avg_daily_temp AS(
	SELECT 
		DATE_TRUNC('day', event_time) AS event_day,
		AVG(temp_celcius) AS avg_temp
		FROM time_series.location_temp
		GROUP BY DATE_TRUNC('day', event_time)
)
SELECT 
	d1.event_day, d1.avg_temp,
	(SELECT d2.avg_temp 
	 FROM avg_daily_temp d2
	 WHERE d2.event_day = d1.event_day - INTERVAL '1' day)
FROM avg_daily_temp d1;
