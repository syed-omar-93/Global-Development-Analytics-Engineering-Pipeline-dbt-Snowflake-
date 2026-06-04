/* GDP per capita of each country for the latest year*/
with CTE_latest_gdp_per_capita
as (
select country, 
year, 
gdp_per_capita,
row_number() over (partition by country order by year desc) as year_ranking
from {{ ref ('stg_gdp') }}
where gdp_per_capita is not null 
)

/*GDP per capita ranking of each soveriegn country*/ 
select 
country, 
gdp_per_capita, 
row_number() over (order by gdp_per_capita desc) as gdp_per_capita_ranking
from CTE_latest_gdp_per_capita
where
country in
(select country_name from {{ source('world_bank', 'dim_country') }})
and 
year_ranking = 1 