--https://learn-and-run.tistory.com/204

SELECT 
    ROUND(AVG(is_imt)*100, 2) AS immediate_percentage 
FROM 
    (SELECT 
            CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END AS is_imt
    FROM
        delivery
    WHERE
        (customer_id, order_date ) IN (SELECT customer_id, MIN(order_date) AS first_order
                                        FROM delivery
                                        GROUP BY customer_id)) AS ords_1st
