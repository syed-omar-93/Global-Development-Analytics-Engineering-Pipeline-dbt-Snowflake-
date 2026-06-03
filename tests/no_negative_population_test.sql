select * from 
{{ref('stg_population')}}
where country_population < 0 