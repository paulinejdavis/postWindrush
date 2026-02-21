# postWindrush

## Data Model

A star schema was implemented to support cohort-based demographic analysis
![Windrush Star Schema] (data_modelling/windrush_star_schema.png)

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

The BigQuery dataset location was set to the UK/EU region to align with data residency best practices
