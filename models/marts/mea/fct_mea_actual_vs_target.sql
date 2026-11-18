WITH all_actuals AS (

    -- Unit A actuals
    SELECT
        unit,
        reporting_month,
        data_item,
        actual_value,
        'unit_a' AS actual_source
    FROM {{ ref('stg_unit_a__actuals') }}

    UNION ALL

    -- Unit B actuals
    SELECT
        unit,
        reporting_month,
        data_item,
        actual_value,
        'unit_b' AS actual_source
    FROM {{ ref('stg_unit_b__actuals') }}

),

agreement_evaluation AS (

    SELECT
        t.unit,
        t.reporting_month,
        t.data_item,

        t.monthly_target AS target,
        a.actual_value AS actual,

        t.target_direction,
        t.maturity_at_start,
        t.maturity_at_month_end,
        t.data_source,

        a.actual_source,

        a.actual_value - t.monthly_target AS variance,

        CASE
            WHEN lowerUTF8(t.maturity_at_month_end) != 'live'
                THEN 'not_mature'

            WHEN a.actual_value IS NULL
                THEN 'no_actual'

            WHEN lowerUTF8(t.target_direction) = 'higher_is_better'
                 AND a.actual_value >= t.monthly_target
                THEN 'hit'

            WHEN lowerUTF8(t.target_direction) = 'higher_is_better'
                 AND a.actual_value < t.monthly_target
                THEN 'miss'

            WHEN lowerUTF8(t.target_direction) = 'lower_is_better'
                 AND a.actual_value <= t.monthly_target
                THEN 'hit'

            WHEN lowerUTF8(t.target_direction) = 'lower_is_better'
                 AND a.actual_value > t.monthly_target
                THEN 'miss'

            ELSE 'invalid_direction'
        END AS status

    FROM {{ source('mea', 'agreements') }} AS t

    LEFT JOIN all_actuals AS a
        ON t.unit = a.unit
        AND t.reporting_month = a.reporting_month
        AND t.data_item = a.data_item

        -- Select the actual source configured for this MEA
        AND CASE
            WHEN lowerUTF8(t.data_source) LIKE '%unit_a%'
                THEN 'unit_a'
            WHEN lowerUTF8(t.data_source) LIKE '%unit_b%'
                THEN 'unit_b'
            ELSE 'unknown'
        END = a.actual_source

)

SELECT *
FROM agreement_evaluation
