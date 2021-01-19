/*********** Querying Partitioned Table Data ****************/

/* 1) get the average temp of march 5, 2019*/

-- non partition version on original table: cost 34,090.84
EXPLAIN SELECT location_id, AVG(temp_celcius)
FROM time_series.location_temp
WHERE event_time BETWEEN '2019-03-05' AND '2019-03-06'
GROUP BY location_id;


-- 2) partitioned version on new table: cost 37964.20
EXPLAIN SELECT location_id, AVG(temp_celcius)
FROM time_series.location_temp_p
WHERE event_time BETWEEN '2019-03-05' AND '2019-03-06'
GROUP BY location_id;

-- 3) partitioned version on new table using event hour: cost 14,449.74
EXPLAIN SELECT location_id, AVG(temp_celcius)
FROM time_series.location_temp_p
WHERE event_hour BETWEEN 0 AND 4
GROUP BY location_id;

/*
In summary the closer WHERE clause is to our partition, the more benefit we can get from Partitioning our data.
*/












