/* Life expectancy of each country for the latest year*/
with CTE_latest_life_expectancies
as 
(
select 
country, 
year, 
life_expectancy, 
row_number() over 
(partition by country order by year desc) as year_ranking
from {{ ref ('stg_life_expectancy') }}
where life_expectancy is not null 
)


/*Life expectancy ranking of each soveriegn country*/ 
select 
country, 
life_expectancy, 
row_number() over (order by life_expectancy desc) as life_expectancy_ranking
FROM CTE_latest_life_expectancies
WHERE 
(
country in
(select country_name FROM {{ source('world_bank', 'dim_country') }})
)
and 
year_ranking = 1