-- Purpose: Rank ethnic groups within each arrival cohort
-- Demonstrates use of window function (RANK with PARTITION BY)
-- Supports analysis of Windrush-era cohort composition

SELECT
  c.year_of_arrival,
  e.ethnicity_label,
  SUM(f.population_count) AS total_population,

  RANK() OVER (
    PARTITION BY c.year_of_arrival
    ORDER BY SUM(f.population_count) DESC
  ) AS ethnicity_rank_within_cohort

FROM `windrush-capstone.windrush_project.fact_population` f

JOIN `windrush-capstone.windrush_project.dim_ethnicity` e
  ON f.ethnicity_id = e.ethnicity_id

JOIN `windrush-capstone.windrush_project.dim_arrival_cohort` c
  ON f.arrival_id = c.arrival_id

GROUP BY
  c.year_of_arrival,
  e.ethnicity_label

ORDER BY
  c.year_of_arrival,
  ethnicity_rank_within_cohort;