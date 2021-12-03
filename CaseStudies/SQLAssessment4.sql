/***create table subscriptions(user_id int , start_date date , end_date date)
insert into subscriptions values (5,'2016-01-08','2016-04-16')
insert into subscriptions values (6,'2017-03-02','2017-04-24')
insert into subscriptions values (7,'2018-02-14','2018-03-06')
insert into subscriptions values (8,'2017-02-27','2017-03-29')
insert into subscriptions values (9,'2003-04-14','2003-07-15')***/

select a.user_id,b.user_id,a.start_date,a.end_date,b.start_date,b.end_date
 from subscriptions a left join subscriptions b 
 on a.user_id != b.user_id --NOT COMPARING SAME USERS 
and a.start_date < = b.END_date
and a.end_date >= b.START_date


select * from subscriptions

/*********************************----------------- OVERLAPPING DATES -------------------**************************************/


select  distinct b.user_id,CASE WHEN b.start_date is not null then 1 else 0 end as overlap
 from subscriptions a inner join subscriptions b 
 on a.user_id != b.user_id --NOT COMPARING SAME USERS 
and a.start_date < = b.END_date
and a.end_date >= b.START_date

/*******************INNER JOIN OR LEFT JOIN IT DOESNT MATTER HERE COZ LEFT JOIN HAS NULL'S***************************/

/******************** THE BELOW ONE ALSO GIVES SAME RESULT *********************************/

SELECT u.user_id,CASE WHEN overlap_cnt > 0 THEN 1 ELSE 0 END AS overlap
  FROM 
  (SELECT u1.user_id,SUM(CASE WHEN u2.user_id IS NULL THEN 0 ELSE 1 END) AS overlap_cnt
          FROM subscriptions AS u1
          JOIN subscriptions AS u2
            ON u1.start_date <= u2.end_date
           AND u1.end_date >= u2.start_date
           AND u1.user_id != u2.user_id
         GROUP BY u1.user_id) AS u

