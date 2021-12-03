create table projects ( id int , title nvarchar(20) , start_date date,end_date date,budget float)

insert into projects values (1,'reports','2017-09-11',	'2017-10-09',65921)	
insert into projects values (2,'intern','2002-10-06',	'2002-12-04',44680)	
insert into projects values (3,'financial','2011-11-28','2012-03-27',29542)
insert into projects values (4,'management','2016-01-02','2016-06-10',52841)
insert into projects values (5,'bpo','2018-06-12','2018-12-07',89238)
insert into projects values (6,'Stocks','2000-02-07','2000-06-30',13350)
insert into projects values (7,'end of year','2008-06-09','2009-03-20',65184)
insert into projects values (8,'party','2006-04-17','2006-05-19',25875)
insert into projects values (9,'diversity','2017-08-09','2017-09-18',77867)
insert into projects values (10,'integration','2005-06-29','2005-07-19',75987)

select * from  projects 

/******************** RETURN PAIRS OF PROJECTS**********************//

select a.title as project_title_end,b.title as project_title_start
,a.end_date as date
 from projects a inner join projects b
on a.id != b.id
and a.end_date = b.start_date