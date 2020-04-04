/*****************************************/
/*       Create and Drop Database        */
/*****************************************/
CREATE DATABASE IF NOT EXISTS sql_store;

DROP DATABASE IF EXISTS sql_store;


/*****************************************/
/*       Creating Tables                 */
/*****************************************/
USE sql_store;

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE IF NOT EXISTS customers(
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);


/*****************************************/
/*       Altering Tables                 */
/*****************************************/
ALTER TABLE customers
	ADD last_name VARCHAR(50) NOT NULL 
		AFTER first_name;

ALTER TABLE customers
	ADD points INT NOT NULL
		AFTER last_name;

ALTER TABLE customers
	MODIFY COLUMN points INT NOT NULL DEFAULT 0;
    
ALTER TABLE customers
	DROP column_name;


/*****************************************/
/*       Creating Relationship           */
/*****************************************/
CREATE TABLE IF NOT EXISTS orders(
	order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_Id INT NOT NULL,
    FOREIGN KEY fk_orders_customers (customer_id) REFERENCES customers(customer_id)
		ON UPDATE CASCADE
        ON DELETE NO ACTION
);


/*****************************************/
/* Altering Primary and Foreign Keys     */
/*****************************************/
ALTER TABLE orders
	DROP PRIMARY KEY,
    ADD PRIMARY KEY (order_id),
	DROP FOREIGN KEY fk_orders_customers,
    ADD FOREIGN KEY fk_orders_customers (customer_id) REFERENCES customers(customer_id)
		ON UPDATE CASCADE
        ON DELETE NO ACTION;


/*****************************************/
/*       CHAR SET                        */
/*****************************************/
SHOW CHARSET;

CREATE DATABASE database_name
	CHARACTER SET latin1;
    
ALTER DATABASE database_name
	CHARACTER SET latin1;
    
CREATE TABLE tbl1(
id INT,
name VARCHAR(20))
CHARACTER SET latin1;

/*****************************************/
/*       ENGINES                         */
/*****************************************/
SHOW ENGINES;

ALTER TABLE tlb_name
ENGINE = InnoDB;