--https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/description/

/* Write your T-SQL query statement below */
WITH cnt_friends
        AS 
            (
                (SELECT requester_id AS id, accept_date FROM requestaccepted)
                UNION ALL
                (SELECT accepter_id AS id, accept_date FROM requestaccepted)
            ),
    friends_by_id
        AS
            (
                SELECT id, COUNT(id) AS cnt_frd
                FROM cnt_friends
                GROUP BY id
            )

SELECT id, cnt_frd AS num
FROM friends_by_id
WHERE cnt_frd = (SELECT MAX(cnt_frd) FROM friends_by_id)
