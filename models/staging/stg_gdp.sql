{{ config(
    materialized = 'view'
) }}

select
    country_name as country,
    country_code as country_code,
    year_number as year,
    CAST(value AS FLOAT) as gdp_per_capita
from
    {{ source('world_bank_raw', 'gdp_raw') }}
where    
    series_name = 'GDP per capita (current US$)'
    and
    country_code is not null

