USE master
GO
EXEC dbo.sp_foreachdb "EXEC ?.dbo.sp_changedbowner @loginame = N'sa', @map = false"