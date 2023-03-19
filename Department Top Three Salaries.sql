-- https://learn-and-run.tistory.com/189

WITH 
    emp_salary_rnk_by_dpt AS(
        SELECT
            *, 
            DENSE_RANK()OVER(PARTITION BY departmentid ORDER BY SALARY DESC) AS sal_rnk_in_dpt
        FROM 
            employee
    )

SELECT 
    d.name AS Department, 
    top3_sal_emp_by_dept.name AS Employee,
    salary AS Salary
FROM
    (
        SELECT 
            *
        FROM
            emp_salary_rnk_by_dpt
        WHERE 
            sal_rnk_in_dpt <= 3) AS top3_sal_emp_by_dept
    LEFT JOIN 
        department AS d ON top3_sal_emp_by_dept.departmentid = d.id
