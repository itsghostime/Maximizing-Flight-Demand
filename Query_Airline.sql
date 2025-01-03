## What are the 5 Desitnations based on Seasons?
WITH PopularDestinations AS (
    SELECT 
        Season,
        `Airport Name` AS Destination,
        COUNT(*) AS PassengerCount
    FROM airlinedataset_cleaned
    GROUP BY Season, Destination
)
SELECT 
    Season,
    Destination,
    PassengerCount
FROM PopularDestinations
ORDER BY Season, PassengerCount DESC
LIMIT 5;


## Segmented the Age Group and Gender
WITH PassengerSegments AS (
    SELECT 
        `Age Group`,
        Gender,
        COUNT(*) AS PassengerCount
    FROM airlinedataset_cleaned
    GROUP BY `Age Group`, Gender
)
SELECT * FROM PassengerSegments;


## Table for Seasonal Delays
CREATE TEMPORARY TABLE SeasonalDelays AS
SELECT 
    Season,
    `Country Name`,
    COUNT(CASE WHEN `Flight Status` = 'Delayed' THEN 1 END) AS DelayedFlights,
    COUNT(*) AS TotalFlights,
    ROUND(COUNT(CASE WHEN `Flight Status` = 'Delayed' THEN 1 END) * 100.0 / COUNT(*), 2) AS DelayPercentage
FROM airlinedataset_cleaned
GROUP BY Season, `Country Name`;

## Query the temporary table
SELECT * FROM SeasonalDelays
WHERE DelayPercentage > 20
ORDER BY DelayPercentage DESC;

## Analyze customer demographics (age group and nationality)
SELECT 
    `Age Group`,
    Nationality,
    COUNT(*) AS PassengerCount
FROM airlinedataset_cleaned
GROUP BY `Age Group`, Nationality
ORDER BY PassengerCount DESC
LIMIT 10;

#Recursive CTE for Trend Analysis
WITH RecursiveTrends AS (
    SELECT 
        `Departure Date`,
        COUNT(*) AS DailyFlights
    FROM airlinedataset_cleaned
    GROUP BY `Departure Date`
),
CumulativeFlights AS (
    SELECT 
        `Departure Date`,
        SUM(DailyFlights) OVER (ORDER BY `Departure Date`) AS CumulativeFlights
    FROM RecursiveTrends
)
SELECT * FROM CumulativeFlights;

