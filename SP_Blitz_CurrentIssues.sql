DECLARE @ckDate DATE

SELECT  @ckDate = CAST(MAX(CheckDate) AS DATE)
FROM    DBA.dbo.SP_Blitz_Results

SELECT  --ServerName ,
        --CheckDate ,
        PRIORITY ,
        FindingsGroup ,
        Finding ,
        DatabaseName ,
        URL ,
        Details
FROM    dba.dbo.SP_Blitz_Results
WHERE   CAST(CheckDate AS DATE) = @ckDate
AND ServerName = 'DEVS1A'
ORDER BY PRIORITY