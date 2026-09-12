DROP TABLE IF EXISTS invoices CASCADE;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;

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
    is_cancelled BOOLEAN,
    invoice_date TIMESTAMP,
    customer_id TEXT REFERENCES customers(customer_id),
    stock_code TEXT REFERENCES products(stock_code),
    price FLOAT,
    quantity INT
);



INSERT INTO customers(customer_id, latest_country)
SELECT customer_id, country FROM (
    
    SELECT * FROM (
    
        SELECT customer_id, country, ROW_NUMBER() OVER (
            PARTITION BY customer_id ORDER BY invoice_date DESC
        ) AS desc_rank
        FROM sales_clean
    
    ) 
    
) WHERE desc_rank = 1;

INSERT INTO products(stock_code, base_stock_code, description)
SELECT stock_code, LEFT(stock_code, 5), description FROM (
    
    SELECT * FROM (
    
        SELECT stock_code, description, ROW_NUMBER() OVER (
            PARTITION BY stock_code ORDER BY invoice_date DESC
        ) AS desc_rank
        FROM sales_clean
    
    ) 
    
) WHERE desc_rank = 1;

INSERT INTO invoices (
    invoice_id,
    is_cancelled,
    invoice_date,
    customer_id,
    stock_code,
    price,
    quantity
) 
SELECT DISTINCT
    invoice_id,
    is_cancelled,
    invoice_date,
    customer_id,
    stock_code,
    price,
    quantity
FROM sales_clean

