/*****************************************/
/*  Creating Views                       */
/*****************************************/

USE mosh_sql_invoicing;

CREATE VIEW v_sales_by_client AS (
	SELECT c.client_id, c.name, SUM(invoice_total) AS total_sales
	FROM clients c
	JOIN invoices i USING (client_id)
	GROUP BY client_id, name
);

SELECT *
FROM v_sales_by_client;

/*view to see the balance for each client.*/
CREATE OR REPLACE VIEW v_clients_balance AS (
	SELECT c.client_id, c.name, SUM(i.invoice_total - i.payment_total) AS balance
	FROM clients c
	JOIN invoices i ON c.client_id = i.client_id
	GROUP BY 1
);

/*****************************************/
/*  Altering or Dropping Views           */
/*****************************************/

DROP VIEW v_sales_by_client;

CREATE OR REPLACE VIEW v_clients_balance AS (
	SELECT c.client_id, c.name, SUM(i.invoice_total - i.payment_total) AS balance
	FROM clients c
	JOIN invoices i ON c.client_id = i.client_id
	GROUP BY 1
);


/*****************************************/
/*  Updatable  Views                     */
/*****************************************/

CREATE VIEW v_invoices_with_remaining_balance AS (SELECT invoice_id, number, client_id, invoice_total, payment_total,
	invoice_total - payment_total AS remaining_balance,
	invoice_date, due_date, payment_date
FROM invoices);

SELECT * FROM v_invoices_with_remaining_balance;

-- delete
DELETE FROM v_invoices_with_remaining_balance
WHERE invoice_id = 1;

-- update 
UPDATE v_invoices_with_remaining_balance
SET due_date = '2020-01-01'
WHERE invoice_id = 2; 


/*****************************************/
/*  WITH OPTION CHECK Clause             */
/*****************************************/
/*To ensure the consistency of a view so that users can only display or update data that visible through the view, 
you use the WITH CHECK OPTION when you create or modify the view.*/

CREATE OR REPLACE VIEW v_invoices_with_remaining_balance AS (SELECT invoice_id, number, client_id, invoice_total, payment_total,
	invoice_total - payment_total AS remaining_balance,
	invoice_date, due_date, payment_date
FROM invoices
WHERE (invoice_total - payment_total) > 0
) WITH CHECK OPTION;

SELECT * FROM v_invoices_with_remaining_balance;

UPDATE v_invoices_with_remaining_balance
SET payment_total = invoice_total
WHERE invoice_id = 2; 