
-- ##############################################################
-- ##### NYC CITI BIKE TRIP ANALYSIS - SQL QUERIES            #####
-- ##############################################################

-- This file contains the SQL queries used for the analysis of the NYC Citi Bike dataset.
-- The final visualization was created using the view defined at the end of this script.


-- ********************************************************************
-- Query 1: Calculate the overall average trip duration in minutes.
-- This provides a baseline understanding of how long a typical ride is.
-- ********************************************************************

SELECT
  ROUND(AVG(TIMESTAMP_DIFF(stoptime, starttime, MINUTE)), 2) AS average_duration_minutes
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`;


-- ********************************************************************
-- Query 2: Identify the top 10 most popular starting stations.
-- This helps the marketing team understand high-traffic areas.
-- ********************************************************************

SELECT
  start_station_name,
  COUNT(*) AS num_trips -- Count every trip that starts at a station
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
  start_station_name IS NOT NULL
GROUP BY
  start_station_name
ORDER BY
  num_trips DESC -- Order from most trips to least
LIMIT 10;


-- ********************************************************************
-- Query 3: Analyze trip duration and total trips by user type.
-- This compares the behavior of Subscribers (members) vs. Customers (casual riders).
-- ********************************************************************

SELECT
  usertype,
  COUNT(*) AS total_trips,
  ROUND(AVG(TIMESTAMP_DIFF(stoptime, starttime, MINUTE)), 2) AS avg_duration_minutes
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
  usertype IS NOT NULL
GROUP BY
  usertype;


-- ********************************************************************
-- Query 4: Create a clean view for the Looker Studio Dashboard.
-- This view pre-processes the data by calculating trip duration, extracting
-- date parts, and filtering out outlier/bad data for cleaner visualizations.
-- NOTE: You must replace `your-project-id.your_dataset_name` with your actual
-- BigQuery project ID and dataset name before running this.
-- ********************************************************************

CREATE OR REPLACE VIEW `your-project-id.your_dataset_name.citibike_dashboard_view` AS (
  SELECT
    start_station_name,
    end_station_name,
    TIMESTAMP_DIFF(stoptime, starttime, MINUTE) AS duration_minutes,
    EXTRACT(DAYOFWEEK FROM starttime) AS day_of_week, -- 1=Sun, 2=Mon, etc.
    EXTRACT(HOUR FROM starttime) AS hour_of_day,
    usertype
  FROM
    `bigquery-public-data.new_york_citibike.citibike_trips`
  WHERE
    start_station_name IS NOT NULL
    AND end_station_name IS NOT NULL
    AND usertype IS NOT NULL
    AND TIMESTAMP_DIFF(stoptime, starttime, MINUTE) BETWEEN 1 AND 120 -- Filter out trips shorter than 1 min or longer than 2 hours
);
