DECLARE @StartDate DATETIME = '2021-01-01'
DECLARE @EndDate DATETIME = '2021-02-29'
SELECT
[date_id] [SourceDate]
,[queue_id]
,SUM([nEntered]) [nOffered]
,SUM([nAccepted]) [nAccepted]
,SUM([nAccepted_Online_0_5sec])+SUM([nAccepted_Online_5_10sec])+SUM([nAccepted_Online_10_20sec])+SUM([nAccepted_Online_20_30sec]) [nSLA]
,SUM([nAccepted_Online_0_5sec])+SUM([nAccepted_Online_5_10sec]) [nServiceLvl1]
,SUM([nAccepted_Online_10_20sec]) [nServiceLvl2]
,SUM([nAccepted_Online_20_30sec]) [nServiceLvl3]
,SUM([nAbandoned]) [nAbandoned]
,SUM([tProcessing])/60 [Handle Time (in Minutes)]

FROM [TESTSERVER2].[paqa_web].[CC_Status_View_Data]
WHERE [date_id] >= @StartDate AND [date_id] < @EndDate
GROUP BY
[queue_id]
,[queue_name]
,[date_id]
ORDER BY SourceDate
