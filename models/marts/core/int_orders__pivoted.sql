{%- set payment_methods = ['bank_transfer', 'coupon', 'credit_card', 'gift_card'] -%}

with payments as (

    select * from {{ ref('stg_payments') }}

),

-- pivoted as (

--     select
--         order_id,
--         sum(case when payment_method='bank_transfer' then amount else 0 end) as bank_transfer_amount,
--         sum(case when payment_method='coupon' then amount else 0 end) as coupon_amount,
--         sum(case when payment_method='credit_card' then amount else 0 end) as credit_card_amount,
--         sum(case when payment_method='gift_card' then amount else 0 end) as gift_card_amount
--     from payments
--     group by order_id
--     -- order by order_id asc

-- )

-- select * from pivoted
-- inplementing above method using jinja methods

pivoted as (

    select
        order_id,
        {% for pay_method in payment_methods -%}
            sum(case when payment_method = '{{pay_method}}' then amount else 0 end) as {{pay_method}}_amount
        {%- if not loop.last -%}
                ,
        {% endif -%}
        {%- endfor %}
    from payments
    group by order_id
    order by order_id

)

select * from pivoted
