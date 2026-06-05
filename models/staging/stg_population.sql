{{ config(
    materialized = 'view'
) }}

select
    country_name as country,
    country_code as country_code,
    year_number as year,
    CAST(value AS FLOAT) as country_population
from
    {{ source('world_bank_raw', 'population_raw') }}
where    
    series_name = 'Population, total'
    and
    country_code is not null 