with orders as (

    select * from {{ ref('stg_orders') }}

),

intermediate_model as (

    select
        {{ dbt_utils.surrogate_key(['customer_id', 'order_date']) }} as id,
        customer_id,
        order_date,
        count(*)
    from orders
    group by 1, 2, 3

)

select * from intermediate_model
