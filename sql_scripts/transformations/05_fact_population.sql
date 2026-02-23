-- Creates fact_population at grain
-- one row per (age_group, ethnicity_label, year_of_arrival)
-- USes surrogage key from dimension tables


CREATE OR REPLACE TABLE `windrush-capstone.windrush_project.fact_population` AS
SELECT
  GENERATE_UUID() AS population_id,
  a.age_id,
  e.ethnicity_id,
  c.arrival_id,
  s.population_count
FROM `windrush-capstone.windrush_project.staging_demo` AS s
JOIN `windrush-capstone.windrush_project.dim_age` AS a
  ON s.age_group = a.age_group
JOIN `windrush-capstone.windrush_project.dim_ethnicity` AS e
  ON s.ethnicity_label = e.ethnicity_label
JOIN `windrush-capstone.windrush_project.dim_arrival_cohort` AS c
  ON s.year_of_arrival = c.year_of_arrival;