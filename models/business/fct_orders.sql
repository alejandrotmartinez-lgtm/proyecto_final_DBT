with orders as (
    select * from {{ ref('stg_tpch__orders') }}
),

lineitems as (
    select * from {{ ref('stg_tpch__lineitem') }}
),

partsupp as (
    select * from {{ ref('stg_tpch__partsupp') }}
),

final as (
    select
        o.o_orderkey as order_key,
        o.o_custkey as customer_key,
        l.l_partkey as part_key,
        l.l_suppkey as supplier_key,
        o.o_orderdate as order_date,
        o.o_orderstatus as order_status,
        l.l_linenumber as line_number,
        l.l_quantity as quantity,
        l.l_extendedprice as extended_price,
        l.l_discount as discount,
        l.l_tax as tax,
        ps.ps_supplycost as unit_supply_cost,
        {{ calculate_net_price('l.l_extendedprice', 'l.l_discount', 'l.l_tax') }} as net_item_sales_amount,
        ({{ calculate_net_price('l.l_extendedprice', 'l.l_discount', 'l.l_tax') }} - {{calculate_total_cost('l.l_quantity', 'ps.ps_supplycost')}}) as item_profit

    from orders o
    join lineitems l on o.o_orderkey = l.l_orderkey
    left join partsupp ps on l.l_partkey = ps.ps_partkey and l.l_suppkey = ps.ps_suppkey
)

select * from final