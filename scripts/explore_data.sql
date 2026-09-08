-- define a valid code as having exactly 5 digits at the beginning
SELECT
    CASE
        WHEN stock_code ~ '^[0-9]{5}([^0-9]|$)' THEN 'valid'
        ELSE 'invalid'
    END 
        AS code,
    
    COUNT(*) AS records_count
FROM sales
GROUP BY code;

-- records count by country
SELECT country, COUNT(*) AS records_count
FROM sales
GROUP BY country
ORDER BY records_count DESC;

-- counting be whether the sale is domestic
SELECT 
    CASE 
        WHEN country = 'United Kingdom' THEN 'domestic'
        ELSE 'international'
    END 
        AS type,
    
    COUNT(*) AS records_count
FROM sales
GROUP BY type;

SELECT 
    LENGTH(invoice) AS len,
    COUNT(*) AS records_count
FROM sales
GROUP BY len;

SELECT invoice
FROM sales
WHERE LENGTH(invoice) = 7
LIMIT 1;

SELECT
    CASE
        WHEN stock_code ~ '^(c|C)' THEN 'cancelled'
        ELSE 'success'
    END 
        AS status,
    
    COUNT(*) AS records_count
FROM sales
GROUP BY status;