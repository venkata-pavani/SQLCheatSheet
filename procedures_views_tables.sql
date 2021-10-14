  -- #########################  -- ##  -- ## GP Check for Invalid Customer & Vendor Data Entry  -- ##  -- #########################      BEGIN      SET NOCOUNT ON;          /* declare variables for all checks */        DECLARE @AlertName nvarchar(255),                 @EmailSubject nvarchar(255),                 @EmailBodyFormat nvarchar(20),                 @EmailBody nvarchar(max),                @EmailImportance nvarchar(6),                @EmailSensitivity nvarchar(12),                @EmailTo nvarchar(500),                 @EmailCc nvarchar(100),                 @EmailBcc nvarchar(100),                @QueryDB nvarchar(128),                @cssBody nvarchar(max),                @cssTable nvarchar(max),                @sqlText nvarchar(max),                @html nvarchar(max)          SET     @AlertName = 'GP Invalid Data Entry Check';          SELECT  @EmailSubject = EmailSubject,                 @EmailBodyFormat = EmailBodyFormat,                @EmailBody = EmailBody,                @EmailImportance = EmailImportance,                @EmailSensitivity = EmailSensitivity,                @EmailTo = EmailTo,                 @EmailCc = EmailCc,                 @EmailBcc = EmailBcc,                @QueryDB = QueryDB,                @cssBody = cssBody,                @cssTable = cssTable        FROM    Alerts.dbo.AlertConfig         WHERE   AlertName = @AlertName;        /* MKCGP customer master data validation */          SELECT 1 FROM MKCGP.dbo.vmkcCustCheck      IF @@ROWCOUNT > 0          BEGIN          -- set specific variables          SET @sqlText = N'SELECT * FROM [MKCGP].[dbo].[vmkcCustCheck] ORDER BY [CUSTNMBR]'          SET @EmailSubject = N'ALERT: GP Invalid MKC Customer Data Entry '          SET @EmailBody = N'Customer data entry is incorrect on the following customers... <br><br>'          SET @EmailTo = N'credit@mkcoop.com; lthiesen@mkcoop.com '          SET @EmailCc = N''          SET @EmailBcc = N'pavani.nrusimhadevara@mkcoop.com'          -- get the HTML          EXEC Alerts.dbo.GenerateHtmlTableFromSQL @sqlText, @html OUTPUT          -- set email body with html formatting          SET @EmailBody = @cssBody + @EmailBody + @cssTable + @html          -- send the email          EXEC msdb.dbo.sp_send_dbmail                @recipients = @EmailTo,                @copy_recipients = @EmailCc,                @blind_copy_recipients = @EmailBcc,                @importance = @EmailImportance,                @sensitivity= @EmailSensitivity,                @body_format = @EmailBodyFormat,                @subject = @EmailSubject,                @body = @EmailBody,                @query_result_no_padding = 1,                @attach_query_result_as_file = 0;        END;        /* HAVEN customer master data validation */          SELECT 1 FROM HAVEN.dbo.vmkcCustCheck      IF @@ROWCOUNT > 0          BEGIN          -- set specific variables          SET @sqlText = N'SELECT * FROM [HAVEN].[dbo].[vmkcCustCheck] ORDER BY [CUSTNMBR]'          SET @EmailSubject = N'ALERT: GP Invalid FarmKan Customer Data Entry '          SET @EmailBody = N'Customer data entry is incorrect on the following customers... <br><br>'          SET @EmailTo = N'hherman@mkcoop.com; credit@mkcoop.com; lthiesen@mkcoop.com '          SET @EmailCc = N''          SET @EmailBcc = N'pavani.nrusimhadevara@mkcoop.com'          -- get the HTML          EXEC Alerts.dbo.GenerateHtmlTableFromSQL @sqlText, @html OUTPUT          -- set email body with html formatting          SET @EmailBody = @cssBody + @EmailBody + @cssTable + @html          -- send the email          EXEC msdb.dbo.sp_send_dbmail                @recipients = @EmailTo,                @copy_recipients = @EmailCc,                @blind_copy_recipients = @EmailBcc,                @importance = @EmailImportance,                @sensitivity= @EmailSensitivity,                @body_format = @EmailBodyFormat,                @subject = @EmailSubject,                @body = @EmailBody,                @query_result_no_padding = 1,                @attach_query_result_as_file = 0;        END;        /* vendor master data validation */      SELECT 1 FROM MKCGP.dbo.vmkcVendCheck      IF @@ROWCOUNT > 0           BEGIN          -- set specific variables          SET @sqlText = N'SELECT * FROM [MKCGP].[dbo].[vmkcVendCheck]'          SET @EmailSubject = N'ALERT: GP Invalid MKC Vendor Data Entry '          SET @EmailBody = N'Vendor data entry is incorrect on the following vendors... <br><br>'          SET @EmailTo = N'lthiesen@mkcoop.com'          SET @EmailCc = N''          SET @EmailBcc = N'pavani.nrusimhadevara@mkcoop.com'          -- get the HTML          EXEC Alerts.dbo.GenerateHtmlTableFromSQL @sqlText, @html OUTPUT          -- set email body with html formatting          SET @EmailBody = @cssBody + @EmailBody + @cssTable + @html          -- send the email          EXEC msdb.dbo.sp_send_dbmail                @recipients = @EmailTo,                @copy_recipients = @EmailCc,                @blind_copy_recipients = @EmailBcc,                @importance = @EmailImportance,                @sensitivity= @EmailSensitivity,                @body_format = @EmailBodyFormat,                @subject = @EmailSubject,                @body = @EmailBody,                @query_result_no_padding = 1,                @attach_query_result_as_file = 0;        END;        /* customer table data validation between master and address */      SELECT 1 FROM MKCGP.dbo.vmkcCustAddrCheck      IF @@ROWCOUNT > 0           BEGIN          -- set specific variables          SET @sqlText = N'SELECT * FROM [MKCGP].[dbo].[vmkcCustAddrCheck] ORDER BY [CUSTNMBR]'          SET @EmailSubject = N'ALERT: GP Customer Address Table Mismatch '          SET @EmailBody = N'Customer data mismatched on the following entries... <br><br>'          SET @EmailTo = N'credit@mkcoop.com; lthiesen@mkcoop.com '          SET @EmailCc = N''          SET @EmailBcc = N'pavani.nrusimhadevara@mkcoop.com'          -- get the HTML          EXEC Alerts.dbo.GenerateHtmlTableFromSQL @sqlText, @html OUTPUT          -- set email body with html formatting          SET @EmailBody = @cssBody + @EmailBody + @cssTable + @html          -- send the email          EXEC msdb.dbo.sp_send_dbmail                @recipients = @EmailTo,                @copy_recipients = @EmailCc,                @blind_copy_recipients = @EmailBcc,                @importance = @EmailImportance,                @sensitivity= @EmailSensitivity,                @body_format = @EmailBodyFormat,                @subject = @EmailSubject,                @body = @EmailBody,                @query_result_no_padding = 1,                @attach_query_result_as_file = 0;        END;        /* vendor table data validation between master and address */      SELECT 1 FROM MKCGP.dbo.vmkcVendAddrCheck      IF @@ROWCOUNT > 0           BEGIN          -- set specific variables          SET @sqlText = N'SELECT * FROM [MKCGP].[dbo].[vmkcVendAddrCheck] ORDER BY [VENDORID]'          SET @EmailSubject = N'ALERT: GP Vendor Address Table Mismatch '          SET @EmailBody = N'Vendor data mismatched on the following entries... <br><br>'          SET @EmailTo = N'credit@mkcoop.com; lthiesen@mkcoop.com '          SET @EmailCc = N''          SET @EmailBcc = N'pavani.nrusimhadevara@mkcoop.com'          -- get the HTML          EXEC Alerts.dbo.GenerateHtmlTableFromSQL @sqlText, @html OUTPUT          -- set email body with html formatting          SET @EmailBody = @cssBody + @EmailBody + @cssTable + @html          -- send the email          EXEC msdb.dbo.sp_send_dbmail                @recipients = @EmailTo,                @copy_recipients = @EmailCc,                @blind_copy_recipients = @EmailBcc,                @importance = @EmailImportance,                @sensitivity= @EmailSensitivity,                @body_format = @EmailBodyFormat,                @subject = @EmailSubject,                @body = @EmailBody,                @query_result_no_padding = 1,                @attach_query_result_as_file = 0;        END;        SET NOCOUNT OFF;    END;  

  --#################################CHECK PROCEDURES/VIEWS/JOBS IN SQL SERVER##################################################################


  select objects.name,objects.type,
