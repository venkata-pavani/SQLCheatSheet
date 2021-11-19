/*create table cust_orders 
(
order_id varchar(10),
cust_id int,
order_date date,
product varchar(20),
order_amt int,
shipping_option_id int
)


insert into cust_orders values ('50001',101,'2015-08-29','Camera',100,1)

insert into cust_orders values ('50002',102,'2015-08-30','Shoes',90,1)

insert into cust_orders values ('50003',103,'2015-05-31','Laptop',400,4)

insert into cust_orders values ('50004',101,'2015-08-29','Mobile',100,3)

insert into cust_orders values ('50005',104,'2015-08-29','FrozenMeals',30,2)

insert into cust_orders values ('50006',104,'2015-08-30','Cloths',65,1)



select * from cust_orders

create table customers(

cust_id int,
country varchar(20),
account_creation_date date
)

insert into customers values (101,'US','2015-08-29')
insert into customers values (102,'CA','2015-07-30')
insert into customers values (103,'CA','2015-05-31')
insert into customers values (104,'US','2015-07-01')
insert into customers values (105,'US','2015-08-29')

SELECT * FROM customers

CREATE TABLE calender ( cal_id int , month_begin_date date)


insert into calender values(1,'2015-01-01')

insert into calender values(2,'2015-02-01')

insert into calender values(3,'2015-03-01')

insert into calender values(4,'2015-04-01')

insert into calender values(5,'2015-05-01')

insert into calender values(6,'2015-06-01')

insert into calender values(7,'2015-07-01')

insert into calender values(8,'2015-08-01')

insert into calender values(9,'2015-09-01')

insert into calender values(10,'2015-10-01')

insert into calender values(11,'2015-11-01')

insert into calender values(12,'2015-12-01')

select * from calender 
*/

select * from cust_orders
SELECT * FROM customers
select * from calender
/******    ---------------------------------------------------------------------------------------------------------------               
Write a SQL to generate a monthly report showing Total Accounts Created, Total Number of Orders Placed, and Total Order Amount.
--------------------------------------------------------------------------------------------------------------------------
*******/
SELECT
month_begin_date , count(distinct(customers.cust_id)) as total_accounts_created
,count(distinct(cust_orders.order_id)) as total_orders_placed,
ISNULL(SUM(order_amt)/COUNT(DISTINCT(customers.cust_id)),0) AS total_order_amount
from 
(
calender left join customers on (month(month_begin_date)) = (month(account_creation_date))
)
left join cust_orders on (month(month_begin_date)) = (month(cust_orders.order_date))
group by calender.month_begin_date

/****
-----------------------------------------
It supposed to be group by MONTH but somehow in T-SQL i am unable to implement it --> then we will get correct output 
-------------------------------------------
*****/