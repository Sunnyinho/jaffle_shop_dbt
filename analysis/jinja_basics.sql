{%- set cool_message = 'wow "cool!"' -%}
{%- set another_cool_message = 'this is jinja' -%}
{%- set number = 100 -%}
{{ cool_message }} {{another_cool_message}} I want to write jinja for {{ number/10 }} times


{% set my_animals = [ 'Tiger', 'Lion', 'Girraf', 'Elephant', 'Mongoose' ] -%}
{%- for animals in my_animals  -%}
My favourite animals are : {{animals}}
{% endfor %}

{%- set temperature = 15 -%}
{% if temperature < 25 %}
Time for a coffee.
{%- else -%}
Time for a beer
{% endif %}

{% set foods = [ 'Tomato', 'Hotdog', 'Broccoli', 'Potato' ] -%}
{%- for food in foods -%}
    {%- if food == 'Hotdog' -%}
        {% set food_item = 'snack' %}
    {%- else -%}
        {%- set food_item = 'vegetables' -%}
    {% endif %}
This humble {{ food }} is my favourite {{ food_item }}
{% endfor %}

{% set word_set = {
    'name':'Ram',
    'age': 24,
    'address': 'Singapore'
} -%}
The name is {{word_set['name']}}. He lives in {{word_set['address']}} and his age is {{word_set.get('age')}}
