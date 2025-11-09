-- SQL Project |  Electric Vehicle Adoption & Trends (2010–2024)
-- David Hernandez & Miguel Florindo

-- IronHack | Data updated May 2025
-- November 2025
-- Data source: (Show data source)

---------------------------------------------------------
-- Main questions to get answers for: 

-- 1) EV Adoption per Region - Global View
-- 2) Europe: Top 10 countries acquiring EV's VS Top 10 countries preparing Charging Points
-- 3) Europe: Country with the largest increase in EV's over the years
-- 4) Enviornmental Impact: 
-- 4.1) How many gasoline cars could have been fueled with the petroleum saved due to EV adoption?
-- 4.2) How many households could have been powered with the electricity (GWh) consumed by EVs?
----------------------------------------------------------

-- Selecting every year from the Sales table

USE ev_sales_data_may_2025;

SELECT *
FROM ev_sales_countries;

-- Selecting every sales per macro region

SELECT *
FROM ev_sales_macro_regions;

-- Selecting every column from other data, un-related to sales

SELECT * 
FROM other_ev_data;

-- Starting queries below -- 

-- Preparation of dataset
SELECT *
FROM ev_sales_macro_regions;

-- SQL cannot analyze the year columns with the pivot format from the CSV file, excel format:
-- Current view: 
-- region_country | mode | 2010 | 2011 | 2012 | ... | 2024
-- Europe         | Cars |  40  | 100  | 150  | ... | 50000
-- Asia           | Cars |  80  | 130  | 200  | ... | 70000

-- The script below changes the view from horizontal to vertical, as seen in the example: 
-- region     | year | ev_sales
-- Europe     | 2010 | 40
-- Europe     | 2011 | 100
-- Europe     | 2012 | 150

CREATE OR REPLACE VIEW ev_sales_macro_long AS
SELECT region_country AS region, 2010 AS year, CAST(REPLACE(`2010`, ' ', '') AS UNSIGNED) AS ev_sales FROM ev_sales_macro_regions
UNION ALL SELECT region_country, 2011, CAST(REPLACE(`2011`, ' ', '') AS UNSIGNED) FROM ev_sales_macro_regions
UNION ALL SELECT region_country, 2012, CAST(REPLACE(`2012`, ' ', '') AS UNSIGNED) FROM ev_sales_macro_regions
UNION ALL SELECT region_country, 2013, CAST(REPLACE(`2013`, ' ', '') AS UNSIGNED) FROM ev_sales_macro_regions
UNION ALL SELECT region_country, 2014, CAST(REPLACE(`2014`, ' ', '') AS UNSIGNED) FROM ev_sales_macro_regions
UNION ALL SELECT region_country, 2015, CAST(REPLACE(`2015`, ' ', '') AS UNSIGNED) FROM ev_sales_macro_regions
UNION ALL SELECT region_country, 2016, CAST(REPLACE(`2016`, ' ', '') AS UNSIGNED) FROM ev_sales_macro_regions
UNION ALL SELECT region_country, 2017, CAST(REPLACE(`2017`, ' ', '') AS UNSIGNED) FROM ev_sales_macro_regions
UNION ALL SELECT region_country, 2018, CAST(REPLACE(`2018`, ' ', '') AS UNSIGNED) FROM ev_sales_macro_regions
UNION ALL SELECT region_country, 2019, CAST(REPLACE(`2019`, ' ', '') AS UNSIGNED) FROM ev_sales_macro_regions
UNION ALL SELECT region_country, 2020, CAST(REPLACE(`2020`, ' ', '') AS UNSIGNED) FROM ev_sales_macro_regions
UNION ALL SELECT region_country, 2021, CAST(REPLACE(`2021`, ' ', '') AS UNSIGNED) FROM ev_sales_macro_regions
UNION ALL SELECT region_country, 2022, CAST(REPLACE(`2022`, ' ', '') AS UNSIGNED) FROM ev_sales_macro_regions
UNION ALL SELECT region_country, 2023, CAST(REPLACE(`2023`, ' ', '') AS UNSIGNED) FROM ev_sales_macro_regions
UNION ALL SELECT region_country, 2024, CAST(REPLACE(`2024`, ' ', '') AS UNSIGNED) FROM ev_sales_macro_regions;

