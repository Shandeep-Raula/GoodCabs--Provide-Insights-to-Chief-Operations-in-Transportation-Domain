# GoodCabs

##### __Domain__:  Transportation & Mobility          
##### __Function__: Operations 
</br>

## Understanding the Business Persona
__*Goodcabs*__, a cab service company established two years ago, has gained a strong foothold in the Indian market by focusing on tier-2 cities. Unlike other cab service providers, Goodcabs is committed to supporting local drivers, helping them make a sustainable living in their hometowns while ensuring excellent service to passengers. With operations in ten tier-2 cities across India, Goodcabs has set ambitious performance targets for 2024 to drive growth and improve passenger satisfaction. 

As part of this initiative, the Goodcabs management team aims to assess the company’s performance across key metrics, including trip volume, passenger satisfaction, repeat passenger rate, trip distribution, and the balance between new and repeat passengers. 

</br>



## Identify the Key Performance Indicators __*(KPI’s)*__

| **Metric**                           | **Description**                                                                                 | **Formula**                                                                                         |
|--------------------------------------|-------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------|
| **Total Trips**                      | Total number of trips completed.                                                                | `Count(trip_id)`                                                                                |
| **Total Fare (Revenue)**             | Total revenue generated from all trips.                                                         | `Sum of Fare`                                                                             |
| **Total Distance Travelled**         | Total distance covered across all trips (in km).                                                | `Sum of Distance Travelled`                                                                         |
| **Passenger Rating**                 | Average rating given by passengers.                                                             | `(Sum of passenger ratings) / (Total number of passenger ratings)`                                |
| **Driver Rating**                    | Average rating given by drivers.                                                                | `(Sum of driver ratings) / (Total number of driver ratings)`                                      |
| **Average Fare per Trip**            | Total revenue divided by the number of trips.                                                   | `Total Fare / Total Trips`                                                                        |
| **Average Fare per Km**              | Total revenue divided by the total distance traveled.                                           | `Total Fare / Total Distance Travelled`                                                           |
| **Average Trip Distance**            | Total distance divided by the number of trips.                                                  | `Total Distance Travelled / Total Trips`                                                          |
| **Trip Distance (Max, Min)**         | Maximum and minimum trip distances recorded.                                                    |  `MAX(Trip Distance)` and `MIN(Trip Distance)`                                                 |
| **New Trips**                        | Trips by passengers making their first booking.                                                 | `Count(passengers is new)`                                                                 |
| **Repeated Trips**                   | Trips by passengers who have booked more than once.                                             | `Count(passengers is repeated)`                                                             |
| **Total Passengers**                 | Total number of unique passengers.                                                              | `Sum of Total Passenger`                                                                           |
| **New Passengers**                   | Number of passengers making their first trip.                                                   | `Sum of Total New Passengers`                                                                      |
| **Repeat Passengers**                | Number of passengers who have booked multiple trips.                                            | `Sum of Total Reapeted Passenger`                                                                  |
| **New vs. Repeated Passenger Trips Ratio** | Ratio of trips made by new passengers to those made by repeat passengers.                 | `New Trips / Repeated Trips`                                                                      |
| **Repeat Passenger Rate (%)**        | Percentage of passengers who booked more than once.                                             | `(Repeat Passengers / Total Passengers) * 100`                                                    |
| **Revenue Growth Rate (Monthly)**    | Month-over-month percentage increase in total revenue.                                          | `((Revenue in Current Month - Revenue in Previous Month) / Revenue in Previous Month) * 100`     |
| **Target Achievement Rate**          | Measure of performance against predefined targets.                                              | `Actual Value / Target Value * 100`                                                               |
| **Trips Target**                     | Percentage of total trips completed against the set target.                                     | `(Total Trips / Trips Target) * 100`                                                              |
| **New Passenger Target**             | Percentage of new passengers acquired against the set target.                                   | `(New Passengers / New Passenger Target) * 100`                                                   |
| **Average Passenger Rating Target**  | Percentage of average passenger ratings achieved compared to the target rating.                 | `(Average Passenger Rating / Rating Target) * 100`                                                |


</br>

## ER Diagram
![](https://github.com/Shandeep-Raula/GoodCabs/blob/main/ERD.png)

## Tools
- Python (Pandas , SQLalchemy)
- SQL (PostgreSQL)
- Power BI
- VS Code & Jupyter Notebook















