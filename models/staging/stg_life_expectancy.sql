{{ config(
    materialized = 'view'
) }}

select
    country_name as country,
    country_code as country_code,
    year_number as year,
    value as life_expectancy
from
    {{ source('world_bank_raw', 'life_expectancy_raw') }}
where    
    series_name = 'Life expectancy at birth, total (years)'
    and
    country_code is not null