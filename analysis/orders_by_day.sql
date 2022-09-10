with source as (

    select * from {{ ref('stg_orders') }}

),


daily as (

    select
        order_date,
        count(*) as order_num
    from source
    group by 1
)

select * from daily
