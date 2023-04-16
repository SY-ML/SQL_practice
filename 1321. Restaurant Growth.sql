-- https://learn-and-run.tistory.com/207

WITH
    daily_sales
        AS (SELECT visited_on, 
                SUM(amount) AS daily_sales
            FROM 
                customer
            GROUP BY 
                visited_on),
    cumulative_sales
        AS (SELECT 
                visited_on,
                daily_sales, 
                SUM(daily_sales) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS moving_total
            FROM daily_sales)


SELECT
    visited_on, 
    moving_total AS amount, 
    ROUND(1.0*moving_total/7, 2) AS average_amount

FROM
    cumulative_sales
WHERE
    visited_on >= (SELECT DATEADD(DAY, 6, MIN(visited_on)) FROM customer)
