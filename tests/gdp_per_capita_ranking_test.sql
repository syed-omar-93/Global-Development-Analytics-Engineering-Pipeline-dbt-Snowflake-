with country_count as (
    select count(*) as total_countries
    from {{ source('world_bank', 'dim_country') }}
)

select m.*
from {{ ref('core_all_countries_gdp_per_capita') }} m
cross join country_count c
where m.gdp_per_capita_ranking < 1
   or m.gdp_per_capita_ranking > c.total_countries
