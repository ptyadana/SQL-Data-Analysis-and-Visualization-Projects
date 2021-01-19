/*********** Modeling Time Series Data *****************/


------------- Load Time Series Data --------------------
COPY time_series.location_temp(event_time, location_id, temp_celcius)
FROM 'C:/temp-sql/location_temp.txt' DELIMITER ',';


/* quick check the data */
SELECT * FROM time_series.location_temp
ORDER BY event_time
LIMIT 5;

---------------- Indexing Data ----------------------------

------ Indexing on Location -----------------
/* check avg temp of each location*/
EXPLAIN SELECT location_id, AVG(temp_celcius)
FROM time_series.location_temp
GROUP BY location_id;


/* create index and check the query execution time again */
CREATE INDEX idx_loc_location_temp
ON time_series.location_temp(location_id);

/* we can see that it is still not using index , so we will put additional where clause to narrow down */
EXPLAIN ANALYZE SELECT location_id, AVG(temp_celcius)
FROM time_series.location_temp
GROUP BY location_id;


/* now index got used (bitmap  index) */
EXPLAIN ANALYZE SELECT location_id, AVG(temp_celcius)
FROM time_series.location_temp
WHERE location_id = '2'
GROUP BY location_id;

/* let's drop index and see how the impact looks like now */
DROP INDEX time_series.idx_loc_location_temp;


EXPLAIN ANALYZE SELECT location_id, AVG(temp_celcius)
FROM time_series.location_temp
WHERE location_id = '2'
GROUP BY location_id;


------ Indexing on Event_Time and Location ID -----------------

-- 34090
EXPLAIN SELECT location_id, AVG(temp_celcius)
FROM time_series.location_temp
WHERE event_time BETWEEN '2019-03-05' AND '2019-03-06'
GROUP BY location_id;

/* create index */
CREATE INDEX idx_even_time_location_temp
ON time_series.location_temp(event_time, location_id);

/* check again and it is still not using the index */
EXPLAIN SELECT location_id, AVG(temp_celcius)
FROM time_series.location_temp
WHERE event_time BETWEEN '2019-03-05' AND '2019-03-06'
GROUP BY location_id;


/* now let's make more selective, adding hour, min , sec */
EXPLAIN SELECT location_id, AVG(temp_celcius)
FROM time_series.location_temp
WHERE event_time BETWEEN '2019-03-05 00:00:00' AND '2019-03-05 00:20:00'
GROUP BY location_id;


/* 
So in summary, Indexes are very helpful in some cases, especially when we are working with limited subset of data.
But they don't always help when we are working with larget time span. 
*/


