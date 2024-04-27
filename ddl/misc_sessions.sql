SELECT * 
  FROM sys.dm_exec_requests
  WHERE DB_NAME(database_id) = 'rvd' 
    AND blocking_session_id <> 0

SELECT 
    DB_NAME(dbid) as DBName, 
    COUNT(dbid) as NumberOfConnections,
    loginame as LoginName
FROM
    sys.sysprocesses
WHERE 
    dbid > 0
GROUP BY 
    dbid, loginame

sp_who2