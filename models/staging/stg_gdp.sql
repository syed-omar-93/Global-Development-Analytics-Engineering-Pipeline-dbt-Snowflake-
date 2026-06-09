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
    CAST(value AS FLOAT) as gdp_per_capita
from
    {{ source('world_bank_raw', 'gdp_raw') }}
where    
    series_name = 'GDP per capita (current US$)'
    and
    country_code is not null

