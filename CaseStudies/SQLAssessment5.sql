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



select distinct top 1 salatry,id,first_name,last_name,dept_id from employees

select * from employees
select * from departments

//////////////////***** ------------ 2ND HIGHEST SALARY ---- ***************************************************//////////////

select *, rank() over (partition by dept_id order by salatry desc) as rank from employees e left join departments d on e.dept_id = d.id
where name = 'enginring' and salatry not in
 (select max(salatry)  from employees  e left join departments d on e.dept_id = d.id where name = 'enginring')

 ////////////////////////////////////////////// --------------------------- 3RD OR 4TH HIGHEST SALARIES LOGIC ------------- //////////////////////////////////////

 with cte as(select salatry, rank() over (partition by dept_id order by salatry desc) as rank from employees e left join departments d on e.dept_id = d.id
where name = 'hr')

select * from cte where rank = 3
