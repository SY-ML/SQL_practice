-- https://learn-and-run.tistory.com/188
WITH std AS (
    SELECT 
        id, visit_date, people, id - ROW_NUMBER() OVER(ORDER BY id) AS row_num
    FROM stadium
    WHERE people >= 100
),

std_cons AS (
    SELECT row_num
    FROM std
    GROUP BY row_num
    HAVING COUNT(id) >= 3
)

SELECT id, visit_date, people
FROM std
WHERE row_num IN (SELECT row_num FROM std_cons)
