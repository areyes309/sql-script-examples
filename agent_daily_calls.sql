DECLARE @last_businessday AS DATE
DECLARE @weekend NVARCHAR(10) = '1,7'
SET @last_businessday =
  (SELECT TOP 1 date_id
   FROM util_dates
   WHERE date_id < Cast(Getdate() AS DATE)
     AND weekday_id NOT IN (SELECT value FROM String_split(@weekend, ',')) AND holiday = 0 ORDER  BY date_id DESC)

SELECT * FROM agent_calls where ymd = REPLACE(@last_businessday,'-','')
