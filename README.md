# GoodCabs

##### __Domain__:  Transportation & Mobility          
##### __Function__: Operations 



## Understanding the Business Persona
__*Goodcabs*__, a cab service company established two years ago, has gained a strong foothold in the Indian market by focusing on tier-2 cities. Unlike other cab service providers, Goodcabs is committed to supporting local drivers, helping them make a sustainable living in their hometowns while ensuring excellent service to passengers. With operations in ten tier-2 cities across India, Goodcabs has set ambitious performance targets for 2024 to drive growth and improve passenger satisfaction. 

As part of this initiative, the Goodcabs management team aims to assess the company’s performance across key metrics, including trip volume, passenger satisfaction, repeat passenger rate, trip distribution, and the balance between new and repeat passengers. 


## Project Goals

The analysis is centered around growing trip volumes, passenger satisfaction, and repeat bookings for Goodcabs. Through the determination of important trends and operational optimization, overall performance is aimed to be enhanced. These findings will assist Goodcabs in reaching its customer retention and growth goals.



## Database Schema
![](https://github.com/Shandeep-Raula/GoodCabs/blob/main/ERD.png)



## Identify the Key Performance Indicators __*(KPI’s)*__

| **Metric**                           | **Description**                                                                                 | **Formula**                                                                                         |
|--------------------------------------|-------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------|
| **Total Trips**                      | Total number of trips completed.                                                                | `Count(trip_id)`                                                                                |
| **Total Fare (Revenue)**             | Total revenue generated from all trips.                                                         | `Sum(fare_maount)`                                                                             |
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




## Tools
- Python (Numpy , Pandas , SQLalchemy , Matplotlib , Seaborn)
- SQL (PostgreSQL)
- Power BI
- VS Code & Jupyter Notebook



## Insights Deep-Dive 
### Top and Bottom Performing Cities
- Jaipur (76,888), Lucknow (64,299), and Surat (54,843) are the top-performing cities, with Jaipur leading significantly.
- Mysore (16,238), Coimbatore (21,104), and Visakhapatnam (28,366) are the bottom performers, with Mysore having the least trips; focused marketing and service improvements could help boost their performance.
- There's a large gap between top and bottom cities (~60,238 trips)
  
![Top and Bottom Performing Cities](https://github.com/Shandeep-Raula/GoodCabs--Provide-Insights-to-Chief-Operations-in-Transportation-Domain/blob/main/Fig/Top%20%26%20Bottom.png)

### Repeat Passenger Frequency and City Contribution Analysis
- Cities like Visakhapatnam (51.25%), Jaipur (50.14%), Mysore (48.75%), and Kochi (47.67%) have the highest percentage of passengers returning for a second trip, showing strong customer retention after the first ride.
- Across all cities, the repeat passenger percentage drops significantly as the number of trips increases (especially after 3–4 trips), indicating a challenge in maintaining long-term customer loyalty.
- Lucknow and Surat have low initial repeat rates (~9-10%).
  
 ![City & Trip Count](https://github.com/Shandeep-Raula/GoodCabs--Provide-Insights-to-Chief-Operations-in-Transportation-Domain/blob/main/Fig/City%20%26%20Trip%20Count.png) 

### Average Ratings by City and Passenger Type
- New passengers rate higher than repeated ones in all cities.
- Jaipur, Kochi, Mysore, Visakhapatnam have the highest satisfaction (9.0/8.0).
- Lucknow, Surat, Vadodara have the lowest repeated ratings (6.0).
  
![](https://github.com/Shandeep-Raula/GoodCabs--Provide-Insights-to-Chief-Operations-in-Transportation-Domain/blob/main/Fig/Average%20Rating%20by%20City%20and%20Passenger%20type.png)
 
## Secondary Insights 

This project dives into key factors influencing repeat passenger rates, tourism vs. business demand, emerging mobility trends, partnership opportunities, and data-driven decision-making for **Goodcabs'** growth strategy.



### Factors Influencing Repeat Passenger Rates

- **Service Quality**: Higher repeat rates correlate with better passenger ratings.
- **Competitive Pricing**: Cities with price-sensitive demographics respond positively to attractive pricing models.
- **Socioeconomic Factors**:
  - High-income cities prefer premium services.
  - Lower-income cities favor cost-effective rides.
- **Lifestyle Patterns**:
  - IT hubs and professional cities show consistent weekday repeat usage.



### Tourism vs. Business Demand Impact

- **Data Sources**: 6 months of trip data cross-referenced with event calendars (festivals, conferences, tourism seasons).
- **Tourism Cities** (e.g., Jaipur, Kochi): 
  - Demand spikes during festive seasons and holidays.
- **Business Cities** (e.g., Lucknow, Surat): 
  - Consistent weekday demand from corporate users.



### Emerging Mobility Trends and Goodcabs' Adaptation

- **EV Adoption**: Growing passenger preference for electric vehicles, especially in tier-2 cities.
- **Sustainability Focus**: Eco-conscious users show interest in ride-sharing and green energy options.
- **Opportunity**:
  - EV integration can reduce operational costs.
  - Boosts brand loyalty through sustainable offerings.



### Partnership Opportunities with Local Businesses

- **Trip Destination Analysis** reveals potential tie-ups with:
  - Hotels
  - Malls
  - Event venues
- **Strategy**: Offer special discounts for rides to events and popular destinations to increase repeat usage.



### Data Collection for Enhanced Decision-Making

- **Passenger Data**:
  - Ride frequency
  - Service feedback
  - Referral activity
- **Driver Data**:
  - Availability
  - Punctuality
  - Training status
- **Market Data**:
  - Competitor pricing
  - Service benchmarks per city
- **City-specific Events**:
  - Integration of local event calendars for proactive demand forecasting.














