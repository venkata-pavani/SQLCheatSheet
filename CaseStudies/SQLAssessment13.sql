/***create table flights (id int,dest_loc nvarchar(20),source_loc nvarchar(20),plane_id int,flight_start nvarchar(30),flight_end nvarchar(30))

insert into flights values (1,'Deniseborough',	'East Scottborough',	1,	'2019-05-10T12:22:00Z',	'2019-05-10T16:43:54Z')

insert into flights values (2,'New Christinestad','Harrisfurt','2','2019-01-13T13:04:00Z','2019-01-13T18:23:55Z')
insert into flights values(3,'Lopezmouth','Port Sharon','3','2019-05-12T10:23:00Z','2019-05-12T12:39:33Z')
insert into flights values(4,'North Edward','Lake Luke','4','2019-08-22T13:21:00Z','2019-08-22T18:38:59Z')
insert into flights values(5,'East Justin','Seanborough','1','2019-07-19T11:08:00Z','2019-07-19T12:36:39Z')
insert into flights values(6,'Harrisfurt','North Vanessafurt','2','2019-04-10T10:28:00Z','2019-04-10T14:31:52Z')
insert into flights values(7,'Reeseview','Jasonberg','3','2019-07-25T13:16:00Z','2019-07-25T15:36:42Z')
insert into flights values(8,'North Kevin','New Carriebury','4','2019-04-18T13:02:00Z','2019-04-18T18:07:37Z')
insert into flights values(9,'Lake Jennifer','Harrisfurt','1','2019-08-28T10:10:00Z','2019-08-28T14:14:39Z')
insert into flights values(10,'Thomashaven','Lopezmouth','2','2019-09-25T10:04:00Z','2019-09-25T12:10:41Z')
insert into flights values(11,'Seanborough','Lake Jennifer','3','2019-05-24T11:05:00Z','2019-05-24T13:15:56Z')
insert into flights values(12,'Jasonberg','Stephenschester','4','2019-04-20T11:23:00Z','2019-04-20T13:47:39Z')
insert into flights values(13,'Conwayborough','Conwayborough','1','2019-04-26T13:08:00Z','2019-04-26T14:16:40Z')
insert into flights values(14,'Garyfurt','Mullenborough','2','2019-05-23T13:18:00Z','2019-05-23T18:26:55Z')
insert into flights values(15,'East Justin','Lozanoberg','3','2019-03-16T13:22:00Z','2019-03-16T15:27:57Z')
insert into flights values(16,'North Vanessafurt','North Vanessafurt','4','2019-09-15T13:29:00Z','2019-09-15T18:33:56Z')
insert into flights values(17,'Port Sharon','East Tammyborough','1','2019-05-23T13:19:00Z','2019-05-23T18:43:47Z')
insert into flights values(18,'Reedland','New Christinestad','2','2019-04-27T11:11:00Z','2019-04-27T13:14:43Z') **/

/***Write a query to create a new table, named flight routes, that displays unique pairs of two locations.***/

select * from flights
/****it seems like least and greatest are not the functions in T-SQL However they are in other languages*******/
select distinct least(source_location,destination_location)
 as destination_one
,greatest(destination_location,source_location)
as destination_two
 from flights


 /***** ANOTHER WAY ******/

 with cte as(
 SELECT
    (CASE WHEN source_loc<dest_loc
         THEN source_loc
         ELSE dest_loc END) as destination_one,
    (CASE WHEN source_loc>dest_loc
          THEN source_loc
          ELSE dest_loc
          END
    ) as destination_two
FROM flights)

select * from cte 
GROUP BY destination_one,destination_two
--LEAST AND GREATEST are implemented as a CASE Statement