-- Not completed. TBC...
WITH std AS (
    SELECT 
        id, visit_date, people, id - ROW_NUMBER() OVER(ORDER BY id) AS row_num
    FROM stadium
    WHERE people >= 100
)

SELECT * FROM std

