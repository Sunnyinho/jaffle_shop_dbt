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
        order_id,
        order_date,
        lead(order_date) over (partition by customer_id order by order_date desc) as row_after_most_recent,
        lead(order_id) over (partition by customer_id order by order_date desc) as row_after_most_recent_order,
        row_number() over (partition by customer_id) as rn,
        count(customer_id) over (partition by customer_id) as order_count

    from orders
),

filtered_orders as (

    select *
    from customer_orders
    where  order_count >= 3
--  rn = 1 and
)



select * from filtered_orders