--https://learn-and-run.tistory.com/210

WITH
    rating_count_by_user
        AS (SELECT user_id, COUNT(rating) AS count_rating
            FROM movierating
            GROUP BY user_id),


    ls_id_most_rating
        AS (SELECT user_id
            FROM rating_count_by_user
            WHERE count_rating = (SELECT MAX(count_rating) FROM rating_count_by_user)),

    answer1
        AS (SELECT TOP 1 name AS results
            FROM ls_id_most_rating AS cnt
            JOIN users AS u ON cnt.user_id = u.user_id
            ORDER BY name),

    rating_avg_by_movie_feb2020
        AS (SELECT movie_id, AVG(CONVERT(FLOAT, rating)) AS average_rating
            FROM movierating
            WHERE YEAR(created_at) = 2020
                AND MONTH(created_at) = 2
            GROUP BY movie_id),

    ls_movie_highest_avgrating_feb2020
        AS (SELECT movie_id
            FROM rating_avg_by_movie_feb2020
            WHERE average_rating = (SELECT MAX(average_rating) FROM rating_avg_by_movie_feb2020)
                ),

    answer2
        AS (SELECT TOP 1 title AS results
            FROM ls_movie_highest_avgrating_feb2020 AS rating
            JOIN movies AS mv ON rating.movie_id = mv.movie_id
            ORDER BY title)


SELECT * FROM answer1
UNION ALL
SELECT * FROM answer2

