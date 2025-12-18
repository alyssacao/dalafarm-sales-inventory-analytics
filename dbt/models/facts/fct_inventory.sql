{{ config (
    materialize = 'table'
)}}

select 
    i.product_id,
    i.warehouse_id,
    p.supplier_id,
    i.stock_on_hand,
    i.expiry_date
from 
    {{ ref('stg_inventory')}} i
join 
    {{ ref('stg_products')}} p
on i.product_id = p.product_id
where 
    i.product_id is not null