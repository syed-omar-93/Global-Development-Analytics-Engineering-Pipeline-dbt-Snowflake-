/*Creating the final life_expectancy marts table*/ 

with all_countries_le as (
    select 
        country,
        life_expectancy as life_expectancy_2024,
        life_expectancy_ranking as life_expectancy_2024_ranking
    from {{ ref('core_all_countries_life_expectancies') }}
),

yearly as (
    select
        country,
        life_expectancy_2024,
        life_expectancy_2023,
        life_expectancy_2022,
        life_expectancy_2021,
        life_expectancy_2020
    from {{ ref('core_yearly_life_expectancies') }}
),

/*For the twenty most populous countries only*/ 
pop as (
    select
        country,
        population_ranking
    from {{ ref('core_all_countries_populations') }}
    where population_ranking between 1 and 20
),

final as (
    select
        a.country,
        pop.population_ranking as population_2024_ranking,
        round(a.life_expectancy_2024, 0) as life_expectancy_2024,
        round(y.life_expectancy_2023, 0) as life_expectancy_2023,
        round(y.life_expectancy_2022, 0) as life_expectancy_2022,
        round(y.life_expectancy_2021, 0) as life_expectancy_2021,
        round(y.life_expectancy_2020, 0) as life_expectancy_2020
    from pop
    left join all_countries_le a 
        on pop.country = a.country
    left join yearly y 
        on pop.country = y.country
)

select *
from final
order by population_2024_ranking