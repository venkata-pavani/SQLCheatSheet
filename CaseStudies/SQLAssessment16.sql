create table coalesce_ex (user_id int , userid2 int, userid3 int)

insert into coalesce_ex values(1,0,0)
insert into coalesce_ex values(0,0,0)
insert into coalesce_ex values(0,1,0)
insert into coalesce_ex values(1,0,1)
insert into coalesce_ex values(0,1,0)

insert into coalesce_ex values(1,'',1)
insert into coalesce_ex values(0,'','')
insert into coalesce_ex values('',1,0)
insert into coalesce_ex values('','',1)
insert into coalesce_ex values('',1,0)
insert into coalesce_ex values (NULL,0,0)
insert into coalesce_ex values (NULL,NULL,1)
select * from coalesce_ex

select * , coalesce(user_id, userid2,userid3) as coalesce_importance from coalesce_ex


/**create table coalesce_ex1 (user_id varchar(50) , userid2 varchar(50), userid3 varchar(50))

insert into coalesce_ex1 values('1','0','0')
insert into coalesce_ex1 values('','0','0')
insert into coalesce_ex1 values('0','1','0')
insert into coalesce_ex1 values('','','1')
insert into coalesce_ex1 values('','1','')

insert into coalesce_ex1 values('','','1')
insert into coalesce_ex1 values('0','','')
insert into coalesce_ex1 values('',1,0)
insert into coalesce_ex1 values('','',1)
insert into coalesce_ex1 values('',1,0)
insert into coalesce_ex1 values (NULL,0,0)**/

select * from coalesce_ex1

select * , coalesce(user_id, userid2,userid3) as coalesce_importance from coalesce_ex1