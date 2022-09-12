{{ dbt_utils.date_spine(
    datepart="hour",
    start_date="cast('2019-01-01' as date)",
    end_date="cast('2020-01-01' as date)"
   )
}}
