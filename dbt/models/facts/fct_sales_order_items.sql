{{ config(
    materialized = 'table'
)}}

-- Order-item grain level
select
    so.order_date,
    so.order_id,
    soi.order_item_id,
    soi.product_id,
    soi.warehouse_id,
    so.status,
    soi.quantity,
    soi.unit_price,
    p.cost_price
    (soi.quantity * soi.unit_price) as sub_total,
    (soi.unit_price - p.cost_price) * soi.quantity as profit
from
    {{ ref('stg_sales_orders')}} so 
join
    {{ ref('stg_sales_order_items')}} soi on so.order_id = soi.order_id
join 
    {{ ref('stg_products')}} p on soi.product_id = p.product_id
