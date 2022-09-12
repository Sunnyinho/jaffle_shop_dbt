with orders as (

    select * from {{ ref('stg_orders') }}

),

macro_implemented_orders as (

    select
        order_id,
        customer_id,
        order_date,
        status
    from orders

    {{ limit_data('order_date', 10) }}

)

select * from macro_implemented_orders
