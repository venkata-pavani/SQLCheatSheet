create table conversations(
id int,
date datetime,
user1 int,
user2 int,
msg_count int
)

insert into conversations values (1,'2019-12-02T00:00:00Z',50,18,193)
insert into conversations values (12,'2019-12-03T00:00:00Z',31,42,70)
insert into conversations values (19,'2019-12-06T00:00:00Z',25,58,170)
insert into conversations values (20,'2019-12-06T00:00:00Z',66,45,41)
insert into conversations values (25,'2019-12-08T00:00:00Z',16,60,134)

insert into conversations values (26,'2019-12-08T00:00:00Z',94,14,154)
insert into conversations values (34,'2019-12-10T00:00:00Z',55,8,82)
insert into conversations values (35,'2019-12-10T00:00:00Z',14,95,62)
insert into conversations values (36,'2019-12-10T00:00:00Z',47,61,89)
insert into conversations values (38,'2019-12-10T00:00:00Z',75,22,166)
insert into conversations values (40,'2019-12-10T00:00:00Z',1,33,49)
insert into conversations values (46,'2019-12-11T00:00:00Z',32,37,139)
insert into conversations values (50,'2019-12-12T00:00:00Z',13,55,95)
insert into conversations values (51,'2019-12-12T00:00:00Z',13,56,12)
/**** NUMBER OF CONVERSATIONS = NO OF DISTINCT USER2*****/
select * from conversations

SELECT num_conv,count(*) as freq from (
select user1,count(distinct user2) as num_conv,date
 from conversations
 where year(date) = 2019 
 group by user1,date) as t 

 group by num_conv

 /************** the user no 13 has two messages to two different users *******/