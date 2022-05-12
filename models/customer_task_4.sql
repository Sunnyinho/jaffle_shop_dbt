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
    where rn = 1 and order_count >= 3

),

customer_payments as (

    select
        filtered_orders.* ,
        sum(payments.amount) as total_amount
    from payments

    right join filtered_orders
        on payments.order_id = filtered_orders.order_id

    group by filtered_orders.customer_id, filtered_orders.order_id, filtered_orders.order_date, row_after_most_recent_order, row_after_most_recent, filtered_orders.rn, filtered_orders.order_count

)

select * from customer_payments