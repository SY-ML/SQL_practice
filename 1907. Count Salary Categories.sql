--https://learn-and-run.tistory.com/209

WITH
    ls_cat
        AS (SELECT category
            FROM (VALUES ('Low Salary'), ('Average Salary'), ('High Salary')) AS categories(category)),

    acc_cat
        AS (SELECT 
                account_id, 
                income, 
                CASE 
                    WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
                    WHEN income > 50000 THEN 'High Salary'
                    ELSE 'Low Salary' END AS category
            FROM
                accounts)

SELECT
    cat.category,
    ISNULL(grp.accounts_count, 0) AS accounts_count
FROM
    ls_cat AS cat
    LEFT JOIN (SELECT category, COUNT(account_id) AS accounts_count
                FROM acc_cat
                GROUP BY category) AS grp
        ON cat.category = grp.category
