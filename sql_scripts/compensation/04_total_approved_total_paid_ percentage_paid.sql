-- Analysis Tupe: Summary Metric
-- Research Question:
-- What is the total number of approved decisions,
-- total amount paid, and percentage of approved cases paid?
-- Dataset: GOB.UK Windrush Compensation Data (2021 - 2025)

SELECT
  SUM(total_final_decisions) AS total_approved,
  MAX(cumulative_paid) AS total_paid,
  ROUND(
    100 * MAX(cumulative_paid) / SUM(total_final_decisions),
    2
  ) AS pct_paid_of_approved
FROM `windrush-capstone.windrush_project.staging_compensation`;