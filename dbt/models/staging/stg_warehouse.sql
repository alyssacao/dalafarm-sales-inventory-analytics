{{ config(
    materialized='view'
) }}

SELECT
    warehouse_id,
    warehouse_name,
    location
FROM {{ source('staging','warehouses') }}