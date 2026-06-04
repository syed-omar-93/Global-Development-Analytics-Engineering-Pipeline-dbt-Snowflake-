/* Life expectancy of each country for the last five years*/
with life_expectancy_ranking as 
(
    select 
    country, 
    year,
    row_number() over 
    (partition by country order by year desc) AS yearly_ranking,
    life_expectancy as life_expectancy_2024,
    lag(life_expectancy) over 
    (partition by country order by year) as life_expectancy_2023,
    lag(life_expectancy, 2) over 
    (partition by country order by year) AS life_expectancy_2022,
    lag(life_expectancy, 3) over 
    (partition by country order by year) AS life_expectancy_2021,
    lag(life_expectancy, 4) over 
    (partition by country order by year) AS life_expectancy_2020
from 
    {{ ref ('stg_life_expectancy') }}
where year >= 2020 and year <= 2024
)

select 
    country,
    life_expectancy_2024,
    life_expectancy_2023,
    life_expectancy_2022,
    life_expectancy_2021,
    life_expectancy_2020
from 
    life_expectancy_ranking 
where 
    yearly_ranking = 1
    and 
    country in 
        (select country_name from {{ source('world_bank', 'dim_country') }})
    and 
    life_expectancy_2024 is not null 
order by life_expectancy_2024 desc
