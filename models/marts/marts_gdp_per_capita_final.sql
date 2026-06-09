/* Final GDP per capita marts table */

with all_countries_gdp as (
    select 
        country,
        gdp_per_capita as gdp_per_capita_2024,
        gdp_per_capita_ranking as gdp_per_capita_2024_ranking
    from {{ ref('core_all_countries_gdp_per_capita') }}
),

yearly as (
    select
        country,
        gdp_per_capita_2024,
        gdp_per_capita_2023,
        gdp_per_capita_2022,
        gdp_per_capita_2021,
        gdp_per_capita_2020
    from {{ ref('core_yearly_gdp_per_capitas') }}
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
        round(a.gdp_per_capita_2024, 0) as gdp_per_capita_2024,
        round(y.gdp_per_capita_2023, 0) as gdp_per_capita_2023,
        round(y.gdp_per_capita_2022, 0) as gdp_per_capita_2022,
        round(y.gdp_per_capita_2021, 0) as gdp_per_capita_2021,
        round(y.gdp_per_capita_2020, 0) as gdp_per_capita_2020
    from pop
    left join all_countries_gdp a 
        on pop.country = a.country
    left join yearly y 
        on pop.country = y.country
)

select *
from final
order by population_2024_ranking
