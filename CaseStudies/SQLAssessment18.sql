/***create table exchangeSeat (id int , name varchar(20))

insert into exchangeSeat values (1,'Lila')

insert into exchangeSeat values (2,'piyush')


insert into exchangeSeat values (3,'abbot')


insert into exchangeSeat values (4,'janesh')


insert into exchangeSeat values (5,'tom')


insert into exchangeSeat values (6,'jeh')


insert into exchangeSeat values (7,'abbot')**/

select * from exchangeSeat

/*** USING WINDOWS FUNCTIONS LAG LEAD ROW_NUMBER ********************************************/

with cte as (
select id, name,
lag(name) over (order by id) as prev_student,
lead(name) over (order by id) as next_student,
row_number() over (order by id) as row_num
from exchangeSeat
)
select id , prev_student from cte where row_num % 2 = 0
union
select id, coalesce (next_student,name) from cte where row_num % 2 = 1


/***** ALSO CAN USE CASE STATEMENT *****************************************/

/***********************

CONCEPT IS SAME IN ANY QUERY 

EVEN NUMBER --> THEN PREVIOUS STUDENT 
ODD NUMBER --> NEXT STUDENT 
IF ODD NUMBER AND NO NEXT STUDENT THEN SAME STUDENT  

***************************************/

SELECT id + 1 as id ,name from exchangeSeat where id%2 = 1 and id not in (select max(id) from exchangeSeat)
union 

SELECT id - 1 as id ,name from exchangeSeat where id%2 = 0 
union
SELECT id ,name from exchangeSeat where id%2 = 1 and id in (select max(id) from exchangeSeat)

