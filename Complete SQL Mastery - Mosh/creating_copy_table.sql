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