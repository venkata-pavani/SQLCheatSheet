CREATE TABLE BUCHAREST
(
  year varchar(4),
  month integer,
  day integer,
  hour integer,
  minute integer,
  temperature float
);

insert into BUCHAREST values(2020,01,27,00,00,3.89)
insert into BUCHAREST values(2020,01,27,01,00,3.18)
insert into BUCHAREST values(2020,01,27,02,00,2.72)
insert into BUCHAREST values(2020,01,27,03,00,2.12)
insert into BUCHAREST values(2020,01,27,04,00,1.73)
insert into BUCHAREST values(2020,01,27,05,00,1.25)

insert into BUCHAREST values(2021,01,27,06,00,4.99)
insert into BUCHAREST values(2021,01,27,07,00,4.17)
insert into BUCHAREST values(2021,01,27,08,00,4.82)
insert into BUCHAREST values(2021,01,27,09,00,3.39)
insert into BUCHAREST values(2021,01,27,10,00,3.53)
insert into BUCHAREST values(2021,01,27,11,00,3.25)

insert into BUCHAREST values(2021,01,27,00,00,4.89)
insert into BUCHAREST values(2021,01,27,01,00,4.18)
insert into BUCHAREST values(2021,01,27,02,00,3.72)
insert into BUCHAREST values(2021,01,27,03,00,3.12)
insert into BUCHAREST values(2021,01,27,04,00,2.73)
insert into BUCHAREST values(2021,01,27,05,00,2.25)

insert into BUCHAREST values(2021,01,27,06,00,3.89)
insert into BUCHAREST values(2021,01,27,07,00,3.18)
insert into BUCHAREST values(2021,01,27,08,00,2.72)
insert into BUCHAREST values(2021,01,27,09,00,3.32)
insert into BUCHAREST values(2021,01,27,10,00,2.93)
insert into BUCHAREST values(2021,01,27,11,00,3.25)

insert into BUCHAREST values(2018,01,27,00,00,3.79)
insert into BUCHAREST values(2018,01,27,01,00,3.19)
insert into BUCHAREST values(2018,01,27,02,00,4.73)
insert into BUCHAREST values(2018,01,27,03,00,4.22)
insert into BUCHAREST values(2018,01,27,04,00,3.53)
insert into BUCHAREST values(2018,01,27,05,00,3.25)

insert into BUCHAREST values(2018,01,27,06,00,3.19)
insert into BUCHAREST values(2018,01,27,07,00,4.28)
insert into BUCHAREST values(2018,01,27,08,00,3.82)
insert into BUCHAREST values(2018,01,27,09,00,3.32)
insert into BUCHAREST values(2018,01,27,10,00,3.93)
insert into BUCHAREST values(2018,01,27,11,00,3.55)

insert into BUCHAREST values(2020,01,28,00,00,3.89)
insert into BUCHAREST values(2020,01,28,01,00,3.18)
insert into BUCHAREST values(2020,01,28,02,00,2.72)
insert into BUCHAREST values(2020,01,28,03,00,2.12)
insert into BUCHAREST values(2020,01,28,04,00,1.73)
insert into BUCHAREST values(2020,01,28,05,00,1.25)

insert into BUCHAREST values(2021,01,28,06,00,4.99)
insert into BUCHAREST values(2021,01,28,07,00,4.17)
insert into BUCHAREST values(2021,01,28,08,00,4.82)
insert into BUCHAREST values(2021,01,28,09,00,3.39)
insert into BUCHAREST values(2021,01,28,10,00,3.53)
insert into BUCHAREST values(2021,01,28,11,00,3.25)

insert into BUCHAREST values(2021,01,28,00,00,4.89)
insert into BUCHAREST values(2021,01,28,01,00,4.18)
insert into BUCHAREST values(2021,01,28,02,00,3.72)
insert into BUCHAREST values(2021,01,28,03,00,3.12)
insert into BUCHAREST values(2021,01,28,04,00,2.73)
insert into BUCHAREST values(2021,01,28,05,00,2.25)

insert into BUCHAREST values(2021,01,28,06,00,3.89)
insert into BUCHAREST values(2021,01,28,07,00,3.18)
insert into BUCHAREST values(2021,01,28,08,00,2.72)
insert into BUCHAREST values(2021,01,28,09,00,3.32)
insert into BUCHAREST values(2021,01,28,10,00,2.93)
insert into BUCHAREST values(2021,01,28,11,00,3.25)

insert into BUCHAREST values(2018,01,28,00,00,3.79)
insert into BUCHAREST values(2018,01,28,01,00,3.19)
insert into BUCHAREST values(2018,01,28,02,00,4.73)
insert into BUCHAREST values(2018,01,28,03,00,4.22)
insert into BUCHAREST values(2018,01,28,04,00,3.53)
insert into BUCHAREST values(2018,01,28,05,00,3.25)

insert into BUCHAREST values(2018,01,28,06,00,3.19)
insert into BUCHAREST values(2018,01,28,07,00,4.28)
insert into BUCHAREST values(2018,01,28,08,00,3.82)
insert into BUCHAREST values(2018,01,28,09,00,3.32)
insert into BUCHAREST values(2018,01,28,10,00,3.93)
insert into BUCHAREST values(2018,01,28,11,00,3.55)

SELECT * FROM BUCHAREST;


UPDATE BUCHAREST
SET temperature = round(temperature);


SELECT * FROM BUCHAREST;

CREATE VIEW bucharest_temperature_daylevel as
SELECT YEAR,MONTH,DAY,ROUND(AVG(TEMPERATURE),2) as TEMPERATURE
FROM BUCHAREST
GROUP BY YEAR,MONTH,DAY;



SELECT * FROM bucharest_temperature_daylevel


SELECT year,month,day, temperature, lag(temperature) over (partition by '' order by year,month,day) as prev_temperature FROM bucharest_temperature_daylevel;




SELECT year,month,day, temperature, row_number() over (partition by year, month order by year,month,day desc) as last_day_of_month_from_data FROM bucharest_temperature_daylevel ORDER BY 1,2,3;

SELECT year,month, row_number() over (partition by year order by month) as rn,
rank() over (partition by year order by month) as rank,
dense_rank() over (partition by year order by month) as dense_rank
FROM bucharest_temperature_daylevel
ORDER BY 1,2;

/**********************<<<<<<<<< TEMPERATURE AVERAGE FOR LAST 3 DAYS  >>>>>>>>>>>>>>>*********************************************/
SELECT year,month,day,temperature, 
avg(temperature) over (partition by '' order by year,month,day ROWS BETWEEN 3 preceding and current row) last_3_days_avg
FROM bucharest_temperature_daylevel
ORDER BY 1,2,3;

/*************************** <<<<<< ROWS PREVIOYS 2 AND FOLLOWING ONE AVERAGE TEMPERATURE >>>>>>>>****************************/
SELECT year,month,day,temperature, 
avg(temperature) over (partition by '' order by year,month,day ROWS BETWEEN 2 preceding and 1 following) last_3_days_avg
FROM bucharest_temperature_daylevel
ORDER BY 1,2,3;
