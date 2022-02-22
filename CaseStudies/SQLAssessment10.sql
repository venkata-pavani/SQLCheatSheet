/**create table sms_sends (ds datetime,country nvarchar(20), carrier nvarchar(20) , phone int,type nvarchar(20))

insert into sms_sends values('2020-08-17T03:22:53Z','Luxembourg','Tmobile',1356,'confirmation')

insert into sms_sends values('2020-03-17T04:22:53Z','Trinidad and Tobago','Verizon',1156,'friend_request')

insert into sms_sends values('2020-06-27T04:22:53Z','Papua Guniea','Verizon',1386,'message')

insert into sms_sends values('2020-05-04T05:14:53Z','Armenia','Sprint',1286,'confirmation')

create table phone (id int,ds datetime,phone int)

insert into phone values (0,'2020-08-17T03:22:53Z',1356)
insert into phone values (1,'2020-03-17T04:22:53Z',1156)
insert into phone values (2,'2020-05-17T04:22:53Z',1756) **/

SELECT * FROM SMS_SENDS
SELECT * FROM PHONE

/***** 
 Q) Write a query to Calculate number of UNIQUE phone numbers that were sent as confirmation texts
to on Feb 28th 2020 by carrier and country

 ******/


select count(distinct phone) from sms_sends
where type = 'confirmation' and ds between  '2020-02-28 00:00:00' AND '2020-02-28 23:59:59'


/****************

Q) Calculate what percentage of users were confirmed per day.

********************/


-- here percentage calculated number of confirmation exts by total texts (calculate using phone numbers)
-- sometimes the question can be calculation of average then ---> find out when to use average function and when to use sum/count


SELECT ss.ds
, COUNT(DISTINCT c.phone)/COUNT(DISTINCT ss.phone) as num_confir
FROM sms_sends AS ss
LEFT JOIN phone AS c 
 ON ss.phone = c.phone
 AND ss.ds = c.ds
WHERE type = 'confirmation'
GROUP BY ss.ds