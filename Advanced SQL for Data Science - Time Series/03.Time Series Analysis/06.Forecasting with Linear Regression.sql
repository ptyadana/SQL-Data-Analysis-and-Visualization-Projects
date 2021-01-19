/************ Forecasting with Linear Regression **************/

/* 

so far, we have been working with past data.
Now we want to make future predictions based on those past data using Linear Regression.

y=mx + b
m: slope
b: y intercept
y: predicted value
x: input value

Let's try and predict the amount of free memory will be available given a particular CPU utilization.
*/

-- first we will find m and b values : m = -0.46684018640161745, b = 0.6664934543856621 
SELECT
	REGR_SLOPE(free_memory, cpu_utilization) AS m,
	REGR_INTERCEPT(free_memory, cpu_utilization) AS b
FROM time_series.utilization
WHERE event_time BETWEEN '2019-03-05' AND '2019-03-06';


-- let's say we want to predict free memory based on 65% CPU utilization
-- we predicted 0.36304733322461075 (about 36% of free memory)
SELECT
	REGR_SLOPE(free_memory, cpu_utilization) * 0.65 + 
	REGR_INTERCEPT(free_memory, cpu_utilization) AS b
FROM time_series.utilization
WHERE event_time BETWEEN '2019-03-05' AND '2019-03-06';





