-- AIRLINE OPERATIONS PERFORMANCE ANALYSIS
-- SQL Exploratory Analysis
-- Objective:
-- Analyse flight operations data to identify patterns in delays,
-- cancellations, route performance and operational disruption.
--
-- Delayed arrival is defined as arriving more than 15 minutes late.

-- 1. DATASET OVERVIEW
-- Total number of scheduled flights
SELECT COUNT(*) AS total_flights
FROM Airports;


-- Total number of cancelled flights
SELECT COUNT(*) AS cancelled_flights
FROM Airports
WHERE CANCELLED = 1;


-- Total number of diverted flights
SELECT COUNT(*) AS diverted_flights
FROM Airports
WHERE DIVERTED = 1;

-- 2. OVERALL OPERATIONAL PERFORMANCE
-- Average arrival delay across completed flights
SELECT AVG(ARR_DELAY) AS average_arrival_delay
FROM Airports;

-- Overall flight cancellation rate (%)
SELECT
    SUM(
        CASE
            WHEN CANCELLED = 1 THEN 1
            ELSE 0
        END
    ) * 100.0 / COUNT(*) AS cancellation_rate
FROM Airports;

-- Percentage of completed flights arriving more than 15 minutes late
SELECT
    SUM(
        CASE
            WHEN ARR_DELAY > 15 THEN 1
            ELSE 0
        END
    ) * 100.0 / COUNT(ARR_DELAY) AS delayed_arrival_rate
FROM Airports;

-- 3. AIRPORT AND ROUTE PERFORMANCE
-- Origin airports with the highest average arrival delays
-- Limited to airports with at least 1,000 scheduled flights
SELECT ORIGIN,
       AVG(ARR_DELAY) AS average_delay,
       COUNT(*) AS no_of_flights
FROM Airports
GROUP BY ORIGIN
HAVING COUNT(*) >= 1000
ORDER BY average_delay DESC
LIMIT 10;

-- Routes with the highest average arrival delays
-- Limited to routes with at least 100 scheduled flights
SELECT ORIGIN,
       DEST,
       AVG(ARR_DELAY) AS average_delay,
       COUNT(*) AS no_of_flights
FROM Airports
GROUP BY ORIGIN, DEST
HAVING COUNT(*) >= 100
ORDER BY average_delay DESC
LIMIT 10;

-- 4. DELAY CAUSE ANALYSIS
-- Total recorded delay minutes by delay category
SELECT
    SUM(CARRIER_DELAY) AS carrier_delay_minutes,
    SUM(WEATHER_DELAY) AS weather_delay_minutes,
    SUM(NAS_DELAY) AS nas_delay_minutes,
    SUM(SECURITY_DELAY) AS security_delay_minutes,
    SUM(LATE_AIRCRAFT_DELAY) AS late_aircraft_delay_minutes
FROM Airports;

-- Total recorded delay minutes across all delay categories
SELECT
    SUM(CARRIER_DELAY)
    + SUM(WEATHER_DELAY)
    + SUM(NAS_DELAY)
    + SUM(SECURITY_DELAY)
    + SUM(LATE_AIRCRAFT_DELAY) AS total_delay_minutes
FROM Airports;

-- Percentage contribution of each recorded delay category
SELECT
    SUM(CARRIER_DELAY) * 100.0 /
    (
        SUM(CARRIER_DELAY)
        + SUM(WEATHER_DELAY)
        + SUM(NAS_DELAY)
        + SUM(SECURITY_DELAY)
        + SUM(LATE_AIRCRAFT_DELAY)
    ) AS carrier_delay_percentage,

    SUM(WEATHER_DELAY) * 100.0 /
    (
        SUM(CARRIER_DELAY)
        + SUM(WEATHER_DELAY)
        + SUM(NAS_DELAY)
        + SUM(SECURITY_DELAY)
        + SUM(LATE_AIRCRAFT_DELAY)
    ) AS weather_delay_percentage,

    SUM(NAS_DELAY) * 100.0 /
    (
        SUM(CARRIER_DELAY)
        + SUM(WEATHER_DELAY)
        + SUM(NAS_DELAY)
        + SUM(SECURITY_DELAY)
        + SUM(LATE_AIRCRAFT_DELAY)
    ) AS nas_delay_percentage,

    SUM(SECURITY_DELAY) * 100.0 /
    (
        SUM(CARRIER_DELAY)
        + SUM(WEATHER_DELAY)
        + SUM(NAS_DELAY)
        + SUM(SECURITY_DELAY)
        + SUM(LATE_AIRCRAFT_DELAY)
    ) AS security_delay_percentage,

    SUM(LATE_AIRCRAFT_DELAY) * 100.0 /
    (
        SUM(CARRIER_DELAY)
        + SUM(WEATHER_DELAY)
        + SUM(NAS_DELAY)
        + SUM(SECURITY_DELAY)
        + SUM(LATE_AIRCRAFT_DELAY)
    ) AS late_aircraft_delay_percentage
FROM Airports;

-- 5. TIME-OF-DAY PERFORMANCE
-- Average arrival delay by scheduled departure period
SELECT
    CASE
        WHEN CRS_DEP_TIME >= 500 AND CRS_DEP_TIME < 1200 THEN 'Morning'
        WHEN CRS_DEP_TIME >= 1200 AND CRS_DEP_TIME <= 1759 THEN 'Afternoon'
        WHEN CRS_DEP_TIME >= 1800 AND CRS_DEP_TIME <= 2159 THEN 'Evening'
        ELSE 'Night'
    END AS time_of_day,
    AVG(ARR_DELAY) AS average_delay
FROM Airports
GROUP BY time_of_day;

-- 6. CANCELLATION AND DELAY HOTSPOTS
-- Major origin airports with the highest cancellation rates
-- Limited to airports with at least 1,000 scheduled flights
SELECT ORIGIN,
       SUM(CANCELLED) * 100.0 / COUNT(*) AS cancellation_rate
FROM Airports
GROUP BY ORIGIN
HAVING COUNT(*) >= 1000
ORDER BY cancellation_rate DESC
LIMIT 10;


-- Routes with the highest delayed-arrival rates
-- Delayed arrival defined as more than 15 minutes late
-- Limited to routes with at least 100 scheduled flights
SELECT ORIGIN,
       DEST,
       SUM(
           CASE
               WHEN ARR_DELAY > 15.0 THEN 1
               ELSE 0
           END
       ) * 100.0 / COUNT(ARR_DELAY) AS delayed_arrival_rate
FROM Airports
GROUP BY ORIGIN, DEST
HAVING COUNT(*) >= 100
ORDER BY delayed_arrival_rate DESC
LIMIT 10;


-- 7. MANAGEMENT PRIORITY ROUTES
-- Identify high-volume routes with poor arrival performance
-- Limited to routes with at least 500 scheduled flights
SELECT ORIGIN,
       DEST,
       COUNT(*) AS number_of_flights,
       AVG(ARR_DELAY) AS average_arrival_delay,
       SUM(
           CASE
               WHEN ARR_DELAY > 15.0 THEN 1
               ELSE 0
           END
       ) * 100.0 / COUNT(ARR_DELAY) AS percentage_arriving_15_mins_late
FROM Airports
GROUP BY ORIGIN, DEST
HAVING COUNT(*) >= 500
ORDER BY average_arrival_delay DESC
LIMIT 10;
