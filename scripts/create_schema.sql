DROP TABLE IF EXISTS invoices CASCADE;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS validated_raw_sales;

CREATE TABLE validated_raw_sales (
    invoice_id TEXT,
    stock_code TEXT,
    description TEXT,
    quantity INT,
    invoice_timestamp TIMESTAMP,
    price FLOAT,
    customer_id TEXT,
    country TEXT,
    
    CONSTRAINT unique_rows 
        UNIQUE (invoice_id, stock_code, customer_id)
);

CREATE TABLE customers (
    customer_id TEXT PRIMARY KEY,
    latest_country TEXT
);

CREATE TABLE products (
    stock_code TEXT PRIMARY KEY,
    base_stock_code TEXT,
    description TEXT
);


CREATE TABLE invoices (
    invoice_id TEXT,
    invoice_timestamp TIMESTAMP,
    customer_id TEXT REFERENCES customers(customer_id),
    stock_code TEXT REFERENCES products(stock_code),
    price FLOAT,
    quantity INT
);
