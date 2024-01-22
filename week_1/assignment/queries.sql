-- Question 3. Count records: 15612
SELECT COUNT(*) 
    FROM green_taxi_data 
    WHERE CAST(lpep_pickup_datetime AS date) = '2019-09-18'  
    AND CAST(lpep_dropoff_datetime AS date) = '2019-09-18';

-- Question 4. Largest trip for each day: 2019-09-26
SELECT lpep_pickup_datetime, trip_distance 
    FROM green_taxi_data 
    ORDER BY trip_distance DESC;

-- Question 5. Three biggest pickups: "Brooklyn" "Manhattan" "Queens"
SELECT "Borough", sum(total_amount) AS total 
    FROM green_taxi_data, taxi_zones
    WHERE "PULocationID" = taxi_zones."LocationID" AND lpep_pickup_datetime::date = '2019-09-18'
    GROUP BY "Borough" 
    HAVING SUM(total_amount) > 50000
    ORDER BY total DESC;

-- Question 6. Largest tip: JFK Airport
SELECT z1."Zone" AS pickup_zone, z2."Zone" AS dropoff_zone, tip_amount 
    FROM green_taxi_data INNER JOIN taxi_zones z1
    ON "PULocationID" = z1."LocationID"
    INNER JOIN taxi_zones z2
    ON "DOLocationID" = z2."LocationID"
    WHERE z1."Zone" = 'Astoria'
    ORDER BY tip_amount DESC;
