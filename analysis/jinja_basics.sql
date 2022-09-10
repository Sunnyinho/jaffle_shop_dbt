{% set cool_message = 'wow "cool!"' %}
{% set another_cool_message = 'this is jinja' %}
{% set number = 100 %}
{{ cool_message }} {{another_cool_message}} I want to write jinja for {{ number/10 }} times


{% set my_animals = [ 'Tiger', 'Lion', 'Girraf', 'Elephant', 'Mongoose' ] %}
{% for animals in my_animals %}
My favourite animals are : {{animals}}
{% endfor %}


{% set temperature = 15 %}
{% if temperature < 25 %}
Time for a coffee.
{% else %}
Time for a beer
{% endif %}