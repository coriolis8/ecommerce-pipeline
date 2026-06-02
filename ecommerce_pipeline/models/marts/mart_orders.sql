with orders as (
    select * from {{ ref('stg_orders') }}
),

order_items as (
    select * from {{ ref('stg_order_items') }}
),

order_revenue as (
    select
        order_id,
        sum(price)         as revenue,
        sum(freight_value) as freight_cost
    from order_items
    group by order_id
),

final as (
    select
        o.order_id,
        o.customer_id,
        o.order_status,
        o.purchased_at,
        o.delivered_at,
        o.estimated_delivery_at,
        r.revenue,
        r.freight_cost,
        datediff('day', o.purchased_at, o.delivered_at) as delivery_days
    from orders o
    left join order_revenue r on o.order_id = r.order_id
)

select * from final