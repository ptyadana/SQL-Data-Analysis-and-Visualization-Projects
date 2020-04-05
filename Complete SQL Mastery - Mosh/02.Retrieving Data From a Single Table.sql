/*********************************/
/*      Reterive Data            */
/*********************************/
USE mosh_sql_store;

SELECT * FROM customers
WHERE customer_id > 5
ORDER BY first_name;

SELECT DISTINCT state
FROM customers;

/*return all the products name, unit price, new price (unit price *1.1) */
SELECT name, unit_price, (unit_price *1.1) AS new_price
FROM products;

/*********************************/
/*     Operators                 */
/*********************************/
/*
	>
	<
	>=
	<=
	!=
	<>
    AND
    OR 
    NOT
    IN
    NOT IN
    BETWEEN
    LIKE
    IS NULL
*/

/*get the orders placed this year*/
SELECT * FROM orders
WHERE order_date >= '2020-01-01';


SELECT *
FROM customers
WHERE birth_date > '1990-01-01' AND points > 1000;

SELECT *
FROM customers
WHERE NOT (birth_date > '1990-01-01' AND points > 1000);

/*
get items of order #6 where total price is greater than 30 
*/
SELECT *
FROM order_items
WHERE order_id = 6 AND quantity * unit_price > 30;


SELECT *
FROM customers
WHERE state IN ('VA','GA','FL');

SELECT *
FROM customers
WHERE state NOT IN ('VA','GA','FL');

/*return products with quanity in stock equal to 49, 38, 72*/
SELECT *
FROM products
WHERE quantity_in_stock IN (49,38,72);


SELECT *
FROM customers
WHERE points BETWEEN 1000 AND 3000;

/*return customers born between 1/1/1990 and 1/1/2000*/
SELECT *
FROM customers
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';

/*get the orders that are not shipped*/
SELECT *
FROM orders
WHERE shipped_date IS NULL;


SELECT *
FROM customers
ORDER BY last_name DESC, state ASC
LIMIT 10;

SELECT order_id, product_id, quantity, unit_price
FROM order_items
WHERE order_id = 2;

/* offset start from 2nd record */
SELECT order_id, product_id, quantity, unit_price
FROM order_items
LIMIT 5 OFFSET 2;

-- customer 5 records start from 6 for pagniation (example 1-5 for one page, 6-10 for second page...)
SELECT *
FROM customers
LIMIT 5,6;

/*get top 3 loyal customers*/
SELECT *
FROM customers
ORDER BY points DESC
LIMIT 3;

/*
	% 		any number of characters
    _		single character
*/
SELECT *
FROM customers
WHERE last_name LIKE '_____y';

SELECT *
FROM customers
WHERE last_name LIKE 'b____y';

/*get customers addresses contain TRAIL or AVENUE OR phone numbers end with 9*/
SELECT *
FROM customers
WHERE address LIKE '%TRAIL%' OR address LIKE '%AVENUE%'
OR phone LIKE '%9';


SELECT *
FROM customers
WHERE address REGEXP 'trail|avenue';

SELECT *
FROM customers
WHERE phone REGEXP '9$';

/*********************************/
/*      Regular Expressions      */
/*********************************/
SELECT *
FROM customers
WHERE last_name LIKE '%field%';

SELECT *
FROM customers
WHERE last_name REGEXP 'field';

SELECT *
FROM customers
WHERE first_name REGEXP 'I...';

/* 
^		: beginning of the string of the field
$		: end of the string
|		: either OR
[]		: includes one of these insides []. set of characters [abc] OR [a-h]
https://www.oreilly.com/library/view/mysql-cookbook/0596001452/ch04s08.html
*/
SELECT *
FROM customers
WHERE last_name REGEXP 'field$';

SELECT *
FROM customers
WHERE last_name REGEXP 'field|mac|rose';

SELECT *
FROM customers
WHERE last_name REGEXP '^field|mac|rose';

/*
ge
ie
me
includes in last name
*/
SELECT *
FROM customers
WHERE last_name REGEXP '[gim]e';

/*
ae
be
...
he
includes in last name
*/
SELECT *
FROM customers
WHERE last_name REGEXP '[a-h]e';

/*
Get the customers whose
- first names are ELKA or AMBUR
- last names end with EY or ON
- last name start with MY or contain SE
- last name contain B followed by R or U
*/
SELECT *
FROM customers
WHERE first_name REGEXP 'ELKA|AMBUR';

SELECT *
FROM customers
WHERE last_name REGEXP 'EY$|ON$';

SELECT *
FROM customers
WHERE last_name REGEXP '^MY|SE';

SELECT *
FROM customers
WHERE last_name REGEXP 'B[R|U]';