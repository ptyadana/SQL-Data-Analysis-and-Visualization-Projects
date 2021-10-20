/*
Mock Interview 1)

-- table name: post_events

-- user_id int
-- created_at datetime
-- event_name varchar
-- (event, post, cancel)


Question: What information would you like to start off by pulling to get an overall understanding of 
the post feature?


Possible Answer:
We might want to get an idea of OVERALL HEALTH. 
+ Total number of posts (number of enters)
+ Posts Made by Date
+ Success Rate
+ Cancel Rate

*/


/***** Success Rate *****/
-- success rate by date
-- date | success rate = number of posts / number of enters

-- explaination in english
-- group by date
-- count of number of posts / count of number enters

SELECT created_at, 
	COUNT(CASE WHEN event_name = 'post' 1 ELSE null END) * 1.00 / 
	COUNT (CASE WHEN event_name = 'enter' 1 ELSE null END) * 100 AS percent_success
FROM post_events
GROUP BY created_at
ORDER BY created_at;


/*
Question: When sucess rates are low, how can we diagonis the issue?

Possible Answer: There can be several approach to this problem. But one possible way is we can take a look at the map
out between created_at and success_rate. And see whether there is a pattern during a certain period of time.
This can be one off dip, etc. Based on this information, we can take a further look at if there is any underlying
issue in the application or not. Or if there is any potential group of users who are causing this kind of unsccessful posts.
*/


/*
Questions: 

What are the success rates by day?

Which day of the week has the lowest success rate?
*/

-- group by dow of created_date
-- average of perc_success
-- order by per_success
-- day | per_sucess 

WITH created_events AS(
	SELECT created_at, 
		COUNT(CASE WHEN event_name = 'post' 1 ELSE null END) * 1.00 / 
		COUNT (CASE WHEN event_name = 'enter' 1 ELSE null END) * 100 AS percent_success
	FROM post_events
	GROUP BY created_at
	ORDER BY created_at)

SELECT EXTRACT (dow FROM created_at) AS dow,
AVG(percent_success)
FROM created_events
GROUP BY 1
ORDER BY 2 ASC;


/*
Question: What could be a problem if we're aggregating on percent success?

Possible Answer: this can lead to a problem that we're not taking into consideration of underlying distribution
of percent success across the dates.
*/


SELECT EXTRACT (dow FROM created_at) AS dow,
	COUNT(CASE WHEN event_name = 'post' 1 ELSE null END) * 1.00 / 
	COUNT (CASE WHEN event_name = 'enter' 1 ELSE null END) * 100 AS percent_success
FROM created_events
GROUP BY 1
ORDER BY 2 ASC;

/*************************** Using actual table *******************************/

SELECT *
FROM interviews.post_events
LIMIT 10;

SELECT EXTRACT (dow FROM created_at) AS dow,
	COUNT(CASE WHEN event_name = 'post' THEN 1 ELSE null END) * 1.00 / 
	COUNT (CASE WHEN event_name = 'enter' THEN 1 ELSE null END) * 100 AS percent_success
FROM interviews.post_events
GROUP BY 1
ORDER BY 2 ASC;