-- By doing this we allow SQL to perform operations such as GROUP, SORT, AGGREGATE by visualizing data over time 

CREATE OR REPLACE VIEW ev_sales_macro_long AS
SELECT region_country AS region, 2010 AS year, `2010` AS ev_sales
FROM ev_sales_macro_regions;

-- Previous query and new query, un-comment for comparison on the Result Grid
-- SELECT *
-- FROM ev_sales_macro_regions;

-- Updated query
SELECT *
FROM ev_sales_macro_long
ORDER BY region, year
LIMIT 10;


-- 1) EV Adoption per Region — Global View
-- How have EV sales changed over time in each region, and which region shows the largest overall increase from 2010 to 2024?

-- Growth per region: 
SELECT region, year, ev_sales
FROM ev_sales_macro_long
ORDER BY region, year;

-- Largest overall increase
SELECT region,
       MIN(ev_sales) AS start_sales,
       MAX(ev_sales) AS end_sales,
       (MAX(ev_sales) - MIN(ev_sales)) AS growth
FROM ev_sales_macro_long
GROUP BY region
ORDER BY growth DESC;
-- Note: The code above returned "region_country" from excel column names as value, this was removed from the plot in VS Code

-- Checking region_contry value
SELECT *
FROM ev_sales_macro_regions
WHERE region_country = 'region_country';

-- Notes
-- Results for each query were exported as CSV and imported into VS Code
-- Useful hints used in this query:
SHOW TABLES; -- Mini test to confirm the schema is active
-- Expected result: 
-- 1) ev_sales_countries
-- 2) ev_sales_macro_regions
-- 3) other_ev_data


-- Counting all sales from all regions, all times
CREATE OR REPLACE VIEW ev_sales_macro_long AS
SELECT 
    region_country AS region,
    2010 AS year,
    CAST(REPLACE(REPLACE(`2010`, ' ', ''), ',', '') AS UNSIGNED) AS ev_sales
FROM ev_sales_macro_regions
UNION ALL
SELECT region_country, 2011, CAST(REPLACE(REPLACE(`2011`, ' ', ''), ',', '') AS UNSIGNED) FROM ev_sales_macro_regions
UNION ALL
SELECT region_country, 2012, CAST(REPLACE(REPLACE(`2012`, ' ', ''), ',', '') AS UNSIGNED) FROM ev_sales_macro_regions
UNION ALL
SELECT region_country, 2013, CAST(REPLACE(REPLACE(`2013`, ' ', ''), ',', '') AS UNSIGNED) FROM ev_sales_macro_regions
UNION ALL
SELECT region_country, 2014, CAST(REPLACE(REPLACE(`2014`, ' ', ''), ',', '') AS UNSIGNED) FROM ev_sales_macro_regions
UNION ALL
SELECT region_country, 2015, CAST(REPLACE(REPLACE(`2015`, ' ', ''), ',', '') AS UNSIGNED) FROM ev_sales_macro_regions
UNION ALL
SELECT region_country, 2016, CAST(REPLACE(REPLACE(`2016`, ' ', ''), ',', '') AS UNSIGNED) FROM ev_sales_macro_regions
UNION ALL
SELECT region_country, 2017, CAST(REPLACE(REPLACE(`2017`, ' ', ''), ',', '') AS UNSIGNED) FROM ev_sales_macro_regions
UNION ALL
SELECT region_country, 2018, CAST(REPLACE(REPLACE(`2018`, ' ', ''), ',', '') AS UNSIGNED) FROM ev_sales_macro_regions
UNION ALL
SELECT region_country, 2019, CAST(REPLACE(REPLACE(`2019`, ' ', ''), ',', '') AS UNSIGNED) FROM ev_sales_macro_regions
UNION ALL
SELECT region_country, 2020, CAST(REPLACE(REPLACE(`2020`, ' ', ''), ',', '') AS UNSIGNED) FROM ev_sales_macro_regions
UNION ALL
SELECT region_country, 2021, CAST(REPLACE(REPLACE(`2021`, ' ', ''), ',', '') AS UNSIGNED) FROM ev_sales_macro_regions
UNION ALL
SELECT region_country, 2022, CAST(REPLACE(REPLACE(`2022`, ' ', ''), ',', '') AS UNSIGNED) FROM ev_sales_macro_regions
UNION ALL
SELECT region_country, 2023, CAST(REPLACE(REPLACE(`2023`, ' ', ''), ',', '') AS UNSIGNED) FROM ev_sales_macro_regions
UNION ALL
SELECT region_country, 2024, CAST(REPLACE(REPLACE(`2024`, ' ', ''), ',', '') AS UNSIGNED) FROM ev_sales_macro_regions;

