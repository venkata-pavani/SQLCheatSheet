SELECT  dest.text, deqs.last_execution_time, deqs.execution_count 
FROM    sys.dm_exec_cached_plans AS decp
        CROSS APPLY sys.dm_exec_sql_text(decp.plan_handle) AS dest
LEFT JOIN sys.dm_exec_query_stats As deqs
ON decp.plan_handle = deqs.plan_handle
WHERE   deqs.last_execution_time > '<time>'
