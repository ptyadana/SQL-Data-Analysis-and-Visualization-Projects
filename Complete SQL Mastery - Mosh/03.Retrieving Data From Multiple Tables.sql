/******************************************/
/*       JOINS                            */
/******************************************/

SELECT oi.order_id,p.name,oi.quantity,oi.unit_price
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id;


/******************************************/
/*       SELF JOINS                       */
/******************************************/
USE mosh_sql_hr;

SELECT * FROM employees
LIMIT 5;

/*employee and his/her manager */
SELECT e1.employee_id, e1.first_name, e1.last_name, 
	COALESCE(CONCAT(e2.first_name,e2.last_name), 'Top Manager') AS manager
FROM employees e1
LEFT JOIN employees e2 ON e1.reports_to = e2.employee_id;


/******************************************/
/*       Joining Multiple Tables          */
/******************************************/
USE mosh_sql_store;

SELECT o.order_id, o.order_date, c.first_name, c.last_name, os.name
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
JOIN order_statuses os ON os.order_status_id = o.status;

/*payment and customer details*/
USE mosh_sql_invoicing;

SELECT c.client_id, c.name,p.invoice_id,p.date,p.amount,pm.name
FROM payments p
JOIN payment_methods pm ON pm.payment_method_id = p.payment_method
JOIN clients c ON c.client_id = p.client_id;


/******************************************/
/*       Implicit Join                    */
/******************************************/

SELECT c.client_id, c.name,p.invoice_id,p.date,p.amount,pm.name
FROM payments p, payment_methods pm, clients c
WHERE pm.payment_method_id = p.payment_method
AND c.client_id = p.client_id;

/******************************************/
/*       Outer Joins                      */
/******************************************/
USE mosh_sql_store;

SELECT c.customer_id, c.first_name,c.last_name,o.order_id
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
ORDER BY 1;

/*products and how many time it has been ordered*/
SELECT p.product_id, p.name, oi.quantity
FROM products p
LEFT JOIN order_items oi ON oi.product_id = p.product_id;

/* product which has never been ordered */
SELECT p.product_id, p.name, oi.quantity
FROM products p
LEFT JOIN order_items oi ON oi.product_id = p.product_id
WHERE oi.product_id IS NULL;

/* order, customer name, status where status is in processed or shipped */
SELECT o.order_date, o.order_id, c.first_name, s.name, os.name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN shippers s ON s.shipper_id = o.shipper_id
LEFT JOIN order_statuses os ON os.order_status_id = o.status;

/******************************************/
/*       USING                            */
/******************************************/
SELECT *
FROM order_items oi
JOIN order_item_notes oin
	USING(order_id,product_id);
    

/*client and payment methods */
USE mosh_sql_invoicing;

SELECT p.date, c.name, p.amount, pm.name
FROM payments p
JOIN clients c USING (client_id)
JOIN payment_methods pm ON pm.payment_method_id = p.payment_method;


/******************************************************************/
/*       Natural Joins                                            */
/* it allows sql engine to pick up the keys by itself for joining */
/******************************************************************/
USE mosh_sql_store;

SELECT o.order_id, c.first_name
FROM orders o
NATURAL JOIN customers c;


/******************************************************************/
/*       CORSS JOIN                                               */
/******************************************************************/
/* cross join between shippers and products using implicit and explict*/
SELECT s.name, p.name
FROM shippers s , products p;

SELECT s.name, p.name
FROM shippers s
CROSS JOIN products p;


/******************************************************************/
/*       UNION                                                    */
/******************************************************************/

SELECT *, 'Active' AS status
	FROM orders
	WHERE order_date >= CURDATE() - INTERVAL 1 YEAR
UNION
SELECT *, 'Archived' AS status
	FROM orders
	WHERE order_date < CURDATE() - INTERVAL 1 YEAR;
    

/* customer and point status */
SELECT customer_id, first_name, points,
	CASE
		WHEN points > 3000 THEN 'Gold'
        WHEN points >= 2000 AND points <= 3000 THEN 'Silver'
        ELSE 'Bronze'
    END AS type
FROM customers
ORDER BY 2;
