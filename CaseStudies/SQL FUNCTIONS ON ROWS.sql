/****

-- Table will contain only one column of datatype VARIANT that stores the JSON file
CREATE  TABLE MODUNDRIGE
(
  year varchar(4),
  month integer,
  day integer,
  hour integer,
  minute integer,
  temperature float
)

INSERT INTO  MODUNDRIGE VALUES(2021,12,27,1,35,45)

INSERT INTO MODUNDRIGE VALUES(2021,11,25,9,15,35)

INSERT INTO  MODUNDRIGE VALUES(2021,10,27,1,35,15)

INSERT INTO  MODUNDRIGE VALUES(2021,9,25,9,15,25)

INSERT INTO  MODUNDRIGE VALUES(2021,8,27,1,45,65)

INSERT INTO  MODUNDRIGE VALUES(2021,7,25,10,25,45)


INSERT INTO  MODUNDRIGE VALUES(2020,12,27,1,35,55)

INSERT INTO MODUNDRIGE VALUES(2020,11,25,9,15,45)

INSERT INTO  MODUNDRIGE VALUES(2020,10,27,1,35,25)

INSERT INTO  MODUNDRIGE VALUES(2020,9,25,9,15,35)

INSERT INTO  MODUNDRIGE VALUES(2020,8,27,1,45,75)

INSERT INTO  MODUNDRIGE VALUES(2020,7,25,10,25,65)


INSERT INTO  MODUNDRIGE VALUES(2022,1,1,1,35,15)

INSERT INTO MODUNDRIGE VALUES(2022,1,3,9,15,25)

INSERT INTO  MODUNDRIGE VALUES(2022,1,5,1,35,35)

INSERT INTO  MODUNDRIGE VALUES(2022,1,7,9,15,15)

INSERT INTO  MODUNDRIGE VALUES(2022,1,9,1,45,25)


INSERT INTO  MODUNDRIGE VALUES(2021,1,10,10,25,45)

INSERT INTO  MODUNDRIGE VALUES(2021,2,1,1,35,35)

INSERT INTO MODUNDRIGE VALUES(2021,3,3,9,15,15)

INSERT INTO  MODUNDRIGE VALUES(2021,4,5,1,35,25)

INSERT INTO  MODUNDRIGE VALUES(2021,5,7,9,15,35)

INSERT INTO  MODUNDRIGE VALUES(2021,6,9,1,45,15)


INSERT INTO  MODUNDRIGE VALUES(2020,1,10,10,25,15)

INSERT INTO  MODUNDRIGE VALUES(2020,2,1,1,35,25)

INSERT INTO MODUNDRIGE VALUES(2020,3,3,9,15,45)

INSERT INTO  MODUNDRIGE VALUES(2020,4,5,1,35,15)

INSERT INTO  MODUNDRIGE VALUES(2020,5,7,9,15,65)

INSERT INTO  MODUNDRIGE VALUES(2020,6,9,1,45,55)


SELECT * FROM MODUNDRIGE ORDER BY YEAR,MONTH,DAY,MINUTE,temperature
****/

--- **************************** PREVIOUS TEMPERATURE ***************************************---------------------------------
SELECT year,month,day, temperature, lag(temperature) over (order by year,month,day) as prev_temperature
FROM MODUNDRIGE;

---  *****************Difference of temperature over years *********************-------------------
with cte as ( SELECT year,month,day, temperature, lag(temperature) over (order by year,month,day) as prev_temperature
FROM MODUNDRIGE)
select YEAR,month,DAY,temperature-prev_temperature as temp_diff from cte


--- ********************************** SUCCEEDING TEMPERATURE ********************************* ---------------------

SELECT year,month,day, temperature, LEAD(temperature) over (order by year,month,day) as NEXT_temperature
FROM MODUNDRIGE;

---  ROW_NUMBER --  "Returns a unique row number for each row within a window partition" -
--- RANK -- RANKS ROWS BASED ON THE VALUE PROVIDED 

SELECT * FROM MODUNDRIGE ORDER BY YEAR,MONTH,DAY,MINUTE,temperature

