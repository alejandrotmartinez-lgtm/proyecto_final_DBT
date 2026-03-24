with 

customers as (
    select * from {{ ref('int_customers_cleaned') }}
),

nations as (
    select * from {{ ref('stg_tpch__nation') }}
),

regions as (
    select * from {{ ref('stg_tpch__region') }}
),

final as (
    select
        c.c_custkey as customer_key,
        c.c_name as customer_name,
        c.c_address as customer_address,
        c.c_phone as customer_phone,
        c.c_phone_cc as phone_country_code,
        c.c_phone_ln as phone_local_number,
        c.c_acctbal as account_balance,
        c.c_mktsegment as market_segment,
        n.n_name as nation_name,
        r.r_name as region_name
    from customers c
    left join nations n on c.c_nationkey = n.n_nationkey
    left join regions r on n.n_regionkey = r.r_regionkey
)

select * from final