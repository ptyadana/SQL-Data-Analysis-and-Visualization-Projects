/******************************************/
/*      Aggregate Data                    */
/******************************************/
/*
	MIN()
	MAX()
    AVG()
    SUM()
    COUNT()
*/

USE mosh_sql_invoicing;

SELECT MIN(invoice_total) AS lowest, MAX(invoice_total) AS highest, 
	AVG(invoice_total) AS average, SUM(invoice_total) AS total, 
    COUNT(invoice_total) AS number_of_invoices,
    COUNT(payment_date) AS number_of_payment
FROM invoices;

/*date-range, total-sales, total-payments, what-we-expect*/
SELECT 'First half of 2019' AS date_range, SUM(invoice_total) AS total_sales, SUM(payment_total) AS total_payment, 
	SUM(invoice_total) - SUM(payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-06-30'
UNION
SELECT 'Second half of 2019' AS date_range, SUM(invoice_total) AS total_sales, SUM(payment_total) AS total_payment, 
	SUM(invoice_total) - SUM(payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-07-01' AND '2019-12-31'
UNION
SELECT 'TOTAL' AS date_range, SUM(invoice_total) AS total_sales, SUM(payment_total) AS total_payment, 
	SUM(invoice_total) - SUM(payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-12-31';


/******************************************/
/*      GROUP BY & HAVING                 */
/******************************************/

/*total payment by date*/
SELECT p.date, pm.name, SUM(p.amount) AS total_payments
FROM payments p
JOIN payment_methods pm ON pm.payment_method_id = p.payment_method
GROUP BY 1
ORDER BY 1;


/*get customers located in Virginia who have spent more than $100 */
USE mosh_sql_store;

SELECT c.customer_id, c.first_name,c.last_name,c.state, SUM(oi.quantity * oi.unit_price) AS total_spending
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
WHERE c.state LIKE 'VA'
GROUP BY 1
HAVING total_spending > 100;


/******************************************/
/*      ROLL UP                           */
/******************************************/

SELECT state,city, SUM(invoice_total) AS total_sales
FROM invoices
JOIN clients USING (client_id)
GROUP BY 1,2 WITH ROLLUP;

/*roll up with payment method*/
SELECT pm.name AS payment_method, SUM(amount) AS total
FROM payments p
JOIN payment_methods pm ON p.payment_method = pm.payment_method_id
GROUP BY 1 WITH ROLLUP;