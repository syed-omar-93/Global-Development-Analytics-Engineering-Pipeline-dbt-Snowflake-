/* Population of each country for the latest year*/
WITH CTE_latest_populations 
as (
select 
    country, 
    year, 
    country_population, 
    row_number() 
    over 
    (partition by country order by year desc) as year_ranking
from 
   {{ ref('stg_population') }}
qualify year_ranking = 1
)

/*Population ranking of each soveriegn country*/ 
select 
    country, 
    country_population, 
    row_number() 
    over 
    (order by country_population desc) as population_ranking
from 
    CTE_latest_populations
where
    country in 
    (select country_name from {{ source('world_bank', 'dim_country') }})
