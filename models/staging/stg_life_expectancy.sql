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
    CAST(value AS FLOAT) as life_expectancy
from
    {{ source('world_bank_raw', 'life_expectancy_raw') }}
where    
    series_name = 'Life expectancy at birth, total (years)'
    and
    country_code is not null