SELECT 
    SUM(ev_sales) AS total_ev_sales_worldwide
FROM ev_sales_macro_long
WHERE year BETWEEN 2010 AND 2024;



-- 2) Europe: Ranking EV Growth vs Charging Infrastructure

SHOW COLUMNS FROM other_ev_data2;
-- Results obtained showed the need to un-pivot the table: 
-- mode	text	YES		
-- region_country	text	YES		
-- 2010	text	YES		
-- We will use the same aproach to un-pivot already executed for ev_sales_macro_long table

CREATE OR REPLACE VIEW ev_sales_countries_long AS
SELECT region_country AS country, 2010 AS year, CAST(REPLACE(`2010`, ' ', '') AS UNSIGNED) AS ev_sales
FROM ev_sales_countries

UNION ALL SELECT region_country, 2011, CAST(REPLACE(`2011`, ' ', '') AS UNSIGNED) FROM ev_sales_countries
UNION ALL SELECT region_country, 2012, CAST(REPLACE(`2012`, ' ', '') AS UNSIGNED) FROM ev_sales_countries
UNION ALL SELECT region_country, 2013, CAST(REPLACE(`2013`, ' ', '') AS UNSIGNED) FROM ev_sales_countries
UNION ALL SELECT region_country, 2014, CAST(REPLACE(`2014`, ' ', '') AS UNSIGNED) FROM ev_sales_countries
UNION ALL SELECT region_country, 2015, CAST(REPLACE(`2015`, ' ', '') AS UNSIGNED) FROM ev_sales_countries
UNION ALL SELECT region_country, 2016, CAST(REPLACE(`2016`, ' ', '') AS UNSIGNED) FROM ev_sales_countries
UNION ALL SELECT region_country, 2017, CAST(REPLACE(`2017`, ' ', '') AS UNSIGNED) FROM ev_sales_countries
UNION ALL SELECT region_country, 2018, CAST(REPLACE(`2018`, ' ', '') AS UNSIGNED) FROM ev_sales_countries
UNION ALL SELECT region_country, 2019, CAST(REPLACE(`2019`, ' ', '') AS UNSIGNED) FROM ev_sales_countries
UNION ALL SELECT region_country, 2020, CAST(REPLACE(`2020`, ' ', '') AS UNSIGNED) FROM ev_sales_countries
UNION ALL SELECT region_country, 2021, CAST(REPLACE(`2021`, ' ', '') AS UNSIGNED) FROM ev_sales_countries
UNION ALL SELECT region_country, 2022, CAST(REPLACE(`2022`, ' ', '') AS UNSIGNED) FROM ev_sales_countries
UNION ALL SELECT region_country, 2023, CAST(REPLACE(`2023`, ' ', '') AS UNSIGNED) FROM ev_sales_countries
UNION ALL SELECT region_country, 2024, CAST(REPLACE(`2024`, ' ', '') AS UNSIGNED) FROM ev_sales_countries;

-- Which European countries lead in EV acquisitions, and how does this compare with the countries leading in the installation of public charging points?

