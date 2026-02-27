-- Analysis Type: Trend Analysis
-- Research Question:
-- How have total final compensation decisions changed year by year?
-- Aggregates monthly data into yearly totals using EXTRACT(YEAR FROM month)
-- Dataset: GOV>UK Windrush Compensation Data (2021-2025)

SELECT
  EXTRACT(YEAR FROM month) AS year,
  SUM(total_final_decisions) AS yearly_decisions
FROM `windrush-capstone.windrush_project.staging_compensation`
GROUP BY year
ORDER BY year;