
/*Creating the life expectancy data landing table*/
CREATE OR REPLACE TABLE DEV_DB.RAW.LE_LANDING (
Country_Name string,
Country_Code string,
Series_Name string,
Series_Code string,
Year_2000 string,
Year_2001 string,
Year_2002 string,
Year_2003 string,
Year_2004 string,
Year_2005 string,
Year_2006 string,
Year_2007 string,
Year_2008 string,
Year_2009 string,
Year_2010 string,
Year_2011 string,
Year_2012 string,
Year_2013 string,
Year_2014 string,
Year_2015 string,
Year_2016 string,
Year_2017 string,
Year_2018 string,
Year_2019 string,
Year_2020 string,
Year_2021 string,
Year_2022 string,
Year_2023 string,
Year_2024 string,
Year_2025 string
);

SELECT * FROM DEV_DB.RAW.LE_LANDING

/*Now loading CSV file into the landing table*/
COPY INTO DEV_DB.RAW.LE_LANDING
FROM @DEV_DB.RAW.WORLD_BANK_STAGE/life_expectancy_raw.csv
file_format = (
    type='csv'
    skip_header=1
    field_optionally_enclosed_by='"'
);

/*Creating the clean raw data table for life expectancy data*/ 
CREATE OR REPLACE TABLE DEV_DB.RAW.LIFE_EXPECTANCY_RAW (
    country_name string,
    country_code string,
    series_name string,
    series_code string,
    Year_number number,
    VALUE float
);

SELECT * FROM DEV_DB.RAW.LIFE_EXPECTANCY_RAW

/*Unpivoting the life expectancy table into the raw table to 
get one row per country per year*/
INSERT INTO DEV_DB.RAW.LIFE_EXPECTANCY_RAW (
    country_name,
    country_code,
    series_name,
    series_code,
    year_number,
    value
)
SELECT
    Country_Name::string,
    Country_Code::string,
    Series_Name::string,
    Series_Code::string,
    replace(year_col, 'YEAR_', '')::number as year,
    TRY_CAST(value_col AS float) as value
FROM DEV_DB.RAW.LE_LANDING
UNPIVOT (
    value_col for year_col in (
        Year_2000, Year_2001, Year_2002, Year_2003, Year_2004,
        Year_2005, Year_2006, Year_2007, Year_2008, Year_2009,
        Year_2010, Year_2011, Year_2012, Year_2013, Year_2014,
        Year_2015, Year_2016, Year_2017, Year_2018, Year_2019,
        Year_2020, Year_2021, Year_2022, Year_2023, Year_2024,
        Year_2025
    )
);

/*Now querying the data to make sure we have got everything we need*/
SELECT * FROM DEV_DB.RAW.LIFE_EXPECTANCY_RAW 