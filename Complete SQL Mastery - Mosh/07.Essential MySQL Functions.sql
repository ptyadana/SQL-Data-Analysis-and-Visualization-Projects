/****************************************/
/*     Numeric Functions                */
/****************************************/

SELECT ROUND(7.58,1);

SELECT TRUNCATE(7.58374,3);

SELECT CEILING (7.58374);
SELECT CEILING (7.1);

SELECT FLOOR(7.6);

SELECT ABS(-5.4);

SELECT RAND();

/****************************************/
/*     String Functions                 */
/****************************************/

SELECT LENGTH('hello');

SELECT UPPER('hello');

SELECT lower('Hello');

SELECT LTRIM('    Hello');

SELECT RTRIM('Hello    ');

SELECT TRIM('     I am so AWESOME!    ');

SELECT LEFT('Kindergarten',4);

SELECT RIGHT('Kindergarten',6);

SELECT SUBSTRING('Kindergarten', 3, 5);

SELECT LOCATE('n', 'Kindergarten');

SELECT LOCATE('y', 'Kindergarten');
SELECT LOCATE('garten', 'Kindergarten');

SELECT REPLACE('Kindergarten', 'garten', 'garden');

SELECT CONCAT('John', ' ' ,'Snow');

/****************************************/
/*     Date Functions                  */
/****************************************/
SELECT NOW(), CURDATE(), CURTIME(), YEAR(NOW()), MONTH(NOW()), DATE(NOW()), 
	DAYNAME(NOW()), MONTHNAME(NOW());
    
SELECT EXTRACT(DAY FROM NOW()), EXTRACT(MONTH FROM NOW()), EXTRACT(YEAR FROM NOW());

USE mosh_sql_store;

SELECT *
FROM orders
WHERE YEAR(order_date) > YEAR(NOW());

/****************************************/
/*     Formatting Date Times            */
/****************************************/

SELECT DATE_FORMAT(NOW(), '%D %M %Y');

SELECT DATE_FORMAT(NOW(), '%d %m %y');

SELECT TIME_FORMAT(NOW(), '%H %m %p');

/****************************************/
/*     Calcualting Date Times           */
/****************************************/

-- add 1 day
SELECT DATE_ADD(NOW(), INTERVAL 1 DAY);

-- subtract 1 year
SELECT DATE_ADD(NOW(), INTERVAL -1 YEAR);

SELECT DATEDIFF('2019-01-01', '2020-01-01');

-- number of seconds since Mid Night
SELECT TIME_TO_SEC('09:00') - TIME_TO_SEC('09:02');

/****************************************/
/*     IFNULL AND COALESCE              */
/****************************************/

USE mosh_sql_store;

SELECT order_id, customer_id, order_date, status,
	IFNULL(shipped_date,'NOT ASSIGNED') AS shipped_date,
    COALESCE(shipper_id, comments, 'PENDING') AS shipper
FROM orders;

/* customer name, phone*/
SELECT CONCAT(first_name, ' ', last_name) AS customer_name,
	COALESCE(phone,'UNKNOWN') AS phone
FROM customers;


/****************************************/
/*     IF function                      */
/****************************************/
/*
   IF (expression, first, second)
*/

SELECT order_id, order_date,
	IF(YEAR(order_date) >= YEAR(NOW()), 'Active', 'Archived') AS status
FROM orders;

/* product and its ordered frequncy category */
SELECT p.product_id, p.name, COUNT(p.product_id) AS times_of_orders,
	IF(COUNT(p.product_id) > 1, 'Many times', 'Once') AS frequency_category
FROM products p
JOIN order_items oi ON oi.product_id = p.product_id
GROUP BY 1;

/****************************************/
/*     CASE function                    */
/****************************************/

SELECT order_id, order_date,
	CASE
		WHEN YEAR(order_date) >= YEAR(NOW()) THEN 'Active'
        WHEN YEAR(order_date) = YEAR(DATE_ADD(NOW(), INTERVAL -1 YEAR)) THEN 'Last Year'
        ELSE 'Archived'
    END AS status
FROM orders;