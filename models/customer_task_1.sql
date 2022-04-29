-- basic learning 


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
        count(order_id) as total_orders
    from orders

    group by customer_id

),

customer_payments as (

    select
    
        orders.customer_id,
        sum(amount) as total_amount,
        round(avg(amount),2) as total_average

    from payments

    left join orders
        on payments.order_id = orders.customer_id

    group by orders.customer_id

),

final as (

    select
        customers.customer_id,
        customers.first_name,
        customer_orders.total_orders,
        customer_payments.total_amount,
        customer_payments.total_average
    
    from customers

    left join customer_orders 
        on customers.customer_id = customer_orders.customer_id

    left join customer_payments
        on customers.customer_id = customer_payments.customer_id


)

select * from final