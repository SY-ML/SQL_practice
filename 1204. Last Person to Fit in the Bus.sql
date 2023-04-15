--https://learn-and-run.tistory.com/206

WITH
    queue_weight
        AS (SELECT
               *,
                SUM(weight) OVER (ORDER BY turn) AS total_weight
            FROM
                queue)

SELECT
    TOP 1 person_name
FROM
    queue_weight
WHERE
    total_weight <= 1000
ORDER BY
    total_weight DESC
