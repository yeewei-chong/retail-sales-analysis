DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    invoice TEXT,
    stock_code TEXT,
    description TEXT,
    quantity INT,
    date TIMESTAMP,
    price FLOAT,
    customer_id TEXT,
    country TEXT,
    
    CONSTRAINT unique_rows 
        UNIQUE (invoice, stock_code, customer_id)
);

CREATE TEMP TABLE staging (
    invoice TEXT,
    stock_code TEXT,
    description TEXT,
    quantity INT,
    date_text TEXT,
    price FLOAT,
    customer_id TEXT,
    country TEXT
);

\copy staging FROM 'data/retail_09-10.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');
\copy staging FROM 'data/retail_10-11.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');

INSERT INTO sales (
    invoice,
    stock_code,
    description,
    quantity,
    date,
    price,
    customer_id,
    country
)
SELECT 
    invoice,
    stock_code,
    description,
    quantity,
    TO_TIMESTAMP(date_text, 'DD-MM-YYYY HH24:MI'),
    price,
    customer_id,
    country
FROM staging
ON CONFLICT DO NOTHING;