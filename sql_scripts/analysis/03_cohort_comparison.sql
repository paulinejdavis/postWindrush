-- Compare pre-1971 arrivals vs later cohorts

SELECT
  c.year_of_arrival,
  SUM(f.population_count) AS total_population
FROM `windrush-capstone.windrush_project.fact_population` f
JOIN `windrush-capstone.windrush_project.dim_arrival_cohort` c
  ON f.arrival_id = c.arrival_id
GROUP BY 1
ORDER BY 2 DESC;