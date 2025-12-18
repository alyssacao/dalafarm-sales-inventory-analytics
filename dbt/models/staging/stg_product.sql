{{ config(
    materialized='view'
) }}

SELECT
    product_id,
    product_name,
    category,
    unit_price,
    cost_price,
    perishable,
    shelf_life_days,
    supplier_id
FROM {{ source('staging','products') }}