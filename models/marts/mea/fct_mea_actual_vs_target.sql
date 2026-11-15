SELECT
    t.unit,
    t.reporting_month,
    t.data_item,

    t.monthly_target AS target,
    a.actual_value AS actual,

    a.actual_value - t.monthly_target AS variance,

    CASE
        WHEN a.actual_value IS NULL
            THEN 'no_actual'
        WHEN a.actual_value >= t.monthly_target
            THEN 'hit'
        ELSE 'miss'
    END AS status

FROM {{ source('mea', 'agreements') }} AS t

LEFT JOIN {{ ref('stg_unit_a__actuals') }} AS a
    ON t.unit = a.unit
    AND t.reporting_month = a.reporting_month
    AND t.data_item = a.data_item