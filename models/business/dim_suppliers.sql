with suppliers as (
    select * from {{ ref('stg_tpch__supplier') }}
),

nations as (
    select * from {{ ref('stg_tpch__nation') }}
),

regions as (
    select * from {{ ref('stg_tpch__region') }}
),

final as (
    select
        s.s_suppkey as supplier_key,
        s.s_name as supplier_name,
        s.s_address as supplier_address,
        s.s_phone as supplier_phone,
        s.s_acctbal as account_balance,
        n.n_name as nation_name,
        r.r_name as region_name
    from suppliers s
    left join nations n on s.s_nationkey = n.n_nationkey
    left join regions r on n.n_regionkey = r.r_regionkey
)

select * from final