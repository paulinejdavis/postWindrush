-- Builds cleaned staging_demo from raw ONS census table
-- Standardises columns names and keep only rows with valid observations

CREATE OR REPLACE TABLE `windrush-capstone.windrush_project.staging_demo` AS
SELECT
  `Age _6 categories_` AS age_group,
  `Ethnic group _20 categories_` AS ethnicity_label,
  `Year of arrival in the UK _11 categories_` AS year_of_arrival,
  CAST(Observation AS INT64) AS population_count
FROM `windrush-capstone.windrush_project.raw_age_ethnicity_arrival`
WHERE CAST(Observation AS INT64) > 0;