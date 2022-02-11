--create table attribution (sessionid int,channel varchar(10),conversion int)
/***
insert into attribution values(1 , 'facebook',0)
insert into attribution values(2 , 'facebook',0)
insert into attribution values(3 , 'email',0)
insert into attribution values(4 , 'facebook',0)
insert into attribution values(5 , 'email',0)
insert into attribution values(6 , 'organic',0)
insert into attribution values( 7, 'organic',0)

insert into attribution values(8 , 'facebook',0)
insert into attribution values(9 , 'email',0)
insert into attribution values(10 , 'email',0)
insert into attribution values(11 , 'google',1)
insert into attribution values(12 , 'email',0)
insert into attribution values(13, 'facebook',0)
insert into attribution values(14, 'organic',0)
insert into attribution values(15, 'facebook',0)


insert into attribution values(16 , 'facebook',0)
insert into attribution values(17 , 'facebook',0)
insert into attribution values(18 , 'email',0)
insert into attribution values(19 , 'facebook',0)
insert into attribution values(20 , 'email',1)
insert into attribution values(21 , 'organic',0)
insert into attribution values( 22, 'organic',1)

insert into attribution values(23 , 'facebook',0)
insert into attribution values(24 , 'email',0)
insert into attribution values(25 , 'email',1)
insert into attribution values(26 , 'google',1)
insert into attribution values(27 , 'email',0)
insert into attribution values(28, 'facebook',0)
insert into attribution values(29, 'organic',1)
insert into attribution values(30, 'facebook',0)
select * from attribution

create table user_sessions (session_id int,user_id int,created_at datetime)

insert into user_sessions values(1	,86	,'2020-09-28 00:00:00')
insert into user_sessions values(2	,67	,'2019-09-12 00:00:00')
insert into user_sessions values(3	,86	,'2020-08-28 00:00:00')

insert into user_sessions values(4,	16	,'2019-11-16 00:00:00')
insert into user_sessions values(5,	66	,'2020-10-24 00:00:00')

insert into user_sessions values(6	,15	,'2020-04-06 00:00:00')
insert into user_sessions values(7	,5	,'2020-01-08 00:00:00')
insert into user_sessions values(8	,99	,'2020-02-28 00:00:00')

insert into user_sessions values(9,	78	,'2020-11-16 00:00:00')
insert into user_sessions values(10,99	,'2019-04-21 00:00:00')

select * from user_sessions

insert into user_sessions values(11	,3	,'2020-09-28 00:00:00')
insert into user_sessions values(12	,29	,'2019-09-12 00:00:00')
insert into user_sessions values(13	,56	,'2020-08-28 00:00:00')

insert into user_sessions values(14,59	,'2019-11-16 00:00:00')
insert into user_sessions values(15,26,'2020-10-24 00:00:00')

insert into user_sessions values(16	,7	,'2020-04-06 00:00:00')
insert into user_sessions values(17	,55	,'2020-01-08 00:00:00')
insert into user_sessions values(18	,15	,'2020-02-28 00:00:00')

insert into user_sessions values(19,36,'2020-08-16 00:00:00')
insert into user_sessions values(20,64	,'2020-01-29 00:00:00')

select * from user_sessions
***/
--CONVERSION is 0 or 1 CONVERSION TRUE THEN USER CONVERTED TO BUYING ON THAT SESSION
-- attribution TABLE logs each session visit
--first attribution --> channel with which the converted user was associated when first user visits website

--Q Calculate the first touch attribution for each user_id that converted. 
--FIRST USERS CONVERSION SHOULD BE KNOWN AND THEN HOW MANY USERS FIRST TOUCH
select * from attribution
select * from user_sessions

with conv_users as (select distinct user_id from attribution as a join user_sessions as b on a.sessionid = b.session_id where conversion = 1)

select t.user_id,t.channel from(
select u.user_id , row_number() over (partition by u.user_id order by created_at) as touch_user,channel
from user_sessions as u join conv_users as c on u.user_id = c.user_id 
join attribution as a on a.sessionid = u.session_id) t where touch_user = 1






