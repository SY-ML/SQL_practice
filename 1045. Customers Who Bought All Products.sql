-- https://leetcode.com/problems/customers-who-bought-all-products/description/
SELECT customer_id 
FROM customer 
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key ) = (SELECT COUNT(product_key ) FROM product)
