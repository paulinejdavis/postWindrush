-- Sanity check: total population in fact table

SELECT SUM(population_count) AS total_population
FROM `windrush-capstone.windrush_project.fact_population`;