modules.definition 
 from sys.sql_modules modules
 join sys.objects objects
 on objects.object_id=modules.object_id
 WHERE modules.definition like '%Vendor%Data%Entry%'
 and objects.type='P'



SELECT Name
FROM sys.procedures
WHERE OBJECT_DEFINITION(OBJECT_ID) LIKE '%vmkcCustCheck%'


select distinct [Table Name] = o.Name, [Found In] = sp.Name, sp.type_desc
  from sys.objects o inner join sys.sql_expression_dependencies  sd on o.object_id = sd.referenced_id
                inner join sys.objects sp on sd.referencing_id = sp.object_id
                    and sp.type in ('P', 'FN')
  where o.name = 'vmkcCustCheck'
  order by sp.Name


  select
    object_name(m.object_id), m.*
from
    sys.sql_modules m
where
    m.definition like N'%vmkcCustCheck%'

SELECT
    *
FROM
    INFORMATION_SCHEMA.ROUTINES 
WHERE
    ROUTINE_TYPE='PROCEDURE' AND
    ROUTINE_DEFINITION LIKE '%vmkcCustCheck%'


	select 
*
From msdb.dbo.sysjobs j 
INNER JOIN msdb.dbo.sysjobsteps s 
 ON j.job_id = s.job_id
INNER JOIN msdb.dbo.sysjobhistory h 
 ON s.job_id = h.job_id 
 AND s.step_id = h.step_id 
 AND h.step_id <> 0
where j.enabled = 1 
and s.step_name like '%GP%Mismatch%'  --Only Enabled Jobs
--and j.name = 'TestJob' --Uncomment to search for a single job
/*
and msdb.dbo.agent_datetime(run_date, run_time) 
BETWEEN '12/08/2012' and '12/10/2012'  --Uncomment for date range queries
*/
--order by JobName, RunDateTime desc