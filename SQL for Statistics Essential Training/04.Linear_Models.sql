/***************** Linear Models ****************/

/* Linear Model such as regression are useful for estimating values for business.
Such as: We just run an advertising campaign and expect to sell more items than usual.
How many employees should we have working?
*/

/*********** Computing Intercept (employee shifts on y-axis and units sold in x-asis) *********/
/* Result: 2.64581850 */
SELECT
	REGR_INTERCEPT(employee_shifts, units_sold)
FROM store_sales;


/* What about we want to know number of units sold based on the the employees on shift? */
SELECT
	REGR_INTERCEPT(units_sold, employee_shifts)
FROM store_sales;


/* ---------------------------------------------------------------------- */

/*********** Computing Slope (employee shifts on y-axis and units sold in x-asis) *********/
/* Result: 0.003076239751 */
SELECT
	REGR_SLOPE(employee_shifts, units_sold)
FROM store_sales;

/* ---------------------------------------------------------------------- */

/* 
Linear Regression: y=mx+b

The ultimate question: How many employees we should have working to accomodate the sales of 1,500 items? 
*/
SELECT
	REGR_SLOPE(employee_shifts, units_sold) * 1500 + REGR_INTERCEPT(employee_shifts, units_sold) AS estimated_employees
FROM store_sales;

/*
Based on the results, we expect to have 7.26 (around 7 employees) to handle to sales of 1,500 items.
*/




