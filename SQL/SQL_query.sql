
-- 1. Top and Bottom Performing Cities
-- Identify the Top 3 and Bottom 3 cities by total trips over the entire analysis period

--Top 3

SELECT 
		dc.city_name AS City,
		COUNT(ft.trip_id) AS Total_Trip
FROM fact_trips ft
JOIN dim_city dc ON ft.city_id = dc.city_id
GROUP BY dc.city_name
ORDER BY Total_Trip DESC
LIMIT 3;


-- Bottom 3

SELECT 
		dc.city_name AS City,
		COUNT(ft.trip_id) AS Total_Trip
FROM fact_trips ft
JOIN dim_city dc ON ft.city_id = dc.city_id
GROUP BY dc.city_name
ORDER BY Total_Trip 
LIMIT 3;


-----------------------------------------------------------------------------------------------

-- 2. Average Fare per Trip by City
-- Calculate the average fare per trip for each city and compare it with the city's 
-- average trip distance. Identify the cities with the highest and lowest average fare 
-- per trip to assess pricing efficiency across locations.

WITH City_Avg AS (
    SELECT 
        dc.city_name AS City,
        ROUND(AVG(ft.fare_amount), 2) AS AVG_fare_amount,
        CONCAT(ROUND(AVG(ft.distance_travelled_km), 2), 'KM') AS AVG_Distance
    FROM fact_trips ft
    JOIN dim_city dc ON ft.city_id = dc.city_id
    GROUP BY dc.city_name
),
City_Ranking AS (
    SELECT 
        City,
        AVG_fare_amount,
        AVG_Distance,
        RANK() OVER (ORDER BY AVG_fare_amount DESC) AS High_Rank,
        RANK() OVER (ORDER BY AVG_fare_amount ASC) AS Low_Rank
    FROM City_Avg
)
SELECT 
    City,
    AVG_fare_amount,
    AVG_Distance,
    CASE 
        WHEN High_Rank = 1 THEN 'Highest'
        WHEN Low_Rank = 1 THEN 'Lowest'
    END AS Status
FROM City_Ranking
WHERE High_Rank = 1 OR Low_Rank = 1
ORDER BY AVG_fare_amount DESC;


-----------------------------------------------------------------------------------------------

-- 3. Average Ratings by City and Passenger Type
-- Calculate the average passenger and driver ratings for each city, 
-- segmented by passenger type (new vs. repeat). Identify cities with 
-- the highest and lowest average ratings.

WITH Avg_Rating AS 
	(SELECT 
			dc.city_name AS City,
			ft.passenger_type AS Passenger_type,
			ROUND(AVG(ft.passenger_rating),2) AS Avg_passenger_rating,
			ROUND(AVG(ft.driver_rating),2) AS Avg_driver_rating
	FROM fact_trips ft
	JOIN dim_city dc ON ft.city_id = dc.city_id
	GROUP BY City, Passenger_type
	),

Rating_ranking AS
	(SELECT 
			City,
			Passenger_type,
			Avg_passenger_rating,
			Avg_driver_rating,
			RANK() OVER (ORDER BY Avg_passenger_rating DESC) AS High_Rank,
			RANK() OVER (ORDER BY Avg_passenger_rating ASC) AS Low_Rank
	FROM Avg_Rating )

SELECT 
    City,
	Passenger_type,
    Avg_passenger_rating,
    Avg_driver_rating,
    CASE 
        WHEN High_Rank = 1 THEN 'Highest'
        WHEN Low_Rank = 1 THEN 'Lowest'
    END AS Status
FROM Rating_ranking
WHERE High_Rank = 1 OR Low_Rank = 1
ORDER BY City, Avg_passenger_rating DESC;

