CREATE TEMP TABLE staging (
    invoice_id TEXT,
    stock_code TEXT,
    description TEXT,
    quantity INT,
    timestamp_text TEXT,
    price FLOAT,
    customer_id TEXT,
    country TEXT
);

\copy staging FROM 'data/retail_09-10.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');
\copy staging FROM 'data/retail_10-11.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');

INSERT INTO validated_raw_sales (
    invoice_id,
    stock_code,
    description,
    quantity,
    invoice_timestamp,
    price,
    customer_id,
    country
)
SELECT 
    invoice_id,
    TRIM(UPPER(stock_code)),
    TRIM(TRIM(TRAILING ' .,!?' FROM UPPER(description))),
    ROUND(quantity),
    TO_TIMESTAMP(timestamp_text, 'DD-MM-YYYY HH24:MI'),
    price,
    TRIM(customer_id),
    CASE WHEN country = 'EIRE' THEN 'IRELAND' ELSE UPPER(country) END
FROM staging
WHERE 
    LEFT(invoice_id, 1) <> 'C'
    AND stock_code ~ '^[0-9]{5}([^0-9]|$)'
    AND customer_id ~ '^[0-9]{5}$'
    AND price > 0 
    AND quantity > 0
ON CONFLICT DO NOTHING;


INSERT INTO customers (
    customer_id,
    latest_country
)
SELECT DISTINCT 
    t1.customer_id, 
    t1.country 
FROM validated_raw_sales t1
JOIN (
    SELECT customer_id, MAX(invoice_timestamp) AS latest_timestamp
    FROM validated_raw_sales
    GROUP BY customer_id
) t2
ON t1.customer_id = t2.customer_id AND t1.invoice_timestamp = t2.latest_timestamp;


INSERT INTO products (
    stock_code,
    base_stock_code,
    description
)
SELECT DISTINCT 
    t1.stock_code, 
    LEFT(t1.stock_code, 5),
    t1.description
FROM validated_raw_sales t1
JOIN (
    SELECT stock_code, MAX(invoice_timestamp) AS latest_timestamp
    FROM validated_raw_sales
    GROUP BY stock_code
) t2
ON t1.stock_code = t2.stock_code AND t1.invoice_timestamp = t2.latest_timestamp;


INSERT INTO invoices (
    invoice_id,
    invoice_timestamp,
    customer_id,
    stock_code,
    price,
    quantity
) 
SELECT DISTINCT
    invoice_id,
    invoice_timestamp,
    customer_id,
    stock_code,
    price,
    quantity
FROM validated_raw_sales