/*********************************************/
/* Inserting Row(s)                          */
/*********************************************/
INSERT INTO customers
VALUES(
	DEFAULT,
    'John',
    'Smith',
    '1990-01-01',
    NULL,
    'dummy address',
    'dummy city',
    'CA',
    DEFAULT
);

/*********************************************/
/* Creating copy of a table                  */
/*********************************************/

/*
Using CREATE TABLE tbl_name AS from subquery will ignore Primary Key, Foreigin Keys and AutoIncrement.
Those info will be lost in the copied table.
*/
CREATE TABLE orders_achieved AS
	SELECT * FROM orders;
    
    
TRUNCATE orders_achieved;


INSERT INTO orders_achieved
	SELECT *
    FROM orders
    WHERE order_date < '2019-01-01';
    
    
/*copy of invoie table
with client name instead of client_id column
and with already made payment*/
USE mosh_sql_invoicing;

CREATE TABLE invoices_archieved AS
	SELECT i.invoice_id,i.number,c.name,i.invoice_total,i.payment_total,i.invoice_date,i.due_date,i.payment_date
	FROM invoices i
	JOIN clients c ON c.client_id = i.client_id
	WHERE i.payment_date IS NOT NULL;
    

/*********************************************/
/* Updating Rows                             */
/*********************************************/

SELECT * FROM orders;

UPDATE orders
SET comments = 'blah blah', order_date = '2020-04-01'
WHERE order_id = 11;

/*give any customers born before 1990 give 50 extra points*/
UPDATE customers
SET points = points + 50
WHERE YEAR(birth_date) < 1990;


USE mosh_sql_invoicing;

UPDATE invoices
SET
	payment_total = invoice_total * 0.5,
    payment_date = due_date
WHERE client_id IN (
	SELECT client_id FROM clients WHERE name LIKE 'MyWorks'
);


/*set the commments to GOLD in orders of customer where points > 3000*/
USE mosh_sql_store;

UPDATE orders
SET comments = 'GOLD'
WHERE customer_id IN(
	SELECT customer_id FROM customers
    WHERE points > 3000
);

SELECT * FROM orders;

/*********************************************/
/* Deleting Rows                             */
/*********************************************/
DELETE FROM orders
WHERE order_id = 14;