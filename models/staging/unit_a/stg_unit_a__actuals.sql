SELECT
    business_unit AS unit,
    month_start AS reporting_month,
    metric AS data_item,
    actual_result AS actual_value
FROM {{ source('unit_a', 'actuals_raw') }}
