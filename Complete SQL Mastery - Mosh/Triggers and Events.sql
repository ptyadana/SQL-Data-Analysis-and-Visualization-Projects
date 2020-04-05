/************************************************/
/*       Triggers                               */
/************************************************/

SELECT * FROM mosh_sql_invoicing.invoices;
SELECT * FROM mosh_sql_invoicing.payments;

/* update total of invoice table, if there is payment added to the payment table */
USE mosh_sql_invoicing;

DELIMITER $$
CREATE TRIGGER payments_after_insert
	AFTER INSERT ON payments
    FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total + NEW.amount
    WHERE invoice_id = NEW.invoice_id;
END $$
DELIMITER ;

/*testing*/
INSERT INTO payments
VALUES(DEFAULT,5,3,'2020-04-05',100,1);


/* trigger that gets fired when we delete the payment */
DROP TRIGGER IF EXISTS payments_after_delete;

DELIMITER $$
CREATE TRIGGER payments_after_delete
	AFTER DELETE ON payments
    FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total - OLD.amount
    WHERE invoice_id = OLD.invoice_id;
END $$
DELIMITER ;

/*testing*/
DELETE FROM payments
WHERE payment_id = 9;

/************************************************/
/*       View Triggers                          */
/************************************************/
SHOW TRIGGERS;

SHOW TRIGGERS LIKE '%payments%';


/************************************************/
/*       Drop Triggers                          */
/************************************************/

DROP TRIGGER IF EXISTS payments_after_delete;


/************************************************/
/*       Using Triggers for Auditing            */
/************************************************/

USE mosh_sql_invocing;

CREATE TABLE payments_audit(
	client_id INT NOT NULL,
    date DATE NOT NULL,
    amount DECIMAL(9,2) NOT NULL,
    action_type VARCHAR(50) NOT NULL,
    action_date DATETIME NOT NULL
);

/*trigger for auditing records for insert */
DROP TRIGGER IF EXISTS payments_after_insert;

DELIMITER $$
CREATE TRIGGER payments_after_insert
	AFTER INSERT ON payments
    FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total + NEW.amount
    WHERE invoice_id = NEW.invoice_id;
    
    INSERT INTO payments_audit
    VALUES(NEW.client_id, NEW.date, NEW.amount, 'INSERT', NOW());
END $$
DELIMITER ;


/*trigger for auditing records for delete */
DROP TRIGGER IF EXISTS payments_after_delete;

DELIMITER $$
CREATE TRIGGER payments_after_delete
	AFTER DELETE ON payments
    FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total - OLD.amount
    WHERE invoice_id = OLD.invoice_id;
    
    INSERT INTO payments_audit
    VALUES(OLD.client_id, OLD.date, OLD.amount, 'DELETE', NOW());
END $$
DELIMITER ;


/*testing*/
SELECT * FROM payments_audit;

INSERT INTO payments
VALUES(DEFAULT,5,3,'2020-04-05',100,1);

DELETE FROM payments
WHERE payment_id = 10;


/***************************************************/
/*      Events                                     */
/* Tasks that get executed according to a scheduel */
/***************************************************/

SHOW VARIABLES LIKE 'event%';

-- usually it is ON, but some organiazion it might be turned off to save resources.
SET GLOBAL event_scheduler = ON;

/* events that delete all the audit recrods which are 1 year old from today */
DELIMITER $$
CREATE EVENT yearly_delete_stale_audit_rows
ON SCHEDULE
	EVERY 1 YEAR STARTS '2020-01-01' ENDS '2030-12-31'
DO BEGIN
	DELETE FROM payments_audit
    WHERE action_date < NOW() - INTERVAL 1 YEAR;
END $$
DELIMITER ;


/***************************************************/
/* View / Alter / Drop Events  / Disable / Enable  */
/***************************************************/

SHOW EVENTS;

SHOW EVENTS like 'montly%';

DROP EVENT IF EXISTS yearly_delete_stale_audit_rows;

ALTER EVENT yearly_delete_stale_audit_rows DISABLE;

ALTER EVENT yearly_delete_stale_audit_rows ENABLE;
