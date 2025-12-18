{{ config(
    materialized ='table'
)}}


SELECT
    product_id,
    product_name,
    category,
    unit_price,
    cost_price,
    perishable,
    shelf_life_days,
    supplier_id
FROM
    {{ref('stg_products')}}