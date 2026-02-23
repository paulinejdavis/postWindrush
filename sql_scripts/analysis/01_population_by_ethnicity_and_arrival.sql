-- Total population by ethnictiy and arrival cohort

SELECT
  e.ethnicity_label,
  c.year_of_arrival,
  SUM(f.population_count) AS total_population
FROM `windrush-capstone.windrush_project.fact_population` f
JOIN `windrush-capstone.windrush_project.dim_ethnicity` e
  ON f.ethnicity_id = e.ethnicity_id
JOIN `windrush-capstone.windrush_project.dim_arrival_cohort` c
  ON f.arrival_id = c.arrival_id
GROUP BY 1,2
ORDER BY total_population DESC
LIMIT 20;