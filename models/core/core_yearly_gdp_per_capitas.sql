/* GDP per capita of each country for the last five years*/
with gdp_per_capita_ranking as 
(
    select 
    country, 
    year,
    row_number() over (partition by country order by year desc) AS yearly_ranking,
    gdp_per_capita as gdp_per_capita_2024,
    lag(gdp_per_capita) over (partition by country order by year) as gdp_per_capita_2023,
    lag(gdp_per_capita, 2) over (partition by country order by year) AS gdp_per_capita_2022,
    lag(gdp_per_capita, 3) over (partition by country order by year) AS gdp_per_capita_2021,
    lag(gdp_per_capita, 4) over (partition by country order by year) AS gdp_per_capita_2020
from 
    dev_db.public.stg_gdp
where year >= 2020 and year <= 2024
)

select 
    country,
    gdp_per_capita_2024,
    gdp_per_capita_2023,
    gdp_per_capita_2022,
    gdp_per_capita_2021,
    gdp_per_capita_2020
from 
    gdp_per_capita_ranking 
where 
    yearly_ranking = 1
    and 
    country in 
        (select country from dev_db.public.core_all_countries_populations
    )
    and 
    gdp_per_capita_2024 is not null 
order by gdp_per_capita_2024 desc;