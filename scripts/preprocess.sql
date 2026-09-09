DROP TABLE IF EXISTS sales_clean;

CREATE TABLE sales_clean (
    invoice_id TEXT,
    is_cancelled BOOLEAN,
    date TIMESTAMP,
    customer_id TEXT,
    country TEXT,
    stock_code TEXT,
    price FLOAT,
    quantity INT
);

INSERT INTO sales_clean (
    invoice_id,
    is_cancelled,
    date,
    customer_id,
    country,
    stock_code,
    price,
    quantity
)
SELECT
    RIGHT(invoice, 6),
    LEFT(invoice, 1) = 'C',
    date,
    customer_id,
    country,
    UPPER(stock_code),
    price,
    quantity
FROM sales
WHERE stock_code ~ '^[0-9]{5}([^0-9]|$)'
    AND customer_id ~ '^[0-9]{5}$'
    AND price > 0 
    AND quantity > 0;
    





















