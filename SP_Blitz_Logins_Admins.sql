SELECT  ServerName ,
        Finding ,
		Details,
		SUBSTRING(Details,CHARINDEX('[',Details),(CHARINDEX(']',Details)-CHARINDEX('[',Details)+1))
FROM    DBA.dbo.SP_Blitz_Results
WHERE   CAST(CheckDate AS DATE) = '2014-01-26'
        AND Finding LIKE '%admins%'