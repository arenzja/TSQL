--MDF File Growth Script
SELECT 
database_id AS DatabaseID,
DB_NAME(database_id) AS DatabaseName,
Name AS Logical_Name,
Physical_Name, 
((size*8)/1024) AS SIZE,
CASE  
	-- < 100MB grow by 10MB
	WHEN ((size*8)/1024) < 100 THEN 'ALTER DATABASE [' + DB_NAME(database_id) + '] MODIFY FILE ( NAME = N''' + name + ''', FILEGROWTH = 10240KB )'
	-- 101MB to 1000MB grow by 100MB
	WHEN ((size*8)/1024) >= 100 AND ((size*8)/1024) < 1000 THEN 'ALTER DATABASE [' + DB_NAME(database_id) + '] MODIFY FILE ( NAME = N''' + name + ''', FILEGROWTH = 102400KB )'
	-- 1001MB to 5000MB grow by 500MB
	WHEN ((size*8)/1024) >= 1000 AND ((size*8)/1024) < 5000 THEN 'ALTER DATABASE [' + DB_NAME(database_id) + '] MODIFY FILE ( NAME = N''' + name + ''', FILEGROWTH = 512000KB )'
	-- 5001MB to 50000MB grow by 1000MB
	WHEN ((size*8)/1024) >= 5000 AND ((size*8)/1024) < 50000 THEN 'ALTER DATABASE [' + DB_NAME(database_id) + '] MODIFY FILE ( NAME = N''' + name + ''', FILEGROWTH = 1024000KB )'
	-- 50001MB to 100000MB grow by 5000MB
	WHEN ((size*8)/1024) >= 50000 AND ((size*8)/1024) < 100000 THEN 'ALTER DATABASE [' + DB_NAME(database_id) + '] MODIFY FILE ( NAME = N''' + name + ''', FILEGROWTH = 5120000KB )'
	-- > 100001MB grow by 10000MB
	WHEN ((size*8)/1024) >= 100000 THEN 'ALTER DATABASE [' + DB_NAME(database_id) + '] MODIFY FILE ( NAME = N''' + name + ''', FILEGROWTH = 10240000KB )'
END as GrowthCommand
FROM sys.master_files
WHERE  physical_name LIKE '%.mdf%'
AND database_id > 4
GO


--LDF File Growth Script
SELECT 
database_id AS DatabaseID,
DB_NAME(database_id) AS DatabaseName,
Name AS Logical_Name,
Physical_Name, 
((size*8)/1024) AS SIZE,
CASE  
	-- < 100MB grow by 10MB
	WHEN ((size*8)/1024) < 100 THEN 'ALTER DATABASE [' + DB_NAME(database_id) + '] MODIFY FILE ( NAME = N''' + name + ''', FILEGROWTH = 10240KB )'
	-- 101MB to 1000MB grow by 100MB
	WHEN ((size*8)/1024) >= 100 AND ((size*8)/1024) < 1000 THEN 'ALTER DATABASE [' + DB_NAME(database_id) + '] MODIFY FILE ( NAME = N''' + name + ''', FILEGROWTH = 102400KB )'
	-- 1001MB to 5000MB grow by 500MB
	WHEN ((size*8)/1024) >= 1000 AND ((size*8)/1024) < 5000 THEN 'ALTER DATABASE [' + DB_NAME(database_id) + '] MODIFY FILE ( NAME = N''' + name + ''', FILEGROWTH = 512000KB )'
	-- 5001MB to 50000MB grow by 1000MB
	WHEN ((size*8)/1024) >= 5000 AND ((size*8)/1024) < 50000 THEN 'ALTER DATABASE [' + DB_NAME(database_id) + '] MODIFY FILE ( NAME = N''' + name + ''', FILEGROWTH = 1024000KB )'
	-- 50001MB to 100000MB grow by 5000MB
	WHEN ((size*8)/1024) >= 50000 AND ((size*8)/1024) < 100000 THEN 'ALTER DATABASE [' + DB_NAME(database_id) + '] MODIFY FILE ( NAME = N''' + name + ''', FILEGROWTH = 5120000KB )'
	-- > 100001MB grow by 10000MB
	WHEN ((size*8)/1024) >= 100000 THEN 'ALTER DATABASE [' + DB_NAME(database_id) + '] MODIFY FILE ( NAME = N''' + name + ''', FILEGROWTH = 10240000KB )'
END as GrowthCommand
FROM sys.master_files
WHERE  physical_name LIKE '%.ldf%'
AND database_id > 4
GO