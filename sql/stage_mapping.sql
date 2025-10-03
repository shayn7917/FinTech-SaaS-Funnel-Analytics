-- Map StatusCode into funnel stages
SELECT 
    OrderID,
    StatusCode,
    StatusName,
    CASE 
        WHEN StatusCode = 111 THEN 0   -- Created
        WHEN StatusCode IN (222,333) THEN 1 -- Interacted
        WHEN StatusCode = 444 THEN 2   -- Login Attempted
        WHEN StatusCode = 555 THEN 3   -- Login Success
        WHEN StatusCode IN (666,777,888) THEN 4 -- MFA
        WHEN StatusCode = 999 THEN 5   -- Harvest Completed
        WHEN StatusCode IN (1212,2323) THEN 6 -- VOIE
        WHEN StatusCode = 3434 THEN 7  -- Completed
        WHEN StatusCode = 4545 THEN 8  -- Closed
        WHEN StatusCode = 5656 THEN 9  -- Churned
        WHEN StatusCode IN (123,234,456) THEN 10 -- Errors
        WHEN StatusCode = 543 THEN 11  -- Timeout
        WHEN StatusCode IN (321,3456) THEN 12 -- Cancelled
    END AS StageLevel
FROM FunnelLogs;
