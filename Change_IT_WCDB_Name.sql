SELECT 'ALTER LOGIN [WCG\sql server admins] WITH DEFAULT_DATABASE = TEMPDB' FROM sys.syslogins WHERE name = 'wcg\sql server admins'
GO

USE master;
GO
ALTER DATABASE [IS_WCDB]
Modify Name = IT_WCDB ;
GO


DECLARE @SQL NVARCHAR(MAX)
set rowcount 0
SELECT 'ALTER LOGIN [' + name + '] WITH DEFAULT_DATABASE = IT_WCDB' AS NAME INTO #DEFDB FROM sys.syslogins WHERE dbname = 'IS_WCDB' 

set rowcount 1
select @SQL = NAME from #DEFDB

while @@rowcount <> 0
begin
    set rowcount 0
    EXEC sys.sp_executesql @SQL
    delete #DEFDB where NAME = @SQL

    set rowcount 1
    select @SQL = NAME from #DEFDB
end
set rowcount 0
DROP TABLE #DEFDB

GO