with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('mart_orders') }}
),

customer_orders as (
    select
        customer_id,
        count(order_id)        as total_orders,
        sum(revenue)           as total_revenue,
        sum(freight_cost)      as total_freight,
        min(purchased_at)      as first_order_at,
        max(purchased_at)      as last_order_at,
        avg(delivery_days)     as avg_delivery_days
    from orders
    group by customer_id
),

final as (
    select
        c.customer_id,
        c.customer_unique_id,
        c.customer_city,
        c.customer_state,
        coalesce(o.total_orders, 0)    as total_orders,
        coalesce(o.total_revenue, 0)   as total_revenue,
        coalesce(o.total_freight, 0)   as total_freight,
        o.first_order_at,
        o.last_order_at,
        o.avg_delivery_days
    from customers c
    left join customer_orders o on c.customer_id = o.customer_id
)

select * from final