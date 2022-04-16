with customers as (
    select * from {{ref('stg_customers')}}
),

orders as (
    select * from {{ref('stg_orders')}}
),

payments as (
    select * from {{ref('stg_payments')}}
),

customer_orders as (
    select
        customer_id,
        count(order_id) >= 3 as more_than_three_orders
    from orders
    group by customer_id
),

final as (
    select
        customers.customer_id,
        customers.first_name,
        case when customer_orders.more_than_three_orders = t then xyz
    from customers

    right join customer_orders
        on customers.customer_id = customer_orders.customer_id

)

select * from final