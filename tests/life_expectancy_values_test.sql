select * 
from {{ ref('stg_life_expectancy') }} 
where
life_expectancy >= 120 