select * from 
{{ ref('stg_gdp') }}
where gdp_per_capita < 0