# NYC Citi Bike Trip Analysis

## Project Overview
This project analyzes historical trip data from NYC's Citi Bike program to understand rider behavior. The goal is to identify patterns in trip duration, station popularity, and user types. The final output is an interactive dashboard built with Google's Looker Studio.

## Tools Used
- **Google BigQuery:** For data querying and analysis.
- **Looker Studio:** For creating the data dashboard.
- **SQL:** The language used for data manipulation and analysis.

## Data Source
The data is from the `bigquery-public-data.new_york_citibike.citibike_trips` public dataset available in Google BigQuery.

## Dashboard
An interactive dashboard was created using Looker Studio to visualize the key findings from the analysis. The dashboard provides insights into rider behavior, station popularity, and usage patterns by user type.

**[View the Live Dashboard Here](PASTE YOUR LOOKER STUDIO LINK HERE)**



## SQL Queries
The queries used for data exploration and for creating the final view for the dashboard can be found in the `sql_queries` folder. The main script is:

* **[`analysis_queries.sql`](sql_queries/analysis_queries.sql)**: This file contains all the SQL code for checking average trip duration, finding the most popular stations, comparing user types, and creating the final `VIEW` used by Looker Studio.
