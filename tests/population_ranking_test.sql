with country_count as (
    select count(*) as total_countries
    from {{ source('world_bank', 'dim_country') }}
)

select t.*
from {{ ref('core_all_countries_populations') }} t
cross join country_count c
where t.population_ranking < 0
   or t.population_ranking > c.total_countries 