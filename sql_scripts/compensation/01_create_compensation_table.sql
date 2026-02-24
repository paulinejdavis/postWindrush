--Create staging table for windrush compensationdata
--Source: comensation_monthly (Clean CSV upload)
-- Used for downstream compensation analysis queries

CREATE OR REPLACE TABLE `windrush-capstone.windrush_project.staging_compensation` AS
SELECT *
FROM `windrush-capstone.windrush_project.compensation_monthly`;
