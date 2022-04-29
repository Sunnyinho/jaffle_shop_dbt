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
        order_date,
        lead(order_date) over (partition by customer_id) as row_after_most_recent,
        row_number() over (partition by customer_id) as rn

    from orders
    group by customer_id, order_date
    order by customer_id asc, order_date desc

)

-- customer_payments as (

--     select
--         orders.customer_id,
--         amount
--     from payments

--     left join orders
--         on payments.order_id = orders.order_id

--    group by orders.customer_id, amount

-- ),

-- final as (
--     select
--         customer_orders.customer_id,
--         customer_orders.order_date,
--         customer_orders.row_after_most_recent,
--         customer_orders.rn,

--         customer_payments.amount
--     from customers

--     left join customer_orders
--         on customers.customer_id = customer_orders.customer_id

--     left join customer_payments
--         on customers.customer_id = customer_payments.customer_id


-- )

select * from customer_orders