/*
Some errors with the schema let to some of the schema being changed:
Green
- passenger_count was changed to FLOAT
- payment_type was changed to FLOAT
- ehail_fee was changed to INTEGER
- trip_type was changed to FLOAT
- RatecodeID was changed to FLOAT
- ehail_fee was eventually removed from the schema as different files had different data types: float and integer

Yellow
- payment_type was changed back to INTEGER
*/

CREATE OR REPLACE EXTERNAL TABLE `zoomcamp-de-411412.trips_data_all.green_tripdata_ext`
    OPTIONS (
        format = 'PARQUET',
        uris = ['gs://mage-zoomcamp-onubrooks/green/*'],
        reference_file_schema_uri = 'gs://mage-zoomcamp-onubrooks/schemas/green_schema.json'
    );

CREATE OR REPLACE EXTERNAL TABLE `zoomcamp-de-411412.trips_data_all.yellow_tripdata_ext`
    OPTIONS (
        format = 'PARQUET',
        uris = ['gs://mage-zoomcamp-onubrooks/yellow/*'],
        reference_file_schema_uri = 'gs://mage-zoomcamp-onubrooks/schemas/yellow_schema.json'
    );

CREATE OR REPLACE EXTERNAL TABLE `zoomcamp-de-411412.trips_data_all.fhv_tripdata_ext`
    OPTIONS (
        format = 'PARQUET',
        uris = ['gs://mage-zoomcamp-onubrooks/fhv/*']
    );


LOAD DATA INTO `zoomcamp-de-411412.trips_data_all.green_tripdata`(VendorID INT64, lpep_pickup_datetime TIMESTAMP, lpep_dropoff_datetime TIMESTAMP, store_and_fwd_flag STRING, RatecodeID FLOAT64, PULocationID INT64, DOLocationID INT64, passenger_count FLOAT64, trip_distance FLOAT64, fare_amount FLOAT64, extra FLOAT64, mta_tax FLOAT64, tip_amount FLOAT64, tolls_amount FLOAT64, improvement_surcharge FLOAT64, congestion_surcharge FLOAT64, total_amount FLOAT64, payment_type FLOAT64, trip_type FLOAT64)
  FROM FILES(
    format='PARQUET',
    uris = ['gs://mage-zoomcamp-onubrooks/green/*']
  );

LOAD DATA INTO `zoomcamp-de-411412.trips_data_all.yellow_tripdata`(VendorID INT64, tpep_pickup_datetime TIMESTAMP, tpep_dropoff_datetime TIMESTAMP, passenger_count FLOAT64, trip_distance FLOAT64, RatecodeID FLOAT64, store_and_fwd_flag STRING, PULocationID INT64, DOLocationID INT64, payment_type INT64, trip_type INT64, fare_amount FLOAT64, extra FLOAT64, mta_tax FLOAT64, tip_amount FLOAT64, tolls_amount FLOAT64, improvement_surcharge FLOAT64, congestion_surcharge FLOAT64, total_amount FLOAT64)
  FROM FILES(
    format='PARQUET',
    uris = ['gs://mage-zoomcamp-onubrooks/yellow/*']
  );


LOAD DATA INTO `zoomcamp-de-411412.trips_data_all.fhv_tripdata`(Dispatching_base_num STRING, Pickup_datetime TIMESTAMP, DropOff_datetime TIMESTAMP, PULocationID FLOAT64, DOLocationID FLOAT64, SR_Flag INTEGER)
  FROM FILES(
    format='PARQUET',
    uris = ['gs://mage-zoomcamp-onubrooks/fhv/*']
  );

CREATE OR REPLACE TABLE `zoomcamp-de-411412.trips_data_all.green_tripdata`
  AS SELECT * FROM `zoomcamp-de-411412.trips_data_all.green_tripdata_ext`;

CREATE OR REPLACE TABLE `zoomcamp-de-411412.trips_data_all.yellow_tripdata`
  AS SELECT * FROM `zoomcamp-de-411412.trips_data_all.yellow_tripdata_ext`;

CREATE OR REPLACE TABLE `zoomcamp-de-411412.trips_data_all.fhv_tripdata`
    AS SELECT * FROM `zoomcamp-de-411412.trips_data_all.fhv_tripdata_ext`;

  /*
  Alternatively, the tables could be created from bigquery public datasets as follows:
  */
  CREATE TABLE `zoomcamp-de-411412.trips_data_all.green_tripdata` AS
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_green_trips_2019` 

INSERT INTO `zoomcamp-de-411412.trips_data_all.green_tripdata`
    SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_green_trips_2020`;


CREATE TABLE `zoomcamp-de-411412.trips_data_all.yellow_tripdata` AS
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2019`

INSERT INTO `zoomcamp-de-411412.trips_data_all.yellow_tripdata`
    SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2020`;

CREATE TABLE `zoomcamp-de-411412.trips_data_all.fhv_tripdata` AS
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_fhv_trips_2019`

-- INSERT INTO `zoomcamp-de-411412.trips_data_all.fhv_tripdata`
    -- SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_fhv_trips_2020`;

/* fix the schema for green_tripdata */
-- Fixes yellow table schema
ALTER TABLE `zoomcamp-de-411412.trips_data_all.yellow_tripdata`
  RENAME COLUMN vendor_id TO VendorID;
ALTER TABLE `zoomcamp-de-411412.trips_data_all.yellow_tripdata`
  RENAME COLUMN pickup_datetime TO tpep_pickup_datetime;
ALTER TABLE `zoomcamp-de-411412.trips_data_all.yellow_tripdata`
  RENAME COLUMN dropoff_datetime TO tpep_dropoff_datetime;
ALTER TABLE `zoomcamp-de-411412.trips_data_all.yellow_tripdata`
  RENAME COLUMN rate_code TO RatecodeID;
ALTER TABLE `zoomcamp-de-411412.trips_data_all.yellow_tripdata`
  RENAME COLUMN imp_surcharge TO improvement_surcharge;
ALTER TABLE `zoomcamp-de-411412.trips_data_all.yellow_tripdata`
  RENAME COLUMN pickup_location_id TO PULocationID;
ALTER TABLE `zoomcamp-de-411412.trips_data_all.yellow_tripdata`
  RENAME COLUMN dropoff_location_id TO DOLocationID;

  -- Fixes green table schema
ALTER TABLE `zoomcamp-de-411412.trips_data_all.green_tripdata`
  RENAME COLUMN vendor_id TO VendorID;
ALTER TABLE `zoomcamp-de-411412.trips_data_all.green_tripdata`
  RENAME COLUMN pickup_datetime TO lpep_pickup_datetime;
ALTER TABLE `zoomcamp-de-411412.trips_data_all.green_tripdata`
  RENAME COLUMN dropoff_datetime TO lpep_dropoff_datetime;
ALTER TABLE `zoomcamp-de-411412.trips_data_all.green_tripdata`
  RENAME COLUMN rate_code TO RatecodeID;
ALTER TABLE `zoomcamp-de-411412.trips_data_all.green_tripdata`
  RENAME COLUMN imp_surcharge TO improvement_surcharge;
ALTER TABLE `zoomcamp-de-411412.trips_data_all.green_tripdata`
  RENAME COLUMN pickup_location_id TO PULocationID;
ALTER TABLE `zoomcamp-de-411412.trips_data_all.green_tripdata`
  RENAME COLUMN dropoff_location_id TO DOLocationID;