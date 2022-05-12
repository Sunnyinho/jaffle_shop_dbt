with customers as (
    select * from {{ref('stg_customers')}}
),

orders as (
    select * from {{ref('stg_orders')}}
),

payments as (
    select * from {{ref('stg_payments')}}
),

-- customer_count as (

--     select
--         customer_id,
--         count(order_id)>=3 as more_than_three_orders
--     from orders
--     group by customer_id
--     having count(order_id)>=3
--     order by customer_id
-- ),

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
    -- inner join customer_count
    --     using(customer_id)

    -- group by customer_id, order_date
    -- order by customer_id
    -- order_date desc

),

filtered_orders as (

    select *
    from customer_orders
    where rn = 1 and order_count >= 3

)

-- customer_payments as (

--     select

--         filtered_orders.*,

--         payments.amount

--     from payments
--     right join filtered_orders
--         on payments.order_id = filtered_orders.order_id
-- )

select * from filtered_orders

-- abc as (

--     select
--     *
--     from customer_orders
--     inner join customer_count
--     using (customer_id)
--     where customer_orders.rn = 1

-- )

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

