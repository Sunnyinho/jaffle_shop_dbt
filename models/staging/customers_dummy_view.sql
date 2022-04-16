
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
    customer_id, --mathi with customers bata ako ho stg_customers ma customer_id column chha.

    min(order_date) as first_order, -- stg_order ma order_date chha
    max(order_date) as most_recent_order,
    count(order_id) as number_of_orders -- stg_order ma order_id chha

    from orders

    group by customer_id

),

final as (
    select 
    customers.customer_id as customer_id,
    customer_orders.first_order as first_order,
    customer_orders.most_recent_order as most_recent_order,
    customer_orders.number_of_orders as number_of_orders

    from customers

    left join customer_orders
        on customers.customer_id = customer_orders.customer_id

)

select * from final
