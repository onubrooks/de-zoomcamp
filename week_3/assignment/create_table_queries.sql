CREATE EXTERNAL TABLE `zoomcamp-de-411412.green_2022.external`
    -- WITH PARTITION COLUMNS
    OPTIONS (
        format = 'PARQUET',
        uris = ['gs://mage-zoomcamp-onubrooks/green_2022/*']
    );

CREATE TABLE `zoomcamp-de-411412.green_2022.materialized` AS 
SELECT * FROM `zoomcamp-de-411412.green_2022.external`;

-- Question 1
SELECT COUNT(*) FROM `zoomcamp-de-411412.green_2022.external`; -- 840,402

-- Question 2
SELECT COUNT(DISTINCT PULocationID) FROM `zoomcamp-de-411412.green_2022.external`; -- 0B
SELECT COUNT(DISTINCT PULocationID) FROM `zoomcamp-de-411412.green_2022.materialized`; -- 6.41MB

-- Question 3
SELECT COUNT(*) FROM `zoomcamp-de-411412.green_2022.external` WHERE fare_amount = 0; -- 1622

-- Question 4
CREATE TABLE `zoomcamp-de-411412.green_2022.partitioned_clustered`
  PARTITION BY DATE(lpep_pickup_datetime)
  CLUSTER BY PULocationID 
  AS SELECT * FROM `zoomcamp-de-411412.green_2022.external`; -- Partition by lpep_pickup_datetime Cluster on PUlocationID

-- Question 5
SELECT DISTINCT PULocationID FROM `zoomcamp-de-411412.green_2022.materialized`
  WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30'; -- 12.82MB
SELECT DISTINCT PULocationID FROM `zoomcamp-de-411412.green_2022.partitioned_clustered`
  WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30'; -- 1.12MB
