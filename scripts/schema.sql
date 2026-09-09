DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS invoices;

CREATE TABLE customers (
    customer_id TEXT,
    country TEXT,
    PRIMARY KEY (customer_id)
);

CREATE TABLE products (
    stock_code TEXT PRIMARY KEY,
    base_stock_code TEXT,
    description TEXT
);

