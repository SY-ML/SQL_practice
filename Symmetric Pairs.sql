SELECT 
    f1.x, f1.y
FROM 
    functions AS f1 
    JOIN functions f2 ON f1.x=f2.y
                    AND f1.y=f2.x
WHERE 
    f1.x <= f1.y
GROUP BY 
    f1.x, f1.y
HAVING 
    COUNT(*)>1 OR f1.x<>f1.y
ORDER BY 
    f1.x
