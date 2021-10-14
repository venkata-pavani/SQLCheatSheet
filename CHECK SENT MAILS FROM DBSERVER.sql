SELECT * FROM msdb.dbo.sysmail_sentitems
	 where subject like '%triple%'
	 and day(sent_date) = 15
	 and month(sent_date) = 01
	 and year(sent_date) = 2021
SELECT
    *
FROM msdb.dbo.sysmail_allitems
where year(sent_date) = 2021
and day(sent_date) = 15