-- 2.1 ) Top Europe EV adoption
-- EV top countries (include year in the export)
SET @y := (SELECT MAX(year) FROM ev_sales_countries_long);

SELECT year AS export_year, country, ev_sales
FROM ev_sales_countries_long
WHERE year = @y
  AND country IN (
    'Austria','Belgium','Bulgaria','Croatia','Cyprus','Czech Republic','Denmark',
    'Estonia','Finland','France','Germany','Greece','Hungary','Iceland','Ireland',
    'Italy','Latvia','Lithuania','Luxembourg','Malta','Netherlands','Norway','Poland',
    'Portugal','Romania','Slovakia','Slovenia','Spain','Sweden','Switzerland','United Kingdom'
  )
ORDER BY ev_sales DESC
LIMIT 10;


-- 2.2) Top Europe CP installation
SET @y := (SELECT MAX(year) FROM charging_points_long);

SELECT year AS export_year, country, charging_points
FROM charging_points_long
WHERE year = @y
  AND country IN (
    'Austria','Belgium','Bulgaria','Croatia','Cyprus','Czech Republic','Denmark',
    'Estonia','Finland','France','Germany','Greece','Hungary','Iceland','Ireland',
    'Italy','Latvia','Lithuania','Luxembourg','Malta','Netherlands','Norway','Poland',
    'Portugal','Romania','Slovakia','Slovenia','Spain','Sweden','Switzerland','United Kingdom'
  )
ORDER BY charging_points DESC
LIMIT 10;


-- 3) Europe: Largest Increase in EVs Over the Years
-- Which European country recorded the highest increase in EV units over the observed period?

-- Get the first and last years dynamically
SET @first_year := (SELECT MIN(year) FROM ev_sales_countries_long);
SET @last_year  := (SELECT MAX(year) FROM ev_sales_countries_long);

-- Growth per country
SELECT 
    country,
    SUM(CASE WHEN year = @first_year THEN ev_sales END) AS start_sales,
    SUM(CASE WHEN year = @last_year  THEN ev_sales END) AS end_sales,
    SUM(CASE WHEN year = @last_year  THEN ev_sales END) -
    SUM(CASE WHEN year = @first_year THEN ev_sales END) AS growth
FROM ev_sales_countries_long
WHERE country IN (
    'Austria','Belgium','Bulgaria','Croatia','Cyprus','Czech Republic','Denmark',
    'Estonia','Finland','France','Germany','Greece','Hungary','Iceland','Ireland',
    'Italy','Latvia','Lithuania','Luxembourg','Malta','Netherlands','Norway','Poland',
    'Portugal','Romania','Slovakia','Slovenia','Spain','Sweden','Switzerland','United Kingdom'
)
GROUP BY country
ORDER BY growth DESC
LIMIT 10;


-- 4) Environmental Impact of EV Adoption
-- Environmental and energy-equivalent impact of switching from combustion vehicles to electric vehicles


-- 4.1) Petroleum Avoidance Impact
-- Given the petroleum savings attributed to EV adoption, how many gasoline cars could have run on the same amount of fuel?

