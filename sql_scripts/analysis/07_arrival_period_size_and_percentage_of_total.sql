-- Analysis Type: Exploratory
-- Research Question:
-- What is the size of each arrival period and what percentage
--of the total population does each represent
--Dataset: ONS Census 2021 (Aggregated)
SELECT
  c.year_of_arrival,
  SUM(f.population_count) AS total_population,
  ROUND(
    100 * SUM(f.population_count)
      / SUM(SUM(f.population_count)) OVER (),
    2
  ) AS pct_of_total
FROM `windrush-capstone.windrush_project.fact_population` f
JOIN `windrush-capstone.windrush_project.dim_arrival_cohort` c
  ON f.arrival_id = c.arrival_id
GROUP BY c.year_of_arrival
ORDER BY total_population DESC;