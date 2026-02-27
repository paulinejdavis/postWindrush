-- Analysis Type: Month-on-month change
-- Research Question:
-- What is the actual monthly compensation paid,
-- derived from cumulative totals?
-- Method:
-- USes LAG() window function to calculate monthly increment
-- from cumulative_paid values
-- Dataset: GOV-UK Windrush Compensation Data (2021-2025)

SELECT
  month,
  total_final_decisions,
  cumulative_paid,
  cumulative_paid
    - LAG(cumulative_paid) OVER (ORDER BY month) AS monthly_paid
FROM `windrush-capstone.windrush_project.staging_compensation`
ORDER BY month;