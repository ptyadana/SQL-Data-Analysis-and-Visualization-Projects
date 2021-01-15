/* check first 10 rows */
SELECT * FROM store_sales
LIMIT 10;

/* check how many rows */
SELECT COUNT(*)
FROM store_sales;

/* how many rows in each month */
SELECT month_of_year, COUNT(*) AS total
FROM store_sales
GROUP BY month_of_year
ORDER BY month_of_year ASC;

/* maximum number of employees during any shift of the year */
SELECT MAX(employee_shifts)
FROM store_sales;

/* what is the smallest number of employees during any shift of the year */
SELECT MIN(employee_shifts)
FROM store_sales;

/* min, max together */
SELECT MAX(employee_shifts), MIN(employee_shifts)
FROM store_sales;

/* min, max employees in during per shift of the year*/
SELECT month_of_year, MAX(employee_shifts), MIN(employee_shifts)
FROM store_sales
GROUP BY month_of_year
ORDER BY month_of_year ASC;

/******************************************************************/

/* What is the total unit sold? */
SELECT SUM(units_sold)
FROM store_sales;

/* What is the total unit sold , avg unit sold per month? */
SELECT month_of_year, SUM(units_sold) AS total_unit_sold, ROUND(AVG(units_sold), 2) AS average_unit_sold
FROM store_sales
GROUP BY month_of_year
ORDER BY month_of_year ASC;

/********************** Standard Deviation & Variance ********************************************/

/* How spread out the unit sold in each month? */
/* As we can see from the result, variance values quite high. Because variance measures in squared. 
So better way to get a sense of spread out is standard deviation */
SELECT 
	month_of_year, 
	SUM(units_sold) AS total_unit_sold, 
	ROUND(AVG(units_sold), 2) AS average_unit_sold,
	VAR_POP(units_sold) AS variance_units_sold,
	STDDEV_POP(units_sold) AS std_units_sold
FROM store_sales
GROUP BY month_of_year
ORDER BY month_of_year ASC;

/* Interpretation based on data: 
For month 1, it seems like stddev is pretty close around 3.48 across the sales.

However like month 12, it seems like stddev is very large 231.15 across the sales. 
So it seems like in some sales, many units are sold in large quanity and some sales aren't. 
So we can check whether our assumptions are correct or not */

/* When we check the data and our assumptions are correct.
* for 12 month, lowest sales is 0 and largest sale is 879 which leads to large value of stddev.*/ 
SELECT 
	month_of_year, 
	MIN(units_sold),
	MAX(units_sold)
FROM store_sales
GROUP BY month_of_year
ORDER BY month_of_year ASC;

