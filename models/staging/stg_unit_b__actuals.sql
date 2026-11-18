SELECT
    business_unit AS unit,
    month_start AS reporting_month,
    metric AS data_item,
    actual_result AS actual_value
FROM {{ ref('unit_b_actuals') }}