/*
Define a a sales history table partitioned by month of sale:

- Months are numbers from 1 to 12
- Attributes should include:
    - product ID
    - product name
    - product type
    - total units sold
    - month of sale
- Create a primary key using month of sale and product ID
*/

-- Create table with partitioned by range
CREATE TABLE sales_history(
    product_id INT NOT NULL,
	product_name CHARACTER VARYING(50) NOT NULL,
	product_type CHARACTER VARYING(50) NOT NULL,
	total_units_sold INT NOT NULL,
	month_of_sale INT NOT NULL,
	PRIMARY KEY(month_of_sale, product_id)
) PARTITION BY RANGE(month_of_sale);


-- create partition nodes tables
CREATE TABLE sales_history_month_1 PARTITION OF sales_history
FOR VALUES FROM (1) TO (2);

CREATE TABLE sales_history_month_2 PARTITION OF sales_history
FOR VALUES FROM (2) TO (3);

CREATE TABLE sales_history_month_3 PARTITION OF sales_history
FOR VALUES FROM (3) TO (4);

CREATE TABLE sales_history_month_4 PARTITION OF sales_history
FOR VALUES FROM (4) TO (5);

CREATE TABLE sales_history_month_5 PARTITION OF sales_history
FOR VALUES FROM (5) TO (6);

CREATE TABLE sales_history_month_6 PARTITION OF sales_history
FOR VALUES FROM (6) TO (7);

CREATE TABLE sales_history_month_7 PARTITION OF sales_history
FOR VALUES FROM (7) TO (8);

CREATE TABLE sales_history_month_8 PARTITION OF sales_history
FOR VALUES FROM (8) TO (9);

CREATE TABLE sales_history_month_9 PARTITION OF sales_history
FOR VALUES FROM (9) TO (10);

CREATE TABLE sales_history_month_10 PARTITION OF sales_history
FOR VALUES FROM (10) TO (11);

CREATE TABLE sales_history_month_11 PARTITION OF sales_history
FOR VALUES FROM (11) TO (12);

CREATE TABLE sales_history_month_12 PARTITION OF sales_history
FOR VALUES FROM (12) TO (13);
