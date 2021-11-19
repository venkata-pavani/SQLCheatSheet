

SELECT * FROM monthly_sales 

/*MONTH	PRRODUCT_ID	AMOUNT_SOLD
2021-01-01	1	10
2021-01-01	2	300
2021-02-01	3	200
2021-03-01	4	250 
*/

/* **  **  *** Query for TOTAL AMOUNT OF EACH PRODUCT SOLD EACH MONTH AND EACH PRODUCT HAS OWN TABLE IN OUTPUT COLUMN*** *** *** ***/


/************************** ###   **** SOLUTION ONE *** ##### *************************************/
 select month,
sum(case when PRRODUCT_ID = 1 then amount_sold else 0 end ) as '1',
sum(case when PRRODUCT_ID = 2 then amount_sold else 0 end ) as '2',
sum(case when PRRODUCT_ID = 3 then amount_sold else 0 end ) as '3',
sum(case when PRRODUCT_ID = 4 then amount_sold else 0 end ) as '4'
from monthly_sales
group by month

/************************** ###   **** SOLUTION TWO *** ##### *************************************/
-- this solution has NULLS in the answer
select *
from 
(
  select MONTH, PRRODUCT_ID,  AMOUNT_SOLD
  from monthly_sales 
) src
pivot
(
 sum(AMOUNT_SOLD)
  for PRRODUCT_ID in ([1], [2], [3],[4])
) piv
