with staging_customers as (
    select * from {{ ref('stg_tpch__customer') }}
),

cleaned_customers as (
    select
        c_custkey,
        trim(c_name) as c_name,
        trim(c_address) as c_address,
        c_nationkey,
        c_phone,
        substring(c_phone, 1, 2) as c_phone_cc,
        c_acctbal,
        upper(c_mktsegment) as c_mktsegment,
        coalesce(c_comment, 'Sin comentarios') as customer_comment

    from staging_customers
)

select * from cleaned_customers