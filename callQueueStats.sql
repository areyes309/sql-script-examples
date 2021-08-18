DECLARE @StartDate DATETIME = '"&Date.ToText(Start, "yyyy-MM-dd")&"'
DECLARE @EndDate DATETIME = '"&Date.ToText(CurrentEnd, "yyyy-MM-dd")&"'

SELECT TOP (1000)
--DATEADD(m,DATEDIFF(m,0,[date_id]),0) [SourceDate]
 [date_id] [SourceDate]
      ,[queue_id]
      ,[queue_name]
      ,[queue_type]
      ,[channel_id]
      ,[channel_desc]
      ,[media_type]
     
      
    ,SUM([nEntered]) [nOffered] 
    ,SUM([nAccepted]) [nAccepted]
,SUM([nAccepted_Online_0_5sec])+SUM([nAccepted_Online_5_10sec])+SUM([nAccepted_Online_10_20sec])+SUM([nAccepted_Online_20_30sec])   [nSLA]
      ,SUM([nAccepted_Online_0_5sec])+SUM([nAccepted_Online_5_10sec]) [nServiceLvl1]
      
      ,SUM([nAccepted_Online_10_20sec]) [nServiceLvl2]
      ,SUM([nAccepted_Online_20_30sec]) [nServiceLvl3]

    ,SUM([nAbandoned]) [nAbandoned]
    ,SUM([tProcessing])/60  [Handle Time (in Minutes)]

  FROM [DatabaseName].[paqa_web].[CC_stats_view]
  WHERE [date_id] >= @StartDate AND [date_id] < @EndDate
GROUP BY      
		[queue_id]
      ,[queue_name]
      ,[queue_type]
      ,[channel_id]
      ,[channel_desc]
      ,[media_type]
	  --,DATEADD(m,DATEDIFF(m,0,[date_id]),0)
 ,[date_id]
ORDER BY SourceDate
--,[date_id]
"