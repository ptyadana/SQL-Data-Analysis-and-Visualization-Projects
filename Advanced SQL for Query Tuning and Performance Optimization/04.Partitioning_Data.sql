/************ Partitioning Data ***************/

---------- Partition by Range ---------------------------

/* creat new table with partition table (with partition key) */
CREATE TABLE iot_measurement(
	location_id INT NOT NULL,
	measure_date DATE NOT NULL,
	temp_celcius INT,
	rel_humidity INT
) PARTITION BY RANGE(measure_date);

/* If we check iot_measurement table > Partitions > we will see No Nodes yet, because none has been created */

/* Create partition Nodes and add to the original table */

CREATE TABLE iot_measurement_week1_2019 PARTITION OF iot_measurement
FOR VALUES FROM ('2019-01-01') TO ('2019-01-08');

CREATE TABLE iot_measurement_week2_2019 PARTITION OF iot_measurement
FOR VALUES FROM ('2019-01-08') TO ('2019-01-15');

CREATE TABLE iot_measurement_week3_2019 PARTITION OF iot_measurement
FOR VALUES FROM ('2019-01-15') TO ('2019-01-22');


/* 
If we check iot_measurement table > Partitions > we will see created 3 Nodes.
Now, we can create constraints, indexes, triggers on each node.
Notice that there is no columns, because columns are inherited from Parent Table.
*/


---------- Partition by List ---------------------------

/* create table with partition by list */
CREATE TABLE products(
	product_id INT NOT NULL,
	product_name TEXT NOT NULL,
	product_short_desc TEXT NOT NULL,
	product_long_desc TEXT NOT NULL,
	product_category VARCHAR NOT NULL
)PARTITION BY LIST(product_category);

/* create partitions nodes */
CREATE TABLE product_clothing PARTITION OF products
	FOR VALUES IN('casual_clothing', 'business_attire', 'formal_clothing');
	
CREATE TABLE product_electronics PARTITION OF products
	FOR VALUES IN('mobile_phones', 'tablets', 'laptop_computers');
	
CREATE TABLE product_kitchen PARTITION OF products
	FOR VALUES IN ('food_processors', 'cutlery', 'blenders');



---------- Partition by Hash ---------------------------

/* create table with partition by hash */
CREATE TABLE customer_interaction(
	cid INT NOT NULL,
	ci_url TEXT NOT NULL,
	time_at_url INT NOT NULL,
	click_sequence INT NOT NULL
)PARTITION BY HASH(cid);

/* 
Create partitions nodes 
As we want 5 partitions, we will use Modulus of 5.
*/
-- for first partition, every customer id divided by 5 with remainder of getting 0 will be put into this block of partition.
CREATE TABLE customer_interaction_1 PARTITION OF customer_interaction
FOR VALUES WITH (MODULUS 5, REMAINDER 0);

CREATE TABLE customer_interaction_2 PARTITION OF customer_interaction
FOR VALUES WITH (MODULUS 5, REMAINDER 1);

CREATE TABLE customer_interaction_3 PARTITION OF customer_interaction
FOR VALUES WITH (MODULUS 5, REMAINDER 2);

CREATE TABLE customer_interaction_4 PARTITION OF customer_interaction
FOR VALUES WITH (MODULUS 5, REMAINDER 3);

CREATE TABLE customer_interaction_5 PARTITION OF customer_interaction
FOR VALUES WITH (MODULUS 5, REMAINDER 4);
