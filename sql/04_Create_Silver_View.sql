

SELECT *

FROM 
  LOAD_DATA.LAKE_NYC_TAXI_DS.TRIP_DATA
-- WHERE "trip_distance" > 1 
WHERE "passenger_count" < 1 
limit 10 
;

  CREATE OR REPLACE VIEW SILVER.VIEW_TRIP_DATA
  AS 

  SELECT  TO_TIMESTAMP_NTZ(
  TO_VARCHAR(
    TO_TIMESTAMP_NTZ("tpep_pickup_datetime", 6), 
    'YYYY-MM-DD"T"HH:MI:SS"Z"'
)) AS PICKUP_DTTM
,  TO_TIMESTAMP_NTZ(TO_VARCHAR(
    TO_TIMESTAMP_NTZ("tpep_dropoff_datetime", 6), 
    'YYYY-MM-DD"T"HH:MI:SS"Z"'
)) AS DROPOFF_DTTM
, "trip_distance" as TRIP_DISTANCE_MILES
, "passenger_count" as PASSENGER_COUNT
,"PULocationID" as PICKUP_LOCATION_ID
,"DOLocationID" as DROPOFF_LOCATION_ID
, "payment_type" as PAYMENT_TYPE
, "fare_amount" as FARE_AMOUNT	

,CASE WHEN "Airport_fee" > 0 THEN TRUE ELSE FALSE END AS AIRPORT_RIDE_FLAG
,"mta_tax" as MTA_TAX
, "tip_amount" as TIP_AMOUNT
, "tolls_amount" as TOLLS_AMOUNT
, "total_amount" as TOTAL_AMOUNT
FROM 
  LOAD_DATA.LAKE_NYC_TAXI_DS.TRIP_DATA
-- LEFT JOIN 
LIMIT 100 
;

SELECT GET_DDL('TABLE','LOAD_DATA.LAKE_NYC_TAXI_DS.TRIP_DATA')
;


CREATE SCHEMA SILVER;

CREATE TRANSIENT TABLE SILVER.TRIP_DATA
(
TP_KEY UNIQUE 
,

)
;


create or replace TABLE TRIP_DATA (
	"VendorID" NUMBER(38,0),
	"tpep_pickup_datetime" NUMBER(38,0),
	"tpep_dropoff_datetime" NUMBER(38,0),
	"passenger_count" NUMBER(38,0),
	"trip_distance" FLOAT,
	"RatecodeID" NUMBER(38,0),
	"store_and_fwd_flag" VARCHAR(16777216),
	"PULocationID" NUMBER(38,0),
	"DOLocationID" NUMBER(38,0),
	"payment_type" NUMBER(38,0),
	"fare_amount" FLOAT,
	"extra" FLOAT,
	"mta_tax" FLOAT,
	"tip_amount" FLOAT,
	"tolls_amount" FLOAT,
	"improvement_surcharge" FLOAT,
	"total_amount" FLOAT,
	"congestion_surcharge" FLOAT,
	"Airport_fee" FLOAT,
	"cbd_congestion_fee" FLOAT
);

  

COPY INTO "CDC"."LAKE_CDC"." DNPAO" 
FROM (
SELECT $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31, $32, $33
	FROM '@CDC.LAKE_CDC.STAGE_CDC'
    ) 
FILES = ('CDC_Sample.csv') 
FILE_FORMAT = '"CDC"."LAKE_CDC"."FF_CSV"' 
ON_ERROR=ABORT_STATEMENT 
;
-- For more details, see: https://docs.snowflake.com/en/sql-reference/sql/copy-into-table


SELECT YEARSTART,COUNT(*) 
FROM "CDC"."LAKE_CDC"." DNPAO" 
GROUP BY YEARSTART
;


SELECT * FROM "CDC"."LAKE_CDC"." DNPAO" 

;

-- CDC.LAKE_CDC.STAGE_CDC