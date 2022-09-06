with customers as (
    
    select * from {{ ref('stg_customers') }}

),

orders as (

    select * from {{ ref('stg_orders') }}

),

payments as (

    select * from {{ ref('stg_payments') }}

),

intermediate_model as (

    select
        orders.order_id as order_id,
        customers.customer_id as customer_id
        

    from orders

    left join customers
        on orders.customer_id = customers.customer_id
    
    -- group by customers.customer_id, orders.order_id

),

-- select * from intermediate_model

final as (

    select

        intermediate_model.order_id,
        intermediate_model.customer_id,    
        payments.amount

        from intermediate_model

        left join payments
            on intermediate_model.order_id = payments.order_id
        
)

select * from final
