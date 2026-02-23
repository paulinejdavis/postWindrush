-- Creates dim_arrival_cohort from staging_Demo
-- One row per distinct year_of_arrival band with a surrogage key

CREATE OR REPLACE TABLE `windrush-capstone.windrush_project.dim_arrival_cohort`
AS
WITH unique_arrival AS (
  SELECT DISTINCT year_of_arrival
FROM `windrush-capstone.windrush_project.staging_demo`
)

SELECT
GENERATE_UUID() AS arrival_id, year_of_arrival
FROM unique_arrival;