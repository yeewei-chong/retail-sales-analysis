DROP TABLE IF EXISTS sales_clean;

CREATE TABLE sales_clean (
    invoice TEXT,
    is_cancelled BOOLEAN,
    date TIMESTAMP,
    customer_id TEXT,
    country TEXT,
    base_stock_code TEXT,
    full_stock_code TEXT,
    price FLOAT,
    quantity INT,
    total_price FLOAT
);

-- INSERT INTO sales_clean (
--     invoice,
--     is_cancelled,
--     date,
--     customer_id,
--     country,
--     base_stock_code,
--     full_stock_code,
--     price,
--     quantity,
--     total_price
-- )
-- SELECT 
--     invoice,
--     is_cancelled,
--     date,
--     customer_id,
--     country,
--     base_stock_code,
--     full_stock_code,
--     price,
--     quantity,
--     total_price
-- FROM sales
-- WHERE