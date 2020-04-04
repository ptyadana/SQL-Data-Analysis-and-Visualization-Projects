SELECT state,city, SUM(invoice_total) AS total_sales
FROM invoices
JOIN clients USING (client_id)
GROUP BY 1,2 WITH ROLLUP;

/*roll up with payment method*/
SELECT pm.name AS payment_method, SUM(amount) AS total
FROM payments p
JOIN payment_methods pm ON p.payment_method = pm.payment_method_id
GROUP BY 1 WITH ROLLUP;