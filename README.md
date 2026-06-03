# Global Development of the most populous 20 countries 
This is a project to explore and compare  a few development indicators of the world's 20 most populous countries.  

### Data Sources

This project uses publicly available datasets from the World Bank DataBank:

- GDP per capita (NY.GDP.PCAP.CD)
- Life expectancy at birth (SP.DYN.LE00.IN)
- Population, total (SP.POP.TOTL)

Sources: 
https://databank.worldbank.org/source

Databases:
World Development Indicators,
Health Nutrition and population statistics 

### Pipeline layers

Ingestion → loading the raw data into the database 

Staging → cleaning the raw data

Core → standardising + filtering to the last 5 years

Marts → applying business logic by filtering for the 20 most populous countries

