# postWindrush

## Project Summary

This project analyses Windrush-era population data using ONS Census data (2011 snapshot), landing sample data, and Windrush Compensation Scheme statistics.

The aim is to explore cohort size, demographic characteristics and compensation trends usind a dimensional model in BigQuesty and support dashboard visualisation.

## Key Findings

## Key Findings

### 1. Pre-1971 Arrivals Represent a Significant Share of the Population

Individuals who arrived before 1971 account for approximately **848,609 people**, representing a substantial proportion of the dataset.

- SQL file: `sql_scripts/analysis/06_cohort_size_and_percentage_of_total.sql`

---

### 2. Compensation Payments vs Approved Claims

As of the latest data, **9,184 claims were approved**, but only **3,604 resulted in payment** (~39% of approved claims).

- SQL file: `sql_scripts/compensation/04_total_approved_total_paid_percentage_paid.sql`

---

### 3. Monthly Compensation Trends

Monthly payments increased over time, rising from ~20–30 per month in 2021 to peaks above 80–100 per month in 2024–2025.

- SQL file: `sql_scripts/compensation/06_monthly_paid_increment.sql`

---

### 4. Approved Claims Relative to Estimated Population

Approved claims represent just over **1%** of the estimated Windrush-era population in this dataset.

- SQL file: `sql_scripts/analysis/07_arrival_period_size_and_percentage_of_total.sql`

## Data Limitations

- ONS data represents a 2011 census snapshot(England & Wales only)

- Compensation data is aggregated monthly and does not contain claimant-level detail

- Landing dataset represents a small sample and is not representative of total migration flows.

- No direct join exists between population and compensation datasets

## Technical Approach

- Star schema: fact_population + dimension tables (arrival cohort, ethnicity, age, etc)
- Window functions used for monthly compensation calculations
- Percentage calculations using analytic functions
- Data cleaned and normalised before ingestion into BigQuery

## Data Model

A star schema was implemented to support cohort-based demographic analysis
![Windrush Star Schema] (data_modelling/windrush_star_schema.png) The core warehouse model is a star schema built in Google BigQuery.

## Data Sources

### 1. ONS Census 2021 (Custom Dataset Builder)

Population data was sourced from the Office for National Statistics (ONS) Census 2021 custom dataset builder.
Variables selected included:

- Age group
- Ethnic Group
- Economic activity status
- Year of arrival

Data was exported as CSV files and ingested into Google BigQuery for transformation and modelling.

### 2. Goldsmith Windrush Landing Cards (Digitised Records)

Landing records were sourced from the Goldsmiths University digitised archive of Windrush-era arrial data. This dataset was used to visualise arrival trends and support cohort classification.

### 3. Windrush Compensation Data

Public compensation statistics were used to provide contextual insight into policy impact and timeline relevance.

### Data Ingestion

All datasets were:

- Downloaded locally as CSV files
- Uploaded into BigQuery (UK region)
- Cleaned and standarised prior to modelling

The BigQuery dataset location was set to the UK/EU region to align with data residency best practices.
This structure separates descriptive attributes (dimensions) from quantitative measures (fact table) to support scalable aggregation and analysis.

### Fact Table: `fact_population`

**Grain:**
One row per combination of:

- age_group
- ethnicity_label
- arrival_cohort

**Measure:**

- `population_count`

**Foreign Keys:**

- `age_id`
- `ethnicity_id`
- `arrival_id`

### Dimensions

- `dim_age` – unique age groups
- `dim_ethnicity` – unique ethnicity categories
- `dim_arrival_cohort` – ONS year-of-arrival bands

### Data Cleaning & Transformation

During ingestion and modellingm, the following steps were applied:

- Renamed columns for clarity and consistency
- Filtered out zero-value observations
- Cast numeric columns to appropriate data types
- Generate surrogate keys using GENERATE_UUID()
- Separated staging tables from dimensional modelling layer
- Ensured consistent grain in fact table

### Analytical Queries

## Overview

This project includes analytical queries built on the dimensional model to explore demographic patterns within arrival cohorts.

## Techniques used

**Aggregations**
Used SUM(population_count) with GROUP BY to calculate total population by cohort, ethnicity and age group.

**Dimensional Joins**
Joined fact_population to dim_cohort, dim_ethnicity and dim_age to enable multi-dimensional analysis.

**Window Functions**
Applied RANK() OVER (PARTITION BY cohort ORDER BY total_population DESC)to rank ethnic groups within arrival cohorts.

**Top-N Analysis**
Ordered and filtered results to highlight dominant ethnic groups per cohort.

All analytical queries are located in `sql_scripts/analysis` folder and run against the dimensional model.

## How to run this project

## 1. Data Sources

Download the following datasets (/data_sources):

- ONS Census 20211 (custom dataset created via ONS dataset builder)
  https://www.ons.gov.uk/filters/b39c683e-d158-4d09-bc54-14bf40bd0316/dimensions \***_check correct link_**

- Windrush Compensation Scheme monthly statistics
  https://www.gov.uk/government/statistics/windrush-compensation-scheme-data-september-2025

- National Archives
  https://www.nationalarchives.gov.uk/education/resources/commonwealth-migration-since-1945/passenger-list-from-windrush/

## 2. Run SQL Scripts in order

Execute scripts in the following order:

1. sql_scripts/transformations/

- Create staging tables
- Create dimension tables
- Create fact table

2. sql_scripts/analysis/

- Cohort distribution
- Age breakdown
- Compensation summary
- Window function (monthly payments)

4. Dashboard (pdate)

- Connect Power BI to BigQuery dataset
- Use fact table and staging tables??
- Apply slicers and cross-filtering

### Important to note

- ONS dataset limited to England & Wales (2011 snapshot)
- Compensation data is aggregated monthly(no claimant level detail)
- No direct join exists between population and compensation datasets
