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
        count(order_id)>=3 as more_than_three_orders
    from orders
    group by customer_id
    having count(order_id)>=3
),

customer_sum_amount as (

    select 
        customer_id,
        order_date,
        max(order_date) over (partition by customer_id order by order_date desc) as most_recent_order_date,
        lead(order_date) over (partition by customer_id order by order_date desc),
        row_number() over (partition by customer_id order by order_date desc) as rn
    from orders

),

filtered as (

    select * from customer_sum_amount  where rn = 1

),

final as (
    select
        customers.customer_id,
        customers.first_name
        -- customer_orders.more_than_three_orders
    from customers

    inner join customer_orders
        on customers.customer_id = customer_orders.customer_id
    
    --  where more_than_three_orders is true
)

select * from filtered


--select ma sabai column haru select garni ho aani kasto khalko operation haru garni, and from pachhi ko part ma chai filters haru garni ho.