with payments as (

    select * from {{ ref('stg_payments') }}

),

aggregated as (

    select
        payment_id,
        sum(amount) as total_amount
    from payments
    where status = 'success'

)

select * from aggregated
