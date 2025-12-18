{{ config(
    materialized='view'
) }}

SELECT
    inventory_id,
    product_id,
    warehouse_id,
    stock_on_hand,
    restock_date,
    expiry_date
FROM {{ source('staging', 'inventory') }}