## Had to load in file without the CHARACTER SET utf8mb4:
LOAD DATA INFILE 'AirlineDataset_Cleaned.csv'
INTO TABLE airline_data
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SET SQL_SAFE_UPDATES = 0;

#Remove passenger id,pilot, and airport country code name since they aren't necessarry
SELECT * FROM airlinedataset_cleaned LIMIT 0, 1000;
Alter Table airlinedataset_cleaned 
Drop Column `Passenger ID`,
DROP Column `Airport Country Code`,
Drop Column `Pilot Name`;

#Handle Missing Values 
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN `Age` IS NULL THEN 1 ELSE 0 END) AS missing_age,
    SUM(CASE WHEN `Departure Date` IS NULL THEN 1 ELSE 0 END) AS missing_departure_date,
    SUM(CASE WHEN `Arrival Airport` IS NULL OR `Arrival Airport` = '' THEN 1 ELSE 0 END) AS missing_airport
FROM airlinedataset_cleaned;

#Make Sure Nulls are accounted for
UPDATE airlinedataset_cleaned
SET `Arrival Airport` = 'Unknown'
WHERE `Arrival Airport` IS NULL OR `Arrival Airport` = '';

#Make sure numerical values are accounted for
Update airlinedataset_cleaned as main_table
Join (
	Select AVG(Age) As avg_age
    From airlinedataset_cleaned
    Where Age is not null
) As avg_table
Set main_table.Age = avg_table.avg_age
Where main_table.Age IS NULL;

## Check for Outliers in Age
SELECT Age 
FROM airlinedataset_cleaned 
WHERE Age < 0 OR Age > 120;

#Clean up the Departure Dates to have consistent formatting ie YYYY/MM/DD
## First we need to identify every date without a leading 0 in either the front of the / or in between the / /
Select `Departure Date` 
From airlinedataset_cleaned
Where `Departure Date` REGEXP '^[1-9]/' OR `Departure Date` REGEXP '/[1-9]/';

Update airlinedataset_cleaned
Set `Departure Date` = concat(
	LPAD(SUBSTRING_INDEX(`Departure Date`, '/', 1), 2, '0'), '/', ## Month
    LPAD(SUBSTRING_INDEX(SUBSTRING_INDEX(`Departure Date`, '/', -2), '/', 1), 2, '0'), '/', ## Day
    SUBSTRING_INDEX(`Departure Date`, '/', -1) ## Year
    )
WHERE `Departure Date` REGEXP '^[1-9]/' 
   OR `Departure Date` REGEXP '/[1-9]/';

## Update to YYYY/MM/DD
Update airlinedataset_cleaned
SET `Departure Date` = STR_TO_DATE(`Departure Date`, '%m/%d/%Y');

## Want to categorize the ages to 'minor', 'adult', and 'senior'
Alter table airlinedataset_cleaned
add column `Age Group` VARCHAR(15);

Update airlinedataset_cleaned
Set `Age Group` = CASE
	When Age < 18 THEN 'Minor'
    When Age Between 18 and 60 Then 'Adult'
    Else 'Senior'
End;
    
#Move the age group next to the age
Alter table airlinedataset_cleaned
modify `Age Group` VARCHAR(15) After Age;    

## Create a column for seasons based on departure date
Alter table airlinedataset_cleaned
add column `Season` VARCHAR(15);

Update airlinedataset_cleaned
Set `Season` = CASE 
	When MONTH(`Departure Date`) In (12, 1, 2) Then 'Winter'
    When Month(`Departure Date`) IN (3, 4, 5) Then 'Spring'
    When Month(`Departure Date`) IN (6,7,8) Then 'Summer'
    Else 'Fall'
End;

Alter table airlinedataset_cleaned
modify `Season` VARCHAR(15) After `Departure Date`; 


## Add a weekend column
Alter table airlinedataset_cleaned
Add column `Weekend` BOOLEAN;

Update airlinedataset_cleaned
Set `Weekend` = CASE
	When DAYOFWEEK(`Departure Date`) IN (1,7) THEN TRUE
    ELSE FALSE
    END;

Alter table airlinedataset_cleaned
modify `Weekend` BOOLEAN After `Departure Date`;

## Top 5 Desitnations based on Seasons
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


### Export the Cleaned data
Select * INTO Outfile 'final__cleaned_airlinedataset.csv'
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
FROM airlinedataset_cleaned;
