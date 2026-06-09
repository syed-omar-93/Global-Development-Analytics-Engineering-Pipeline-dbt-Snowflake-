/*Creating the final population marts table*/ 

/* Final population marts table */

with all_countries_pop as (
    select 
        country,
        country_population as population_2024,
        population_ranking as population_2024_ranking
    from {{ ref('core_all_countries_populations') }} 
    where population_ranking between 1 and 20
),

yearly as (
    select
        country,
        population_2024,
        population_2023,
        population_2022,
        population_2021,
        population_2020
    from {{ ref('core_yearly_populations') }}
),

final as (
    select
        a.country,
        a.population_2024_ranking,
        round(a.population_2024, 0) as population_2024,
        round(y.population_2023, 0) as population_2023,
        round(y.population_2022, 0) as population_2022,
        round(y.population_2021, 0) as population_2021,
        round(y.population_2020, 0) as population_2020 
    from all_countries_pop a 
    left join yearly y 
        on a.country = y.country
)

select *
from final
order by population_2024_ranking