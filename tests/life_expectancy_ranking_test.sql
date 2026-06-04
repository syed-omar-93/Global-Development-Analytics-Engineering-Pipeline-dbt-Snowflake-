with country_count as (
    select count(*) as total_countries
    from {{ source('world_bank', 'dim_country') }}
)

select s.*
from {{ ref('core_all_countries_life_expectancies') }} s
cross join country_count c
where s.life_expectancy_ranking < 0
   or s.life_expectancy_ranking > c.total_countries 