CREATE OR REPLACE VIEW env_oil_lge_long AS
SELECT region_country AS region, 2010 AS year, CAST(REPLACE(`2010`,' ','') AS UNSIGNED) * 1000000 AS liters
FROM petroleum_avoidance
UNION ALL SELECT region_country, 2011, CAST(REPLACE(`2011`,' ','') AS UNSIGNED) * 1000000 FROM petroleum_avoidance
UNION ALL SELECT region_country, 2012, CAST(REPLACE(`2012`,' ','') AS UNSIGNED) * 1000000 FROM petroleum_avoidance
UNION ALL SELECT region_country, 2013, CAST(REPLACE(`2013`,' ','') AS UNSIGNED) * 1000000 FROM petroleum_avoidance
UNION ALL SELECT region_country, 2014, CAST(REPLACE(`2014`,' ','') AS UNSIGNED) * 1000000 FROM petroleum_avoidance
UNION ALL SELECT region_country, 2015, CAST(REPLACE(`2015`,' ','') AS UNSIGNED) * 1000000 FROM petroleum_avoidance
UNION ALL SELECT region_country, 2016, CAST(REPLACE(`2016`,' ','') AS UNSIGNED) * 1000000 FROM petroleum_avoidance
UNION ALL SELECT region_country, 2017, CAST(REPLACE(`2017`,' ','') AS UNSIGNED) * 1000000 FROM petroleum_avoidance
UNION ALL SELECT region_country, 2018, CAST(REPLACE(`2018`,' ','') AS UNSIGNED) * 1000000 FROM petroleum_avoidance
UNION ALL SELECT region_country, 2019, CAST(REPLACE(`2019`,' ','') AS UNSIGNED) * 1000000 FROM petroleum_avoidance
UNION ALL SELECT region_country, 2020, CAST(REPLACE(`2020`,' ','') AS UNSIGNED) * 1000000 FROM petroleum_avoidance
UNION ALL SELECT region_country, 2021, CAST(REPLACE(`2021`,' ','') AS UNSIGNED) * 1000000 FROM petroleum_avoidance
UNION ALL SELECT region_country, 2022, CAST(REPLACE(`2022`,' ','') AS UNSIGNED) * 1000000 FROM petroleum_avoidance
UNION ALL SELECT region_country, 2023, CAST(REPLACE(`2023`,' ','') AS UNSIGNED) * 1000000 FROM petroleum_avoidance
UNION ALL SELECT region_country, 2024, CAST(REPLACE(`2024`,' ','') AS UNSIGNED) * 1000000 FROM petroleum_avoidance;


SET @liters_per_car := 1050;

-- Liters per-year for Europe
SELECT
  year,
  liters AS oil_saved_liters,
  ROUND(liters / @liters_per_car) AS cars_fueled_equivalent
FROM env_oil_lge_long
WHERE region = 'Europe'
ORDER BY year;

-- Total (2010–2024) for Europe
SELECT
  SUM(liters) AS total_liters_saved,
  ROUND(SUM(liters) / @liters_per_car) AS total_cars_fueled_equivalent
FROM env_oil_lge_long
WHERE region = 'Europe';

-- Calculating forecast
SELECT
    region_country AS region,
    CAST(REPLACE(REPLACE(`2024`, ' ', ''), ',', '') AS UNSIGNED) AS petroleum_2024_liters,
    CAST(REPLACE(REPLACE(`2030`, ' ', ''), ',', '') AS UNSIGNED) AS petroleum_2030_liters
FROM petroleum_avoidance
WHERE region_country = 'Europe';

-- 4.2) Electricity Demand Impact
-- Based on the electricity consumption (GWh) required for EV charging, how many average European households could be powered by this amount of energy?

SELECT 
  year,
  gwh AS electricity_demand_gwh,
  ROUND(gwh / 0.0035) AS homes_powered_equivalent
FROM (
  SELECT region, 2024 AS year, gwh_2024 AS gwh
  FROM (
    SELECT 
      `region_country` AS region,
      CAST(REPLACE(REPLACE(`2024`, ' ', ''), ',', '') AS UNSIGNED) AS gwh_2024,
      CAST(REPLACE(REPLACE(`2030`, ' ', ''), ',', '') AS UNSIGNED) AS gwh_2030
    FROM ev_sales_data_may_2025.electricity_demand
  ) t
  UNION ALL
  SELECT region, 2030, gwh_2030
  FROM (
    SELECT 
      `region_country` AS region,
      CAST(REPLACE(REPLACE(`2024`, ' ', ''), ',', '') AS UNSIGNED) AS gwh_2024,
      CAST(REPLACE(REPLACE(`2030`, ' ', ''), ',', '') AS UNSIGNED) AS gwh_2030
    FROM ev_sales_data_may_2025.electricity_demand
  ) t
) long_elec
WHERE region = 'Europe'
ORDER BY year;