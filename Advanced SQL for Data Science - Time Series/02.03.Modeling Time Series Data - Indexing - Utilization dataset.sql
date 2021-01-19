/*********** Partitioning Data (using Utilization data set) ****************/

-- Load data from text file
COPY time_series.utilization(
	event_time,server_id, cpu_utilization, free_memory, session_cnt
) FROM 'C:\temp-sql\utilization.txt' DELIMITER ',';


-- check data
SELECT * FROM time_series.utilization
LIMIT 5;



/* average CPU utilization by server id : cost - 3687.71*/
EXPLAIN SELECT server_id, AVG(cpu_utilization)
FROM time_series.utilization
WHERE event_time BETWEEN '2019-03-05' AND '2019-03-06'
GROUP BY server_id;


------------ we will create index to speed things up ---------------

-- 1) index of event time, server id
CREATE INDEX idx_event_time_utilization
ON time_series.utilization(event_time, server_id);

/* after indexing cost - 3651.71*/
EXPLAIN SELECT server_id, AVG(cpu_utilization)
FROM time_series.utilization
WHERE event_time BETWEEN '2019-03-05' AND '2019-03-06'
GROUP BY server_id;

DROP INDEX time_series.idx_event_time_utilization;


-- 2) index of server id, event time (switch order)
CREATE INDEX idx_server_event_utilization
ON time_series.utilization(server_id, event_time);


/* 
now the index is not even used - 3687.71

Notice that when event time is in second column to be indexed. 
So with only index being server_id as first then by event_time, we wouldn't able to use index at all.
*/
EXPLAIN SELECT server_id, AVG(cpu_utilization)
FROM time_series.utilization
WHERE event_time BETWEEN '2019-03-05' AND '2019-03-06'
GROUP BY server_id;