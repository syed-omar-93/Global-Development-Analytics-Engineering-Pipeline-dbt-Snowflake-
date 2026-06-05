/* Population of each country for the last five years*/
/* Population of each country for the last five years*/
with population_ranking as 
(
    select 
    country, 
    year,
    row_number() over (partition by country order by year desc) AS yearly_ranking,
    country_population AS population_2024,
    lag(country_population) over 
    (partition by country order by year) AS population_2023,
    lag(country_population, 2) over 
    (partition by country order by year) AS population_2022,
    lag(country_population, 3) over 
    (partition by country order by year) AS population_2021,
    lag(country_population, 4) over (partition by country order by year) AS population_2020
from 
    {{ ref('stg_population') }}
where year >= 2020 and year <= 2024
)

select 
    country,
    population_2024,
    population_2023,
    population_2022,
    population_2021,
    population_2020
from 
    population_ranking 
where 
    yearly_ranking = 1
    and 
    country in 
        (select country_name from {{ source('world_bank', 'dim_country') }})
    and 
    population_2024 is not null
order by population_2024 desc