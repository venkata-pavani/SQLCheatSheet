--############## QUERY GIVES MOST RECENT BACKUPS AND FILE SIZES

WITH 
   MostRecentBackups
   AS(
      SELECT
         database_name AS [Database],
         MAX(bus.backup_finish_date) AS LastBackupTime,
         CASE bus.type
            WHEN 'D' THEN 'Full'
         END AS Type
      FROM msdb.dbo.backupset bus
      WHERE bus.type <> 'F'
      GROUP BY bus.database_name,bus.type
   ),
   BackupsWithSize
   AS(
      SELECT
	mrb.*,
	(SELECT TOP 1 CONVERT(DECIMAL(10,2), b.compressed_backup_size/1024/1024) AS backup_size FROM msdb.dbo.backupset b WHERE [Database] = b.database_name AND LastBackupTime = b.backup_finish_date) AS [Backup Size],
	(SELECT TOP 1 DATEDIFF(s, b.backup_start_date, b.backup_finish_date) FROM msdb.dbo.backupset b WHERE [Database] = b.database_name AND LastBackupTime = b.backup_finish_date) AS [Seconds],
        (SELECT TOP 1 b.media_set_id FROM msdb.dbo.backupset b WHERE [Database] = b.database_name AND LastBackupTime = b.backup_finish_date) AS media_set_id
      FROM MostRecentBackups mrb
   )

SELECT
    d.name AS [Database],
    d.state_desc AS State,
    bf.LastBackupTime AS [LastFull],
    DATEDIFF(DAY,bf.LastBackupTime,GETDATE()) AS [TimeSinceLastFullInDays],
    bf.[Backup Size] AS [FullBackupSizeInMB],
    bf.Seconds AS [FullBackupSecondsToComplete],
    CASE WHEN DATEDIFF(DAY,bf.LastBackupTime,GETDATE()) > 14 THEN NULL ELSE (SELECT TOP 1 bmf.physical_device_name FROM msdb.dbo.backupmediafamily bmf WHERE bmf.media_set_id = bf.media_set_id AND bmf.device_type = 2) END AS [FullBackupLocalPath],     
	(SELECT CONVERT(DECIMAL(10,2),SUM(size)*8.0/1024) AS size FROM sys.master_files WHERE type = 0 AND d.name = DB_NAME(database_id)) AS DataFileSize,
    (SELECT CONVERT(DECIMAL(10,2),SUM(size)*8.0/1024) AS size FROM sys.master_files WHERE type = 1 AND d.name = DB_NAME(database_id)) AS LogFileSize
FROM sys.databases d
LEFT JOIN BackupsWithSize bf ON (d.name = bf.[Database] AND (bf.Type = 'Full' OR bf.Type IS NULL))
WHERE d.name <> 'tempdb' AND d.source_database_id IS NULL
ORDER BY d.name
