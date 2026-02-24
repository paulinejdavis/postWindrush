-- Sanity check: validate row count + date range
SELECT
  COUNT(*) AS row_count,
  MIN(month) AS first_month,
  MAX(month) AS last_month
FROM `windrush-capstone.windrush_project.staging_compensation`;


-- Aggregate Totals: Approved  vs paid + percentage paid 
SELECT
  SUM(total_final_decisions) AS total_approved,
  MAX(cumulative_paid) AS total_paid,
  ROUND(MAX(cumulative_paid) / SUM(total_final_decisions) * 100, 2)
    AS pct_paid_of_approved
FROM `windrush-capstone.windrush_project.staging_compensation`;


--  Window function: calculate monthly paid from cumulative total
SELECT
  month,
  total_final_decisions,
  cumulative_paid,
  cumulative_paid
    - LAG(cumulative_paid) OVER (ORDER BY month) AS monthly_paid
FROM `windrush-capstone.windrush_project.staging_compensation`
ORDER BY month;