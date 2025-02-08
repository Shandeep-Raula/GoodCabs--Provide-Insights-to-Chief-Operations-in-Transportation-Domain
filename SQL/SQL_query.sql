
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


-----------------------------------------------------------------------------------------------


-- 4. Peak and Low Demand Months by City 
-- For each city, identify the month with the highest total trips (peak demand)
-- and the month with the lowest total trips (low demand). This analysis will help 
-- Goodcabs understand seasonal patterns and adjust resources accordingly.

WITH monthly_trip AS (	
    SELECT 
        c.city_name AS city,
        EXTRACT(MONTH FROM f.date) AS month,
        TO_CHAR(f.date, 'Month') AS month_name, 
        COUNT(f.trip_id) AS total_trips
    FROM dim_city c
    JOIN fact_trips f ON c.city_id = f.city_id
    GROUP BY city, month, month_name
),
city_rank AS (
    SELECT  
        city,
        month,
        month_name,
        total_trips,
        RANK() OVER (PARTITION BY city ORDER BY total_trips DESC) AS rank		
    FROM monthly_trip 
)
SELECT city,
		MAX(CASE WHEN rank = 1 THEN month_name END) AS Highest_Demand,
		MAX(CASE WHEN rank = 6 THEN month_name END) AS Lowest_Demand
FROM city_rank 
GROUP BY city;


-----------------------------------------------------------------------------------------------


-- 5. Weekend vs. Weekday Trip Demand by City 
-- Compare the total trips taken on weekdays versus weekends for each city over
-- the six-month period. Identify cities with a strong preference for either weekend
-- or weekday trips to understand demand variations.

WITH day_type AS (	
    SELECT 
        c.city_name AS city,
         d.day_type AS day_type,
        COUNT(f.trip_id) AS total_trips
    FROM dim_city c
    JOIN fact_trips f ON c.city_id = f.city_id
	JOIN dim_date d ON f.date = d.date
    GROUP BY city, day_type
	),
day_type_col AS(
		SELECT 
				city,
				SUM(CASE WHEN day_type='Weekday' THEN total_trips ELSE 0 END) AS weekday,
				SUM(CASE WHEN day_type='Weekend' THEN total_trips ELSE 0 END) AS weekend
		FROM day_type
		GROUP BY city
       			)
SELECT city,
	   weekday,
	   weekend,
	   CASE WHEN weekday > weekend THEN 'weekday'
	   		WHEN weekend > weekday THEN 'weekend'
			ELSE 'equal'
		END AS preference
FROM day_type_col


-----------------------------------------------------------------------------------------------


-- 6. Repeat Passenger Frequency and City Contribution Analysis 
--  Analyse the frequency of trips taken by repeat passengers in each city 
-- (e.g., % of repeat passengers taking 2 trips, 3 trips, etc.). Identify which
-- cities contribute most to higher trip frequencies among repeat passengers, 
-- and examine if there are distinguishable patterns between tourism-focused and
-- business-focused cities.

WITH rep_pass AS (
    SELECT 
        c.city_name AS city,
        d.trip_count AS total_trip,
        SUM(d.repeat_passenger_count) AS repeat_passenger
    FROM dim_repeat_trip_distribution d
    JOIN dim_city c ON d.city_id = c.city_id
    GROUP BY c.city_name, d.trip_count
),
total_pass AS (
    SELECT 
        city, 
        total_trip, 
        repeat_passenger,
        SUM(repeat_passenger) OVER(PARTITION BY city) AS total
    FROM rep_pass
)
SELECT 
    city,
    ROUND(SUM(CASE WHEN total_trip = '2-Trips' THEN repeat_passenger * 100.0 / total END), 2) AS "2-Trips",
	ROUND(SUM(CASE WHEN total_trip = '3-Trips' THEN repeat_passenger * 100.0 / total END), 2) AS "3-Trips",
	ROUND(SUM(CASE WHEN total_trip = '4-Trips' THEN repeat_passenger * 100.0 / total END), 2) AS "4-Trips",
	ROUND(SUM(CASE WHEN total_trip = '5-Trips' THEN repeat_passenger * 100.0 / total END), 2) AS "5-Trips",
	ROUND(SUM(CASE WHEN total_trip = '6-Trips' THEN repeat_passenger * 100.0 / total END), 2) AS "6-Trips",
	ROUND(SUM(CASE WHEN total_trip = '7-Trips' THEN repeat_passenger * 100.0 / total END), 2) AS "7-Trips",
	ROUND(SUM(CASE WHEN total_trip = '8-Trips' THEN repeat_passenger * 100.0 / total END), 2) AS "8-Trips",
	ROUND(SUM(CASE WHEN total_trip = '9-Trips' THEN repeat_passenger * 100.0 / total END), 2) AS "9-Trips",
	ROUND(SUM(CASE WHEN total_trip = '9-Trips' THEN repeat_passenger * 100.0 / total END), 2) AS "10-Trips"
FROM total_pass
GROUP BY city;


