-- https://learn-and-run.tistory.com/200

WITH
    cnt_mng_by_name
        AS
            (SELECT managerId AS id, COUNT(id) AS cnt_sub
            FROM employee
            GROUP BY managerId)

SELECT 
    name
FROM 
    cnt_mng_by_name AS cnt_mng
    JOIN employee AS emp ON cnt_mng.id = emp.id
WHERE 
    cnt_sub >= 5
