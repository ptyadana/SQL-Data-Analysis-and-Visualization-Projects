/********************** Percentiles ********************************************/
/*

Percentiles : One hundreds equal groups; population divided across group
Percentiles help us understand the distribution of data by grouping values into equal sized buckets.

Discrete Percentile: returns value that exists in the column.
Discrete Percentile is very useful whey you want to know the value in the column, that falls into a percentile.

Continuous Percentile: interpolates the boundary value between the percentiles.
Continuous Percentile is very useful when you want to know what is the value at the boundary between two percentile buckets.

Differences between Discrete and Continuous Percentile : 
- http://mfzahirdba.blogspot.com/2012/09/difference-between-percentilecont-and.html 
- https://stackoverflow.com/questions/23585667/percentile-disc-vs-percentile-cont

*/


SELECT * FROM store_sales
LIMIT 5;

/* What are the top sales data ? */
/* Data Interpretion: 
it seems like top sales are coming from 12 month, which is not suprising due to seasonality trend of holidays */
SELECT *
FROM store_sales
ORDER BY revenue DESC
LIMIT 10;

/* What about average of sales ? */
/* the average revenue is about 5806.16$ but it doesn't tell us the full story, like
- Are there many days with low sales?
- Are there many days with high sales? 
- or our sales evenly distributed across all days?
*/
SELECT AVG(revenue)
FROM store_sales;

/****** we can use percentiles to answer above question and understand our data distributions *******/


					/*** Percentile Discrete Function ***/
					
/* get 50 percentile of revenue, it seem like 50 percentile of revenue 5856$
is not too far off from the average sales 5806.16$*/
SELECT 
	PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY revenue) AS pct_50_revenue
FROM store_sales;


/* let's look at 50th, 60th , 90th , 95th percentiles */
SELECT
	PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY revenue) AS pct_50_revenues,
	PERCENTILE_DISC(0.6) WITHIN GROUP(ORDER BY revenue) AS pct_60_revenues,
	PERCENTILE_DISC(0.9) WITHIN GROUP(ORDER BY revenue) AS pct_90_revenues,
	PERCENTILE_DISC(0.95) WITHIN GROUP(ORDER BY revenue) AS pct_95_revenues
FROM store_sales;


					/*** Percentile Continuous Function ***/

SELECT 
	PERCENTILE_CONT(0.95) WITHIN GROUP(ORDER BY revenue) AS pct_95_cont_revenues,
	PERCENTILE_DISC(0.95) WITHIN GROUP(ORDER BY revenue) AS pct_95_disc_revenues
FROM store_sales;



