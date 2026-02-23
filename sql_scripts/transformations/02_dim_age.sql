-- Creates dim_age from staging_demo
-- One row per distinct age_group with a surrogage key


CREATE OR REPLACE TABLE `windrush-capstone.windrush_project.dim_age`
AS
WITH unique_age AS (
  SELECT DISTINCT age_group
FROM `windrush-capstone.windrush_project.staging_demo`
)

SELECT
GENERATE_UUID() AS age_id, age_group
FROM unique_age;