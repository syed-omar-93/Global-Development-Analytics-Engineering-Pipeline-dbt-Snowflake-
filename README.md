# Global Development of the most populous 20 countries 

### Project Overview 

This project analyses key development indicators for the world’s 20 most populous countries. Using raw datasets from the World Bank (GDP per capita, life expectancy, and population), the project applies a modern Analytics Engineering workflow using dbt Core and Snowflake to transform messy CSV files into clean and analysis ready data sets.

The final curated datasets cover the last five years (2020–2024) and will be used in Power BI to explore development trends, compare countries, and answer the project’s business questions.

### Business Questions

This project aims to answer:


•	Which countries have seen the biggest rise in GDP per capita, life expectancy, and population over the last five years?

•	How does population growth compare across the world’s 20 most populous countries?

•	Is there a relationship between GDP per capita and life expectancy?

•	Which countries have the fastest declining populations?

•	Which countries have the fastest growing populations?

### Tools & platforms

•	dbt Core

•	Snowflake

•	Git & GitHub

•	Visual Studio Code

### Languages & Formats

•	SQL

•	YAML

•	Jinja

### Data Sources 

This project uses publicly available datasets from the World Bank DataBank:

•	GDP per capita (NY.GDP.PCAP.CD): Annual GDP per capita values for all countries and regions (2000–2024).

•	Life expectancy at birth (SP.DYN.LE00.IN): Annual life expectancy values for all countries and regions (2000–2024).

•	Population, total (SP.POP.TOTL): Annual population counts for all countries and regions (2000–2024).

Sources: https://databank.worldbank.org/source 

Databases: World Development Indicators, Health Nutrition and Population Statistics

### Model Architecture (Ingestion → RAW → STAGING → CORE → MARTS)

•	Ingestion — Loading the raw CSV files into Snowflake

•	RAW — Storing the unmodified source data exactly as received

•	Staging — Cleaning, renaming, typing, and defining sources

•	Core — Standardising and filtering the data to the last five years

•	Marts — Applying business logic to identify the 20 most populous countries

### Final Marts Tables

1. marts_gdp_per_capita_final

GDP per capita values for the 20 most populous countries from 2020–2024, allowing analysis of year on year economic growth and comparisons across countries.

2. marts_life_expectancy_final

Life expectancy values for the same 20 countries from 2020–2024, supporting health trend analysis.

3. marts_populations_final

Population totals for the 20 countries from 2020–2024, including population rankings and annual population counts, allowing calculation of population growth rates and identification of fast-growing or declining countries.

### Intended Analysis

The final marts tables will be used to analyse development trends across the world’s 20 most populous countries. The analysis will highlight growth patterns, compare economic and health outcomes, and identify countries showing strong or weak improvements across multiple indicators.
The twenty most populous countries were selected because they represent a large share of the world’s population and provide a diverse mix of economic and social contexts. This scope allows for meaningful comparisons while keeping the analysis focused and manageable.
The dim_country table acts as a reference dimension table, containing clean and curated metadata about countries. Because it is already consistent and reliable, it is used directly in the core and marts layers without additional modelling. This keeps the project simple and avoids unnecessary modelling complexity.

### Data Quality Tests 

The following dbt tests were implemented:

•	not_null

•	unique

•	accepted_values

•	relationships

These tests ensure data completeness, consistency, and referential integrity. By referential integrity, this means that all the key relationships between models are valid and every referenced country in the cleaned and transformed tables exist in the source table.
Custom SQL tests were also created to validate population rankings and life expectancy ranges.

### Lineage Graph 

A full Directed Acyclic Graph (DAG) is generated using dbt Docs, showing the flow of data from the sources to the relevant staging models then to the core models and then to the final mart models. This is shown below. 
The sources are highlighted in green while the models are in light blue. 

<img width="1332" height="544" alt="Lineage graph" src="https://github.com/user-attachments/assets/f1cdf59a-e6e3-4000-8cbc-0d60d89a91b3" />


### Project workflow 

The workflow below summarises the main steps followed from start to finish — from ingesting raw data to building the final marts and analysing the results.

•	Ingest raw CSV files into Snowflake.

•	Define raw sources in dbt.

•	Build staging models to clean, standardise and structure the raw data.

•	Build core models to filter all indicators to the last five years (2020 to 2024).

•	Build marts models to identify the 20 most populous countries and apply business logic.

•	Add schema tests and custom tests to ensure data quality and integrity. 

•	Generate documentation and the lineage graph using dbt docs.

•	Version control the project using Git and GitHub.

•	Load the final marts tables into Power BI for analysis.

•	Analyse and visualise the data to answer the business questions and uncover insights. 

### How to run this project 

The steps below show how to set up the environment, run the dbt pipeline, and reproduce the final analysis using the curated marts tables.

1.	Set up a Snowflake account.
2.	Install Python and dbt Core with the dbt snowflake adapter.
3.	Initialise a dbt project in Visual Studio Code.
4.	Create a database and schema in Snowflake.
5.	Load the raw CSV files into Snowflake and define them as dbt sources.
6.	Build the staging, core, and marts models using SQL + Jinja.
7.	Define schema.yml files with model descriptions and tests.
8.	Run and test the models using dbt Core.
9.	Version control the project using Git and push to GitHub.
10.	Connect Power BI to Snowflake and begin analysis.

### Future Improvements 

The items below describe potential key opportunities for future development:

•	Add additional development indicators (literacy rates, healthcare access, electricity access, clean water access, infant mortality).

•	Introduce incremental models and snapshots.

•	Implement CI/CD for automated testing and deployment.

•	Automate ingestion using tools such as Airbyte or Fivetran.

•	Schedule the pipeline to refresh automatically when new data becomes available.