-----------------------------------------------------------------------------------------------


-- 7. Monthly Target Achievement Analysis for Key Metrics 
-- For each city, evaluate monthly performance against targets for total trips,
-- new passengers, and average passenger ratings from targets_db. Determine 
-- if each metric met, exceeded, or missed the target, and calculate the percentage 
-- difference. Identify any consistent patterns in target achievement, particularly 
-- across tourism versus business-focused cities.


WITH passengers AS (
    SELECT 
        city_id, 
        EXTRACT(MONTH FROM month) AS months,
        SUM(new_passengers) AS actual_new_passengers
    FROM fact_passenger_summary
    GROUP BY city_id, months
),
trips AS (
    SELECT  
        t.city_id AS city_id,
        EXTRACT(MONTH FROM t.date) AS months,
        COUNT(t.trip_id) AS actual_trips,
        ROUND(AVG(t.passenger_rating)::NUMERIC, 2) AS actual_avg_passenger_rating
    FROM fact_trips t
    GROUP BY city_id, months
), 
total_trips AS (
    SELECT 
        t.city_id, 
        t.months,
        t.actual_trips,
        t.actual_avg_passenger_rating,
        p.actual_new_passengers
    FROM trips t
    JOIN passengers p ON t.city_id = p.city_id
        AND t.months = p.months
),
actual_trips AS (
    SELECT  
        t.city_id,
        c.city_name AS city_name,
        t.months,
        t.actual_trips,
        t.actual_new_passengers,
        t.actual_avg_passenger_rating
    FROM total_trips t
    JOIN dim_city c ON t.city_id = c.city_id
),
target AS (
    SELECT 
        t.city_id AS city_id,
        EXTRACT(MONTH FROM t.month) AS months,
        t.total_target_trips AS total_target_trips,
        p.target_new_passengers AS target_new_passengers
    FROM monthly_target_trips t
    JOIN monthly_target_new_passengers p ON t.city_id = p.city_id
        AND t.month = p.month
),
target_trips AS (
    SELECT 
        t.city_id,
        t.months,
        t.total_target_trips,
        t.target_new_passengers,
        r.target_avg_passenger_rating AS target_avg_passenger_rating
    FROM target t
    JOIN city_target_passenger_rating r ON t.city_id = r.city_id
),
comparison AS (
    SELECT  
        t.city_id,
        c.city_name AS city_name,
        t.months,
        t.total_target_trips,
        total.actual_trips,
        ROUND(((total.actual_trips - t.total_target_trips) * 100.0 / NULLIF(t.total_target_trips, 0))::NUMERIC, 2) AS trip_percent_diff,
        CASE 
            WHEN total.actual_trips >= t.total_target_trips THEN 'Met/Exceeded'
            ELSE 'Missed'
        END AS trip_target_status,
        t.target_new_passengers,
        total.actual_new_passengers,
        ROUND(((total.actual_new_passengers - t.target_new_passengers) * 100.0 / NULLIF(t.target_new_passengers, 0))::NUMERIC, 2) AS passenger_percent_diff,
        CASE 
            WHEN total.actual_new_passengers >= t.target_new_passengers THEN 'Met/Exceeded'
            ELSE 'Missed'
        END AS passenger_target_status,
        t.target_avg_passenger_rating,
        total.actual_avg_passenger_rating,
        ROUND(((total.actual_avg_passenger_rating - t.target_avg_passenger_rating) * 100.0 / NULLIF(t.target_avg_passenger_rating, 0))::NUMERIC, 2) AS rating_percent_diff,
        CASE 
            WHEN total.actual_avg_passenger_rating >= t.target_avg_passenger_rating THEN 'Met/Exceeded'
            ELSE 'Missed'
        END AS rating_target_status
    FROM target_trips t
    JOIN total_trips total 
        ON t.city_id = total.city_id AND t.months = total.months
    JOIN dim_city c 
        ON t.city_id = c.city_id
)

SELECT 
    city_name,
    months,
    total_target_trips,
    actual_trips,
    trip_percent_diff AS "Trip_%_Diff",
    trip_target_status,
    target_new_passengers,
    actual_new_passengers,
    passenger_percent_diff AS "Passenger_%_Diff",
    passenger_target_status,
    target_avg_passenger_rating,
    actual_avg_passenger_rating,
    rating_percent_diff AS "Rating_%_Diff",
    rating_target_status
FROM comparison;


-----------------------------------------------------------------------------------------------


-- 8. Highest and Lowest Repeat Passenger Rate (RPR%) by City and Month 
-- • Analyse the Repeat Passenger Rate (RPR%) for each city across the 
-- six-month period. Identify the top 2 and bottom 2 cities based on 
-- their RPR% to determine which locations have the strongest and weakest rates. 
-- • Similarly, analyse the RPR% by month across all cities and identify the 
-- months with the highest and lowest repeat passenger rates. This will help to 
-- pinpoint any seasonal patterns or months with higher repeat passenger loyalty.


