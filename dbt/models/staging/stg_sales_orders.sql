{{ config(
    materialized='view'
) }}

SELECT
    order_id,
    customer_id,
    order_date::date AS order_date,
    total_amount,
    status
FROM {{ source('staging','sales_orders') }}