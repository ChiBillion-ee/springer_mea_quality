
# MEA Actual vs Target Data Quality Pipeline

## 1. Project Overview

This project implements an Actual vs Target Data Quality Pipeline for MEA business-unit performance reporting using dbt Core and ClickHouse.

The objective is to organise, transform and validate business performance data so that actual results can be compared against their corresponding target values.

The pipeline uses dbt SQL models to transform source data into structured reporting tables, making it easier to monitor performance across business units, reporting months and performance metrics.

## 2. Project Scope

The project focuses on developing a data transformation and quality validation workflow for comparing actual performance values against target values.

The implementation covers:

- Source data configuration.
- Data staging and transformation.
- Actual vs Target comparison.
- Variance calculation.
- Performance status classification.
- Data quality testing and validation.
- Storage and access to comparison results through ClickHouse.

The project was developed using synthetic sample data for demonstration purposes.

## 3. Project Objectives

- Load and organise business performance data.
- Transform source data using dbt SQL models.
- Structure actual and target results for comparison.
- Calculate performance variances.
- Apply data quality tests to validate transformed data.
- Produce comparison results that support performance monitoring and reporting.

## 4. Technology Stack

- **dbt Core:** Data transformation and testing.
- **ClickHouse:** Analytical database for storing and querying data.
- **SQL:** Data extraction, transformation and comparison.
- **Git:** Version control.
- **GitHub:** Project repository and documentation.

## 5. Project Structure

```text
springer_mea_quality/
│
├── analyses/
├── macros/
├── models/
│   ├── staging/
│   └── intermediate/ (if applicable)
├── seeds/
├── snapshots/
├── tests/
├── dbt_project.yml
└── README.md
```

## 6. Data Transformation

The pipeline uses SQL models to extract, standardise and transform source data into structured formats for downstream analysis.

The staging transformation standardises fields including:

- Business unit
- Reporting month
- Performance metric
- Actual result

These fields provide a consistent structure for subsequent comparison and reporting.

## 7. Data Model Architecture

The project uses a two-model dbt transformation architecture.

### Model 1: Staging Model

**Model:** `stg_unit_a__actuals.sql`

This model transforms the raw actuals source data into a standardised structure.

The transformation includes:

- Business unit
- Reporting month
- Data item
- Actual value

### Model 2: Actual vs Target Comparison Model

**Model:** `fct_mea_actual_vs_target.sql`

This model combines the staged actuals data with the target agreement data to produce an Actual vs Target comparison.

The model calculates:

- Actual value
- Target value
- Variance
- Performance status

### Business Rules

Variance is calculated as:

`Variance = Actual Value - Target Value`

Performance status is classified using the following rules:

- **HIT:** Actual value is greater than or equal to the target.
- **MISS:** Actual value is below the target.
- **MISS:** Actual value is missing.

The resulting comparison table provides a structured view of performance against agreed targets.

## 8. Data Quality and Testing

dbt tests are used to validate transformed data and identify potential data quality issues.

The project includes:

- Configured data sources.
- SQL transformation models.
- Data quality tests.
- Not-null validation on key fields.
- Performance status validation.
- Actual vs Target comparison results.

These tests help improve data reliability and consistency throughout the transformation workflow.

## 9. Execution

The project was developed and tested using dbt Core connected to ClickHouse.

The following commands were used during development and validation:

### Check database connection

```bash
dbt debug
```

### Execute transformation models

```bash
dbt run
```

### Run data quality tests

```bash
dbt test
```

### Build models and execute associated tests

```bash
dbt build
```

## 10. Project Outcome

The completed pipeline produces structured Actual vs Target comparison outputs, calculates performance variances and assigns performance statuses.
The resulting data is available in ClickHouse for querying and analysis.
The project demonstrates the application of SQL transformations, dbt modelling, analytical database integration, data quality validation and version control in a data engineering workflow.

## 11. Tools and Skills Demonstrated

- Data engineering fundamentals.
- SQL transformation and querying.
- dbt modelling and testing.
- ClickHouse integration.
- Data quality validation.
- Actual vs Target performance analysis.
- Git and GitHub version control.
- Analytical reporting.

## 12. Dataset Information

This project uses synthetic sample data created for learning and demonstration purposes because an actual business dataset was not provided.
No confidential Springer Capital business data or actual company dataset was used.
The pipeline demonstrates how dbt Core and ClickHouse can be used to transform, validate and compare Actual vs Target performance data using sample records.
