USE [master]
GO
SELECT 'ALTER DATABASE [' + name + '] SET PAGE_VERIFY CHECKSUM  WITH NO_WAIT;' FROM sys.databases WHERE page_verify_option_desc <> 'checksum'