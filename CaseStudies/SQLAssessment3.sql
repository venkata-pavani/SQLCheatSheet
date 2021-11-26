/**create table employees 
(
id int ,
first_name varchar(10),
last_name varchar(10),
salatry int,
dept_id int
)

insert into employees values (1,'Bob','Smith',1000000,4)
insert into employees values (2,'Jason','Joseph',1000000,2)
insert into employees values(3,'Dilllon','Jefferson',30000,1)
insert into employees values (4,'Ted','Thompson',90000,3)
insert into employees values(5,'Bill','Smith',85000,2)

insert into employees values(6,'Ed','Winters',292314,4)
insert into employees values(7,'Aug','Rains',222999,1)
insert into employees values(8,'Lak','Jackson',421232,4)


create table departments 
(
id int,
name varchar(10)
)
insert into departments values(1,'enginring')
insert into departments values(2,'Marketing')
insert into departments values(3,'Sales')
insert into departments values(4,'hr')
**/
select * from departments 
select * from employees

/**********************---------------------------------

Given the tables above, select the top 3 departments with at least ten employees and rank them according to the percentage of their employees making over 100K in salary.

-------------------------*******************************************************/////////////////////////////////////
select d.name from departments as d 
inner join employees as e 
on d.id = e.dept_id
group by d.name
having count(*) > = 10

SELECT SUM(CASE WHEN
        salatry > 100000 THEN 1 ELSE 0
    END) AS Total
FROM employees

/**** Top 3 Depts SOLUTION BELOWWWWWWWWWWWWWWWWWWWW *****/

SELECT top 3 d.name,SUM(CASE WHEN
        e.salatry > 100000  THEN 1 ELSE 0 END)/ COUNT(DISTINCT e.id)
     AS pct_above_100k,
	 COUNT(DISTINCT e.id) as C
FROM employees e JOIN departments d on e.dept_id = d.id
group by d.name
order by COUNT(DISTINCT e.id) desc

/***** ABOVE NOT IDEAL SOLUTION******************************///////////////