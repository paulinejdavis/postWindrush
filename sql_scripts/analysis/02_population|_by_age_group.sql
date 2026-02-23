-- Population distribution by age group

SELECT
  a.age_group,
  SUM(f.population_count) AS total_population
FROM `windrush-capstone.windrush_project.fact_population` f
JOIN `windrush-capstone.windrush_project.dim_age` a
  ON f.age_id = a.age_id
GROUP BY 1
ORDER BY total_population DESC;