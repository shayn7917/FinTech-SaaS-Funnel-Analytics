WITH StatusLevels AS (
    SELECT 
        OrderID,
        CASE 
            WHEN StatusCode = 111 THEN 'Created'
            WHEN StatusCode IN (222,333) THEN 'Interacted'
            WHEN StatusCode = 444 THEN 'Login Attempted'
            WHEN StatusCode = 555 THEN 'Login Success'
            WHEN StatusCode IN (666,777,888) THEN 'MFA'
            WHEN StatusCode = 999 THEN 'Harvest Completed'
            WHEN StatusCode IN (1212,2323) THEN 'VOIE'
            WHEN StatusCode = 3434 THEN 'Completed'
            ELSE 'Other'
        END AS StageName
    FROM FunnelLogs
)
SELECT StageName, COUNT(DISTINCT OrderID) AS Orders
FROM StatusLevels
GROUP BY StageName
ORDER BY Orders DESC;
