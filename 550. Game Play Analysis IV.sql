--https://learn-and-run.tistory.com/205

WITH
  log_in_consec
    AS (SELECT 
          *, 
          ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY event_date) AS event_num,
          LEAD(event_Date) OVER (PARTITION BY player_id ORDER BY event_date) AS next_login_date
        FROM 
          activity),

  log_in_is_consec
    AS (SELECT 
          player_id,
          CASE 
            WHEN DATEDIFF(DAY, event_date, next_login_date)=1 THEN 1.0
            ELSE 0.0 END AS is_consecutive
        FROM
          log_in_consec
        WHERE
          event_num = 1)

SELECT ROUND(AVG(is_consecutive), 2) AS fraction
FROM log_in_is_consec
