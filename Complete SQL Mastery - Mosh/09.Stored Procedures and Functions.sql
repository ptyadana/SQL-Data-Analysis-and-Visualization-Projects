/**************************************/
/* Stored Procedures                  */
/**************************************/
DELIMITER $$
CREATE PROCEDURE get_clients()
BEGIN
	SELECT * FROM clients;
END $$
DELIMITER ;

/**************************************/
/* Call Stored Procedures             */
/**************************************/
CALL get_clients();


/* get_invoices_with_balance to return all the invoices with balance > 0 */
DROP PROCEDURE IF EXISTS get_invoices_with_balance;

DELIMITER $$
CREATE PROCEDURE get_invoices_with_balance()
BEGIN
	SELECT *
	FROM invoices
	WHERE (invoice_total - payment_total) > 0;
END $$
DELIMITER ;

CALL get_invoices_with_balance();

/**************************************/
/* DROP Stored Procedures             */
/**************************************/

DROP PROCEDURE IF EXISTS get_clients;


/**************************************/
/* Parameters                         */
/**************************************/
DROP PROCEDURE IF EXISTS get_client_by_state;

DELIMITER $$
CREATE PROCEDURE get_client_by_state(p_state CHAR(2))
BEGIN
	SELECT * FROM clients
    WHERE state = p_state;
END $$
DELIMITER ;

CALL get_client_by_state('NY');


/* exercise */
/* return invoices for a given client */

DROP PROCEDURE IF EXISTS get_invoices_by_client;

DELIMITER $$
CREATE PROCEDURE get_invoices_by_client(p_client_name VARCHAR(50))
BEGIN
	SELECT * FROM invoices i
    JOIN clients c ON c.client_id = i.invoice_id
    WHERE c.name = p_client_name;
END $$
DELIMITER ;

CALL get_invoices_by_client('Myworks');

/**************************************/
/* Parameters with DEFAULT values     */
/**************************************/

-- set the state to CA if there is no parameters given

DROP PROCEDURE IF EXISTS get_client_by_state;

DELIMITER $$
CREATE PROCEDURE get_client_by_state(p_state CHAR(2))
BEGIN
	IF p_state IS NULL THEN
		SET p_state = 'CA';
	END IF;
    
	SELECT * FROM clients
    WHERE state = p_state;
END $$
DELIMITER ;

CALL get_client_by_state(NULL);

-- get all clients,  if there is no parameters given 

DROP PROCEDURE IF EXISTS get_client_by_state;

DELIMITER $$
CREATE PROCEDURE get_client_by_state(p_state CHAR(2))
BEGIN
	SELECT * FROM clients
    WHERE state = IFNULL(p_state, state);
END $$
DELIMITER ;

CALL get_client_by_state(NULL);

/* Exercise */
/*stored procedure get_payments with two parameters
	client_id INT(4),
    payment_method_id TINYINT(1) => 0-255

parameters are optional and if not given, get all info
*/
DROP PROCEDURE IF EXISTS get_payments;

DELIMITER $$
CREATE PROCEDURE get_payments(p_client_id INT(4), p_payment_method_id TINYINT(1))
BEGIN
	SELECT * FROM payments
    WHERE client_id = IFNULL(p_client_id, client_id)
    AND payment_method = IFNULL(p_payment_method_id, payment_method);
END $$
DELIMITER ;

CALL get_payments(5,2);
CALL get_payments(5,NULL);
CALL get_payments(NULL,1);
CALL get_payments(NULL,NULL);


/**************************************/
/* Parameters Validation              */
/**************************************/
DROP PROCEDURE IF EXISTS make_payment;

DELIMITER $$
CREATE PROCEDURE make_payment(invoice_id INT, payment_amount DECIMAL(9,2), payment_date DATE)
BEGIN
	IF payment_amount <= 0 THEN
		SIGNAL SQLSTATE '22003' 
			SET MESSAGE_TEXT = 'Invalid Payment Amount';
	END IF;
         
	UPDATE invoices i
    SET i.invoice_amount = payment_amount,
		i.payment_date = payment_date
	WHERE i.invoice_id = invoice_id;
END $$
DELIMITER ;

-- Testing
CALL mosh_sql_invoicing.make_payment(1, -345, '2020-05-01');


/**************************************/
/* Output Parameters                  */
/**************************************/

/*get unpaid invoices for a client */
DROP PROCEDURE IF EXISTS get_unpaid_invoices_for_client;

DELIMITER $$
CREATE PROCEDURE get_unpaid_invoices_for_client(client_id INT, OUT number_of_unpaid_invoices INT, OUT total_unpaid_amount INT)
BEGIN
	SELECT COUNT(*), SUM(invoice_total)
		INTO number_of_unpaid_invoices, total_unpaid_amount
    FROM invoices i
    WHERE i.client_id = client_id
    AND payment_total = 0;
END $$
DELIMITER ;

-- testing
set @number_of_unpaid_invoices = 0;
set @total_unpaid_amount = 0;
call mosh_sql_invoicing.get_unpaid_invoices_for_client(3, @number_of_unpaid_invoices, @total_unpaid_amount);
select @number_of_unpaid_invoices, @total_unpaid_amount;


/**************************************/
/* Variables                          */
/**************************************/

-- User or Session Variables
set @total_unpaid_amount = 0;

-- Local Variables
DELIMITER $$
CREATE PROCEDURE get_risk_factor()
BEGIN
	DECLARE risk_factor DECIMAL(9,2) DEFAULT 0;
    DECLARE invoices_total DECIMAL(9,2);
    DECLARE invoice_count INT;
    
    SELECT COUNT(*), SUM(invoice_total)
		INTO invoices_total, invoice_count
    FROM invoices;
    
    SET risk_factor = invoices_total / invoice_count * 5;
    
    SELECT risk_factor;
END $$
DELIMITER ;


CALL get_risk_factor();

/***********************************************************/

/**************************************/
/* Functions                          */
/**************************************/
DROP FUNCTION IF EXISTS func_get_risk_factor_for_client;

DELIMITER $$
CREATE FUNCTION func_get_risk_factor_for_client(client_id INT)
	RETURNS INTEGER
    READS SQL DATA
BEGIN
	DECLARE risk_factor DECIMAL(9,2) DEFAULT 0;
    DECLARE invoices_total DECIMAL(9,2);
    DECLARE invoice_count INT;
    
    SELECT COUNT(*), SUM(invoice_total)
		INTO invoices_total, invoice_count
    FROM invoices i
    WHERE i.client_id = client_id;
    
    SET risk_factor = invoices_total / invoice_count * 5;
    
    RETURN IFNULL(risk_factor,0);
END $$
DELIMITER ;

-- Testing
SELECT client_id, name, func_get_risk_factor_for_client(client_id) AS risk_factor
FROM clients;
