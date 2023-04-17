-- https://learn-and-run.tistory.com/208

WITH
    ls_signups
        AS (SELECT 
                DISTINCT(user_id)
            FROM 
                signups),

    log_cfrm
        AS (SELECT 
                user_id,
                CASE WHEN action = 'confirmed' THEN 1 ELSE 0 END AS is_confirmed
            FROM 
                confirmations),
    cnt_cfrm
        AS (SELECT
                user_id, 
                SUM(is_confirmed) AS cnt_cfrm,
                COUNT(user_id) AS cnt_rqst
            FROM 
                log_cfrm
            GROUP BY
                user_id)

SELECT 
    rqst.user_id, 
    ISNULL(ROUND(cnt_cfrm*1.0/cnt_rqst , 2), 0.00) AS confirmation_rate
FROM 
    ls_signups AS rqst
    LEFT JOIN cnt_cfrm AS cfrm ON rqst.user_id = cfrm.user_id
