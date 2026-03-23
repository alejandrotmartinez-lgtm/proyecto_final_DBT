{% macro calculate_net_price(extended_price, discount, tax) %}
    
    round( ({{ extended_price }} * (1 - {{ discount }}) * (1 + {{ tax }})), 2 )

{% endmacro %}