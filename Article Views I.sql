
SELECT 
    author_id AS id
FROM
    views
WHERE 
    author_id = viewer_id

GROUP BY
    author_id
HAVING
    COUNT(view_date) > 0
ORDER BY 
    author_id
