{{ config(
    materialized = 'view'
) }}

with bounds as (
    select 
        min(order_date) as min_date,
        max(order_date) as max_date
    from {{ ref('stg_sales_orders') }}
),

dates as (
    select 
        dateadd(day, i, min_date)::date as date_key
    from bounds
    join 
        (select row_number() over() - 1 as i
         from information_schema.tables
         limit 10000) n
    on i <= datediff(day, min_date, max_date)
)

select 
    date_key,
    extract(year from date_key)::int as year,
    extract(month from date_key)::int as month,
    extract(day from date_key)::int as day,
    extract(dow from date_key)::int as day_of_week,
    to_char(date_key, 'YYYY-MM')::varchar(7) as year_month,
    case when extract(dow from date_key)::int in (0,6) then 'Weekend' else 'Weekday' end as weekday_weekend
from dates
