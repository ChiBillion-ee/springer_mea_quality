# MEA Actual vs Target Data Quality Pipeline

## 1. Project Overview

This project implements an Actual vs Target Data Quality Pipeline for MEA business-unit performance reporting using dbt Core and ClickHouse.

The objective is to organise, transform and validate business performance data so that actual results can be compared against their corresponding target values.

The pipeline standardises actual data from multiple business-unit sources and evaluates performance against MEA agreement targets, supporting consistent monitoring and reporting.

The project uses synthetic sample data for demonstration purposes.

## 2. Project Scope

The implementation covers:

- Source data configuration.
- Staging and standardisation of actual data.
- Multiple business-unit actual data sources.
- Actual vs Target comparison.
- Variance calculation.
- Direction-aware performance classification.
- Agreement maturity evaluation.
- Data quality testing and validation.
- Storage and access to comparison results through ClickHouse.

## 3. Project Objectives

- Load and organise business performance data.
- Transform source data using dbt SQL models.
- Standardise actual data from different business units.
- Compare actual results against agreed targets.
- Calculate performance variances.
- Evaluate agreements based on their month-end maturity.
- Apply direction-aware performance rules.
- Produce structured comparison results for reporting.

## 4. Technology Stack

- **dbt Core:** Data transformation and testing.
- **ClickHouse:** Analytical database for storing and querying data.
- **SQL:** Data extraction, transformation and comparison.
- **Git:** Version control.
- **GitHub:** Project repository and documentation.
- **Elementary:** Data observability and test-result monitoring.

## 5. Project Structure

```text
springer_mea_quality/
│
├── analyses/
├── macros/
├── models/
│   ├── staging/
│   │   ├── stg_unit_a__actuals.sql
│   │   └── stg_unit_b__actuals.sql
│   └── marts/
│       └── mea/
│           └── fct_mea_actual_vs_target.sql
├── seeds/
├── snapshots/
├── tests/
├── dbt_project.yml
├── packages.yml
└── README.md
```

## 6. Data Transformation

The pipeline standardises actual data from multiple business-unit sources into a common structure.

The standardised fields include:

- Business unit (`unit`)
- Reporting month (`reporting_month`)
- Performance metric (`data_item`)
- Actual result (`actual_value`)

This common structure allows the comparison model to work with different actual data sources without changing the core comparison logic.

## 7. Data Model Architecture

### Model 1: Unit A Staging Model

**Model:** `stg_unit_a__actuals.sql`

Transforms Unit A actual data into a standardised structure.

### Model 2: Unit B Staging Model

**Model:** `stg_unit_b__actuals.sql`

Transforms Unit B actual data into the same standardised structure as Unit A.

### Model 3: Actual vs Target Comparison Model

**Model:** `fct_mea_actual_vs_target.sql`

Combines the MEA agreement targets with standardised actual data from the configured business-unit source.

The model produces:

- Actual value
- Target value
- Variance
- Target direction
- Agreement maturity information
- Selected actual data source
- Performance status

## 8. Business Rules

### Variance Calculation

```text
Variance = Actual Value - Target Value
```

### Direction-Aware Performance Evaluation

Performance status depends on the target direction.

**Higher is better:**

- HIT: Actual value is greater than or equal to the target.
- MISS: Actual value is below the target.

**Lower is better:**

- HIT: Actual value is less than or equal to the target.
- MISS: Actual value is above the target.

### Agreement Maturity Evaluation

Agreement maturity is evaluated using its month-end maturity status.

- Agreements that reach `Live` by month-end are eligible for performance evaluation.
- Agreements that have not reached `Live` by month-end are classified as `not_mature`.

This ensures that agreements still in progress are not incorrectly treated as missed performance targets.

### Actual Data Availability

The pipeline distinguishes between missing actual data and unsuccessful performance.

- `no_actual`: The agreement is eligible for evaluation, but no matching actual record is available.
- `not_mature`: The agreement has not reached Live status by month-end.
- `hit`: The actual result meets the target based on its direction.
- `miss`: The actual result does not meet the target based on its direction.

A missing actual is not automatically classified as a performance miss.

### Configurable Actual Data Source

The comparison model combines standardised actual data from Unit A and Unit B.

The agreement's configured data source determines which actual dataset is used for its evaluation.

This approach makes it possible to support additional business-unit actual data sources by introducing corresponding staging models with the same standardised fields.

## 9. Data Quality and Testing

dbt tests are used to validate transformed data and identify potential data quality issues.

The project includes:

- Configured data sources.
- SQL transformation models.
- Data quality tests.
- Not-null validation on key fields.
- Performance status validation.
- Actual vs Target comparison results.
- Elementary data observability integration.

These checks help improve data reliability and consistency throughout the transformation workflow.

## 10. Execution

The project was developed and tested using dbt Core connected to ClickHouse.

The following commands were used during development and validation.

### Check Database Connection

```bash
python -m dbt.cli.main debug
```

### Execute Transformation Models

```bash
python -m dbt.cli.main run
```

### Run Data Quality Tests

```bash
python -m dbt.cli.main test
```

### Build Models and Execute Associated Tests

```bash
python -m dbt.cli.main build
```

## 11. Project Outcome

The pipeline provides a structured Actual vs Target comparison workflow that:

- Standardises actual data from multiple business units.
- Compares actual results against agreed targets.
- Calculates performance variances.
- Applies direction-aware performance rules.
- Evaluates agreements based on month-end maturity.
- Distinguishes missing actual data from performance misses.
- Stores transformed results in ClickHouse for querying and reporting.

The project demonstrates the application of SQL transformations, dbt modelling, data quality validation, analytical database integration and data observability.

## 12. Tools and Skills Demonstrated

- Data engineering fundamentals.
- SQL transformation and querying.
- dbt modelling and testing.
- ClickHouse integration.
- Data quality validation.
- Actual vs Target performance analysis.
- Data source standardisation.
- Git and GitHub version control.
- Data observability using Elementary.

## 13. Dataset Information

This project uses synthetic sample data created for learning and demonstration purposes because an actual business dataset was not provided.

No confidential Springer Capital business data or actual company dataset was used.

The sample records demonstrate how dbt Core and ClickHouse can be used to transform, validate and compare Actual vs Target performance data.
