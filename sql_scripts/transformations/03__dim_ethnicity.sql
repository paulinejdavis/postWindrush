-- Creates dim_ethnicity from staging_demo
-- Generates surrogate key for each ethnicity

CREATE OR REPLACE TABLE `windrush-capstone.windrush_project.dim_ethnicity`
AS
WITH unique_ethnicity AS (
  SELECT DISTINCT ethnicity_label
FROM `windrush-capstone.windrush_project.staging_demo`
)

SELECT
GENERATE_UUID() AS ethnicity_id, ethnicity_label
FROM unique_ethnicity;