SELECT year,month,day, temperature, row_number() over (partition by year, month order by year,month,day desc) as last_day_of_month_from_data
FROM MODUNDRIGE
ORDER BY 1,2,3;


SELECT year,month, 
row_number() over (partition by year order by month) as rn,
rank() over (partition by year order by month) as rank,
dense_rank() over (partition by year order by month) as dense_rank
FROM  MODUNDRIGE
ORDER BY 1,2;


-----------: What was the coldest 4-day period?


SELECT year,month,day,temperature, 
avg(temperature) over (partition by '' order by year,month,day ROWS BETWEEN 3 preceding and current row) last_3_days_avg
FROM MODUNDRIGE
ORDER BY 1,2,3;


 ----What is the cumulative average temperature?
  ---, let's average all rows until the previous row, by specifying the two limits as:

 SELECT year,month,day,temperature, 
avg(temperature) over (partition by '' order by year,month,day ROWS BETWEEN unbounded preceding and 1 preceding) preceding_days_avg
FROM  MODUNDRIGE
ORDER BY 1,2,3;

/***
year	month	day	temperature	preceding_days_avg
2020	1	10	15	NULL
2020	2	1	25	15
2020	3	3	45	20
2020	4	5	15	28.3333333333333
2020	5	7	65	25
2020	6	9	55	33
2020	7	25	65	36.6666666666667
2020	8	27	75	40.7142857142857
2020	9	25	35	45
2020	10	27	25	43.8888888888889
2020	11	25	45	42
2020	12	27	55	42.2727272727273
2021	1	10	45	43.3333333333333
2021	2	1	35	43.4615384615385
2021	3	3	15	42.8571428571429
2021	4	5	25	41
2021	5	7	35	40
2021	6	9	15	39.7058823529412
2021	7	25	45	38.3333333333333
2021	8	27	65	38.6842105263158
2021	9	25	25	40
2021	10	27	15	39.2857142857143
2021	11	25	35	38.1818181818182
2021	12	27	45	38.0434782608696
2022	1	1	15	38.3333333333333
2022	1	3	25	37.4
2022	1	5	35	36.9230769230769
2022	1	7	15	36.8518518518519
2022	1	9	25	36.0714285714286
2022	1	10	15	35.6896551724138
***/

----PREVIOUS ALL ROWS AND CURRENT ROW

SELECT year,month,day,temperature,
avg(temperature) over (partition by year, month order by year,month ROWS BETWEEN unbounded preceding and current row) rows_avg,
avg(temperature) over (partition by year, month order by year,month RANGE BETWEEN unbounded preceding and current row) range_avg
FROM MODUNDRIGE
ORDER BY 1,2,3;
/***
year	month	day	temperature	rows_avg	range_avg
2020	1	10	15	15	15
2020	2	1	25	25	25
2020	3	3	45	45	45
2020	4	5	15	15	15
2020	5	7	65	65	65
2020	6	9	55	55	55
2020	7	25	65	65	65
2020	8	27	75	75	75
2020	9	25	35	35	35
2020	10	27	25	25	25
2020	11	25	45	45	45
2020	12	27	55	55	55
2021	1	10	45	45	45
2021	2	1	35	35	35
2021	3	3	15	15	15
2021	4	5	25	25	25
2021	5	7	35	35	35
2021	6	9	15	15	15
2021	7	25	45	45	45
2021	8	27	65	65	65
2021	9	25	25	25	25
2021	10	27	15	15	15
2021	11	25	35	35	35
2021	12	27	45	45	45
2022	1	1	15	15	21.6666666666667
2022	1	3	25	20	21.6666666666667
2022	1	5	35	25	21.6666666666667
2022	1	7	15	22.5	21.6666666666667
2022	1	9	25	23	21.6666666666667
2022	1	10	15	21.6666666666667	21.6666666666667
***/

--PRECEEDING TWO ROWS AND ONE FOLLOWING ROW 

SELECT year,month,day,temperature, 
avg(temperature) over (partition by '' order by year,month,day ROWS BETWEEN 2 preceding and 1 following) last_3_days_avg
FROM  MODUNDRIGE
ORDER BY 1,2,3;

