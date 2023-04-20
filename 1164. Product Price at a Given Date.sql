WITH
prices_on_or_before_aug16 AS (
    SELECT product_id, new_price, change_date
    FROM Products
    WHERE change_date <= '2019-08-16'
),
latest_price_changes AS (
    SELECT product_id, MAX(change_date) AS latest_change_date
    FROM prices_on_or_before_aug16
    GROUP BY product_id
),
latest_prices AS (
    SELECT p.product_id, p.new_price AS price
    FROM prices_on_or_before_aug16 p
    JOIN latest_price_changes l ON p.product_id = l.product_id AND p.change_date = l.latest_change_date
)
SELECT DISTINCT p1.product_id, COALESCE(lp.price, 10) AS price
FROM
    Products p1
    LEFT JOIN latest_prices lp ON p1.product_id = lp.product_id
