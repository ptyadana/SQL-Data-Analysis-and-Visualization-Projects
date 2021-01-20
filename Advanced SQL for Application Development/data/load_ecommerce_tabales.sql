COPY product_orders FROM 'C:\sql-temp\product_orders.csv' DELIMITER ',' CSV HEADER;
COPY products FROM 'C:\sql-temp\products.csv' DELIMITER ',' CSV HEADER;
COPY orders FROM 'C:\sql-temp\orders.csv' DELIMITER ',' CSV HEADER;
COPY customers FROM 'C:\sql-temp\customers.csv' DELIMITER ',' CSV HEADER;
