
# MEA Actual vs Target Data Quality Pipeline

## Project Overview

This project implements an Actual vs Target Data Quality Pipeline for MEA business-unit performance reporting using dbt Core and ClickHouse.

The objective is to organise, transform and validate business performance data so that actual results can be compared against their corresponding target values.

The pipeline uses dbt models to transform source data into structured reporting tables, making it easier to monitor performance across business units, reporting months and performance metrics.

## Project Objectives

- Load and organise business performance data.
- Transform source data using dbt SQL models.
- Structure actual and target results for comparison.
- Apply data quality tests to validate the transformed data.
- Produce comparison results that support performance monitoring and reporting.

## Technology Stack

- **dbt Core:** Data transformation and testing.
- **ClickHouse:** Analytical database for storing and querying data.
- **SQL:** Data extraction, transformation and comparison.
- **Git and GitHub:** Version control and project documentation.

## Project Structure

```text
springer_mea_quality/
│
├── analyses/
├── macros/
├── models/
│   ├── staging/
│   └── other transformation models/
├── seeds/
├── snapshots/
├── tests/
├── dbt_project.yml
└── README.md
```

## Data Transformation

The pipeline uses SQL models to extract and transform source data into structured formats.

The staging transformation includes fields such as:

- Business unit
- Reporting month
- Performance metric
- Actual result

These are standardised into reporting fields for downstream analysis and comparison.

## Data Quality and Testing

dbt tests are used to validate the transformed data and help identify potential data quality issues.

The project includes:
- Configured data sources.
- SQL transformation models.
- Data quality tests.
- Actual versus Target comparison results.

## Execution

The project was developed and tested using dbt Core connected to ClickHouse.

Typical dbt commands used include:

```bash
dbt debug
dbt run
dbt test
dbt build
```

## Project Outcome

The completed pipeline provides structured Actual vs Target comparison outputs and data quality validation through dbt.

It demonstrates the application of SQL transformations, analytical database integration, data validation and version control in a data engineering workflow.

## Tools and Skills Demonstrated

- Data engineering fundamentals
- SQL transformation
- dbt modelling
- ClickHouse integration
- Data quality testing
- GitHub version control
- Analytical reporting
