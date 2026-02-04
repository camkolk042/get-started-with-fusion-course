with orders as (



    select

    order_id,

    order_date,

    count_food_items,

    count_drink_items,

    order_total,



    case

        when count_food_items > 0 and count_drink_items > 0 then 'mixed'

        when count_food_items > 0 then 'food_only'

        when count_drink_items > 0 then 'drink_only'

        else 'unknown'

    end as order_type



from {{ ref('orders') }}



),


rollup as (



select

    order_type,

    avg(order_total) as avg_profit_per_order,

    count(*) as order_count

    from orders

    group by order_type



),


final as (
select

    order_type,

    order_count,

    avg_profit_per_order

    from rollup

   
)

select *
from final
order by order_type