WITH StatusLevels AS (
    SELECT 
        OrderID,
        CASE 
            WHEN StatusCode = 111 THEN 0
            WHEN StatusCode IN (222,333) THEN 1
            WHEN StatusCode = 444 THEN 2
            WHEN StatusCode = 555 THEN 3
            WHEN StatusCode IN (666,777) THEN 4
            WHEN StatusCode = 999 THEN 5
            WHEN StatusCode IN (1212,2323) THEN 6
            WHEN StatusCode = 3434 THEN 7
            ELSE NULL
        END AS StageLevel
    FROM FunnelLogs
),
MaxStages AS (
    SELECT OrderID, MAX(StageLevel) AS MaxStageLevel
    FROM StatusLevels
    GROUP BY OrderID
)
SELECT
    COUNT(*) AS TotalOrders,
    SUM(CASE WHEN MaxStageLevel >= 1 THEN 1 ELSE 0 END) AS Interacted,
    SUM(CASE WHEN MaxStageLevel >= 2 THEN 1 ELSE 0 END) AS LoginAttempted,
    SUM(CASE WHEN MaxStageLevel >= 3 THEN 1 ELSE 0 END) AS LoginSuccess,
    SUM(CASE WHEN MaxStageLevel >= 4 THEN 1 ELSE 0 END) AS MFAStage,
    SUM(CASE WHEN MaxStageLevel >= 7 THEN 1 ELSE 0 END) AS Completed,
    ROUND(SUM(CASE WHEN MaxStageLevel >= 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS ActivationRate,
    ROUND(SUM(CASE WHEN MaxStageLevel >= 3 THEN 1 ELSE 0 END) * 100.0 /
          NULLIF(SUM(CASE WHEN MaxStageLevel >= 2 THEN 1 ELSE 0 END),0), 2) AS LoginSuccessRate,
    ROUND(SUM(CASE WHEN MaxStageLevel >= 7 THEN 1 ELSE 0 END) * 100.0 /
          NULLIF(SUM(CASE WHEN MaxStageLevel >= 1 THEN 1 ELSE 0 END),0), 2) AS CompletionRate,
    ROUND(SUM(CASE WHEN MaxStageLevel >= 7 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS PullthroughRate
FROM MaxStages;
