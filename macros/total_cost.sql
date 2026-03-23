{% macro calculate_total_cost(qty, cost) %}
    
    ( {{ qty }} * {{ cost }} )
    
{% endmacro %}