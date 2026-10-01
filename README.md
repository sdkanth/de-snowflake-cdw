# de-snowflake-cdw
Data Engineering Project for Snowflake  


Dateset : https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page

Yellow Taxi Trip Records (PARQUET)


1. Create/use  a Database to ingest Parquet/CSV data into Snowflake 
2. Create Schema for Lake NYC Taxi Data 
3. Create Snowflake managed Stage for loading CSV/Parquet files into it 
4. Create Lake Table based on infer schema from Parquet File 
5. Create Silver Table which is cleaned and ready to be ingested with business rules
	a. Remove Null Values 
	b. Standardize all Column_names as per requirement 
	c. Remove Duplicate values based on Primary Key/ Unique Key 
6. Load data from Lake to Silver based on View logic 
7. Create Gold Table 
	Dimension and Facts 
8. Load data from Silver to Gold through Views 
9. Automate the flow through Stored procs and snowflake tasks 
10. Schedule these tasks on a regular schedule daily/hourly at a set time 
