{{ config(
    materialized = 'view'
) }}

select
    case 
        when country_name = 'Viet Nam' then 'Vietnam'
        else country_name
    end as country,
    country_code as country_code,
    year_number as year,
    CAST(value AS FLOAT) as country_population
from
    {{ source('world_bank_raw', 'population_raw') }}
where    
    series_name = 'Population, total'
    and
    country_code is not null 