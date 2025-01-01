

SELECT 
		dc.city_name AS City,
		COUNT(trip_id) AS Total_Trip
FROM fact_trips ft
JOIN dim_city dc ON ft.city_id = dc.city_id
GROUP BY dc.city_name
ORDER BY Total_Trip DESC
LIMIT 3;



SELECT 
		dc.city_name AS City,
		COUNT(trip_id) AS Total_Trip
FROM fact_trips ft
JOIN dim_city dc ON ft.city_id = dc.city_id
GROUP BY dc.city_name
ORDER BY Total_Trip 
LIMIT 3;