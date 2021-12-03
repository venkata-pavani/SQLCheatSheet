/**create table scores(id int,student varchar(20),score float)

insert into scores values (1,'Tanya Cox',1270)

insert into scores values (2,'Jason Lara',1990)

insert into scores values (3,'Gab King',2370)

insert into scores values (4,'Kris Bailey',1730)

insert into scores values (5,'Art Cowan',1480)

insert into scores values (6,'Re Brown',2320)

insert into scores values (7,'Ant Allen',1390)

insert into scores values (8,'Ja Gonzalez',1470)

insert into scores values (9,'Chris Wood',2390)

insert into scores values (10,'Re Murray',1910) **/

select * from scores

/****************** TWO STUDENTS WITH CLOSEST SAT SCORES ***************************************************/

with cte as (SELECT a.id as ida,b.id as idb,a.student as one_student,b.student as other_student,a.score as scorea,b.score as scoreb,abs(a.score-b.score) as score_diff
 FROM scores a inner join scores b on a.id != b.id
)
select top 1 one_student,other_student , score_diff from cte
where score_diff = (select min(abs(a.score-b.score)) from scores a inner join scores b on a.id != b.id) 
 order by score_diff,one_student
/**** Name combination --> highest in alphabet (not one student but both the combination) , score difference --> lowest (min))) also ABSOLUTE VALUE **************/