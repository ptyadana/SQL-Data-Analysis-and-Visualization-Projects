-- B tree index
CREATE INDEX idx_last_name_first_name_customers
ON customers (last_name, first_name);

-- Hash index
CREATE INDEX idx_product_name_products
ON products USING hash(product_name);