-- https://learn-and-run.tistory.com/203

WITH
    trxs
        AS(
            SELECT 
                id, country, amount, trans_date,
                FORMAT(trans_date, 'yyyy-MM') AS year_month,
                CASE 
                    WHEN state LIKE 'approved' THEN 1
                    ELSE 0 END is_approved,
                CASE
                    WHEN state LIKE 'approved' THEN amount
                    ELSE 0 END amount_approved
            FROM transactions)

SELECT
    year_month AS month, 
    country, 
    COUNT(id) AS trans_count,
    SUM(is_approved) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(amount_approved) AS approved_total_amount
FROM 
    trxs
GROUP BY 
    year_month, country
