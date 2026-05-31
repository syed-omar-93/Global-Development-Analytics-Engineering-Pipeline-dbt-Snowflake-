/* Creating a raw schema */ 
CREATE SCHEMA IF NOT EXISTS DEV_DB.RAW

/* Create your stage inside the raw schema */
CREATE STAGE DEV_DB.RAW.WORLD_BANK_STAGE

/*Showing the list of CSV files available in the world bank stage*/
LIST @DEV_DB.RAW.WORLD_BANK_STAGE;