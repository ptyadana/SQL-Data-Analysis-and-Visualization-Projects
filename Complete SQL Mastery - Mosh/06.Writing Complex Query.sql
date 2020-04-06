/*************************************/
/* Subqueries                        */
/**************************************/

/* products that are more expensive than lettuce */
USE mosh_sql_store;

SELECT *
FROM products
WHERE unit_price > (
	SELECT unit_price FROM products
    WHERE name REGEXP('lettuce')
);

/* find employees who earn more than average */
USE mosh_sql_hr;

SELECT *
FROM employees
WHERE salary > (
	SELECT AVG(salary) FROM employees
);


/*************************************/
/* IN                                 */
/**************************************/

USE mosh_sql_store;

/* products that have never been ordered*/
SELECT p.product_id, p.name, oi.order_id
FROM products p
LEFT JOIN order_items oi ON oi.product_id = p.product_id
WHERE oi.product_id IS NULL;

SELECT p.product_id, p.name
FROM products p
WHERE p.product_id NOT IN(
	SELECT DISTINCT product_id
    FROM order_items
);

/* find clients without invoices */
USE mosh_sql_invoicing;

SELECT *
FROM clients
WHERE client_id NOT IN (
	SELECT DISTINCT client_id
    FROM invoices
);

/*************************************/
/* Subqueries Vs Joins               */
/**************************************/

/*customers who have ordered lettuce*/
SELECT DISTINCT c.customer_id, c.first_name, c.last_name
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
WHERE p.name LIKE '%lettuce%';


/*************************************/
/* ALL keyword                       */
/*************************************/
/*invoices larger than invoices of client 3*/
USE mosh_sql_invoicing;

SELECT *
FROM invoices
WHERE invoice_total > ALL (
	SELECT invoice_total FROM invoices
    WHERE client_id = 3
);


SELECT *
FROM invoices
WHERE invoice_total > (
	SELECT MAX(invoice_total) FROM invoices
    WHERE client_id = 3
);

/*************************************/
/* ANY keyword                       */
/*************************************/
/*clients with at least 2 invoices*/
SELECT *
FROM clients
WHERE client_id = ANY (
	SELECT client_id
    FROM invoices
    GROUP BY client_id
    HAVING COUNT(client_id) >= 2
);


/*************************************/
/*  Correlated Subqueries            */
/*************************************/

/*employees whose salary is above the average in their office*/
USE mosh_sql_hr;

SELECT *
FROM employees e
WHERE salary > (
	SELECT AVG(salary)
    FROM employees
    WHERE office_id = e.office_id
    GROUP BY office_id
);

/*client's own invoices that are larger than client's average invoice amount*/
USE mosh_sql_invoicing;

SELECT *
FROM invoices i
WHERE invoice_total > (
	SELECT AVG(invoice_total)
    FROM invoices
    WHERE client_id = i.client_id
);

/***********************************************************************************/
/*  EXISTS Operator                                                                 */
/* if result set of sub queries is too large, we better use EXISTS rather than IN   */
/***********************************************************************************/

/*clients that have an inovice*/
SELECT *
FROM clients c
WHERE EXISTS (
	SELECT client_id
    FROM invoices
    WHERE client_id = c.client_id
);

/*products never been ordered */
SELECT *
FROM products p
WHERE NOT EXISTS(
	SELECT product_id
    FROM order_items
    WHERE product_id = p.product_id
);

SELECT *
FROM products p
WHERE product_id NOT IN(
	SELECT product_id
    FROM order_items
);

/*************************************/
/*  Subqueries in SELECT             */
/*************************************/
USE mosh_sql_invoicing;

SELECT client_id,name,
	(SELECT SUM(invoice_total) FROM invoices WHERE client_id = c.client_id) AS total_sales,
    (SELECT AVG(invoice_total) FROM invoices WHERE client_id = c.client_id) AS average,
    (SELECT total_sales - average) AS difference
FROM clients c;


SELECT c.client_id, c.name, SUM(i.invoice_total) AS total_sales, 
	AVG(i.invoice_total) AS average, SUM(i.invoice_total) - AVG(i.invoice_total) AS difference
FROM invoices i
RIGHT JOIN clients c ON c.client_id = i.client_id
GROUP BY 1;


/*************************************/
/*  Subqueries in FROM               */
/*************************************/

SELECT * 
FROM (
	SELECT c.client_id, c.name, SUM(i.invoice_total) AS total_sales, 
	AVG(i.invoice_total) AS average, SUM(i.invoice_total) - AVG(i.invoice_total) AS difference
	FROM invoices i
	RIGHT JOIN clients c ON c.client_id = i.client_id
	GROUP BY 1
) AS tbl1
WHERE total_sales IS NOT NULL;