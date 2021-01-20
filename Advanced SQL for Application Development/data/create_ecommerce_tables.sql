-- Table: customers
DROP TABLE IF EXISTS customers;

CREATE TABLE customers
(
    customer_id integer NOT NULL,
    first_name character varying(50),
    last_name character varying(50) ,
    email character varying(50),
    address character varying(100),
    city character varying(50),
    state_province character varying(10),
    CONSTRAINT customers_pkey PRIMARY KEY (customer_id)
)

TABLESPACE pg_default;

ALTER TABLE customers
    OWNER to postgres;



-- Table: orders
DROP TABLE IF EXISTS orders;

CREATE TABLE orders
(
    order_id integer NOT NULL,
    customer_id integer NOT NULL,
    order_date date NOT NULL,
    CONSTRAINT orders_pkey PRIMARY KEY (order_id)
)

TABLESPACE pg_default;


ALTER TABLE orders
    OWNER to postgres;

	
-- Table: product_orders
DROP TABLE IF EXISTS product_orders;

CREATE TABLE product_orders
(
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL,
    unit_price numeric(10,2) NOT NULL,
    CONSTRAINT product_orders_pkey PRIMARY KEY (order_id, product_id)
)

TABLESPACE pg_default;

ALTER TABLE product_orders
    OWNER to postgres;



-- Table: products
DROP TABLE IF EXISTS products;

CREATE TABLE products
(
    product_id integer NOT NULL,
    product_name character varying COLLATE pg_catalog."default" NOT NULL,
    product_type character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT products_pkey PRIMARY KEY (product_id)
)

TABLESPACE pg_default;

ALTER TABLE products
    OWNER to postgres;