/***
year	month	day	temperature	last_3_days_avg
2020	1	10	15	20
2020	2	1	25	28.33333333
2020	3	3	45	25
2020	4	5	15	37.5
2020	5	7	65	45
2020	6	9	55	50
2020	7	25	65	65
2020	8	27	75	57.5
2020	9	25	35	50
2020	10	27	25	45
2020	11	25	45	40
2020	12	27	55	42.5
2021	1	10	45	45
2021	2	1	35	37.5
2021	3	3	15	30
2021	4	5	25	27.5
2021	5	7	35	22.5
2021	6	9	15	30
2021	7	25	45	40
2021	8	27	65	37.5
2021	9	25	25	37.5
2021	10	27	15	35
2021	11	25	35	30
2021	12	27	45	27.5
2022	1	1	15	30
2022	1	3	25	30
2022	1	5	35	22.5
2022	1	7	15	25
2022	1	9	25	22.5
2022	1	10	15	18.33333333

**/
---- previous MONTH temperature and percentage growth 

wITH MonthlySalesCTE(year, month, temperature) AS (
	SELECT	year, 
			month,
			SUM(temperature) as totaltemp
	FROM	MODUNDRIGE soh
	WHERE	YEAR = 2021
	GROUP BY YEAR, MONTH
)
SELECT	cte.Year CalendarYear, 
		cte.Month CalendarMonth,
		cte.temperature Currenttemp,
		lag(cte.temperature) over (order by cte.year,cte.month) as prev_temperature,
		CAST(((cte.temperature - SUM(soh.temperature)) / cte.temperature) AS decimal(3,2)) AS PctGrowth
FROM	MODUNDRIGE soh	
		INNER JOIN MonthlySalesCTE cte 
			ON soh.year = cte.year - 1 AND soh.month = cte.month
GROUP BY cte.year, cte.month, cte.temperature
ORDER BY cte.month DESC
 
 /****
 CalendarYear	CalendarMonth	Currenttemp	prev_temperature	PctGrowth
2021	12	45	35	-0.22
2021	11	35	15	-0.29
2021	10	15	25	-0.67
2021	9	25	65	-0.4
2021	8	65	45	-0.15
2021	7	45	15	-0.44
2021	6	15	35	-2.67
2021	5	35	25	-0.86
2021	4	25	15	0.4
2021	3	15	35	-2
2021	2	35	45	0.29
2021	1	45	NULL	0.67
*****/

--MoM YoY
SELECT
  year
  ,month
  ,temperature
  ,(temperature- LAG(temperature, 1) OVER (ORDER BY year))/LAG(temperature, 1) OVER (ORDER BY year) as 'MoM'
  ,(temperature - LAG(temperature, 12) OVER (ORDER BY year))/LAG(temperature, 12) OVER (ORDER BY year) as 'YoY'
FROM MODUNDRIGE 

/****RESULT 
year	month	temperature	MoM	YoY
2020	12	55	NULL	NULL
2020	11	45	-0.181818182	NULL
2020	10	25	-0.444444444	NULL
2020	9	35	0.4	NULL
2020	8	75	1.142857143	NULL
2020	7	65	-0.133333333	NULL
2020	1	15	-0.769230769	NULL
2020	2	25	0.666666667	NULL
2020	3	45	0.8	NULL
2020	4	15	-0.666666667	NULL
2020	5	65	3.333333333	NULL
2020	6	55	-0.153846154	NULL
2021	12	45	-0.181818182	-0.181818182
2021	11	35	-0.222222222	-0.222222222
2021	10	15	-0.571428571	-0.4
2021	9	25	0.666666667	-0.285714286
2021	8	65	1.6	-0.133333333
2021	7	45	-0.307692308	-0.307692308
2021	1	45	0	2
2021	2	35	-0.222222222	0.4
2021	3	15	-0.571428571	-0.666666667
2021	4	25	0.666666667	0.666666667
2021	5	35	0.4	-0.461538462
2021	6	15	-0.571428571	-0.727272727
2022	1	15	0	-0.666666667
2022	1	25	0.666666667	-0.285714286
2022	1	35	0.4	1.333333333
2022	1	15	-0.571428571	-0.4
2022	1	25	0.666666667	-0.615384615
2022	1	15	-0.4	-0.666666667
***//