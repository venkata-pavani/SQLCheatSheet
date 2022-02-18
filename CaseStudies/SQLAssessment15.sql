/**create table matches (player_id int , created_at datetime, result varchar(20))

--- here created_at is MATCH DAY 
insert into matches values(1,'2020-10-01 00:00:00','Win')
insert into matches values(1,'2020-10-02 00:00:00','Win')
insert into matches values(1,'2020-10-03 00:00:00','Win')
insert into matches values(1,'2020-10-03 00:00:00','Draw')
insert into matches values(1,'2020-10-04 00:00:00','Win')
insert into matches values(3,'2020-10-04 00:00:00','Draw')
insert into matches values(3,'2020-10-05 00:00:00','Draw')


insert into matches values(2	,'2019-10-19 00:00:00',	'Lose')
insert into matches values(2	,'2019-10-25 00:00:00','Lose')
insert into matches values(4,'2019-11-05 00:00:00',	'Win')**/

select * from matches

-- QUERY THE NUMBER OF MATCHES FIRST AND RANK THEM  
SELECT player_id
             ,created_at AS match_day
             , DENSE_RANK() OVER (PARTITION BY player_id ORDER BY created_at) AS RN
          FROM Matches

-- QUERY ONLY THE WINNING GAMES BY PLAYERS NOW AND EXTRACT RANKS 

SELECT player_id
             , created_at AS match_day
             , DENSE_RANK() OVER (PARTITION BY player_id ORDER BY created_at) AS RN
          FROM Matches
         WHERE result = 'Win' 

/***  NOTE:   RANK - RANKS TO ROWS IN ORDER LIKE 111 4 --> 4 IS THE NEXT RANK BECOZ THERE ARE 3 ' ONES ALREADY 
DENSE RANK  -- RANKS ROWS BY NEXT NUMBER EXAMPLE : 1112 --> 2 IS THE NEXT RANK BECOZ THERE ARE 3 ONES ***/

WITH CTE_A AS (
SELECT M.player_id
     , M.RN - W.RN AS DIFF
     , COUNT(DISTINCT M.match_day) AS CNT
     , RANK() OVER (PARTITION BY M.player_id
                        ORDER BY COUNT(DISTINCT M.match_day) DESC) AS RNK
  FROM (
        SELECT player_id
             , created_at AS match_day
             , DENSE_RANK() OVER (PARTITION BY player_id ORDER BY created_at) AS RN
          FROM Matches
       ) M
  JOIN (
        SELECT player_id
             ,created_at AS match_day
             , DENSE_RANK() OVER (PARTITION BY player_id ORDER BY created_at) AS RN
          FROM Matches
         WHERE result = 'Win' 
  ) W
    ON M.player_id = W.player_id
   AND M.match_day = W.match_day
 GROUP BY M.player_id
        , M.RN - W.RN
)
SELECT DISTINCT
       M.player_id
     , CASE WHEN A.player_id IS NULL THEN 0 ELSE A.CNT END longest_streak
  FROM Matches M
  LEFT JOIN CTE_A A
    ON M.player_id = A.player_id
   AND A.RNK = 1