{% macro limit_data(column_name, year_of_data) -%}
{%- if target.name == 'dev' -%}
    where {{ column_name }} >=  current_timestamp - interval '{{year_of_data}} years'
{%- endif -%}
{%- endmacro -%}