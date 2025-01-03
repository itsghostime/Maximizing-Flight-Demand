# Global Flight Demand Analysis (2022)

**Analyzing Passenger Demographic and Flight Status trends from the months of 2022.** 


## Dashboard Preview

![image](https://github.com/user-attachments/assets/f2cce10b-eb1e-431d-aba5-0acb664c24bb) 


---
### North Star Metrics and Dimensions 
- Achieve an **85% on-time flight performance globally**, focusing on minimizing delays
- **Flight Volume**: Total flights per year (**98,619 flights**) across all continents.
- **Flight Status**:  Current status of the flight (e.g., on-time, delayed, canceled)
- **Country Name**: Name of the country the airport is located in

---

## Project Background

Operations in the airline industry, focusing on global passenger travel across major countries. With over 98,000 annual flights in 2022, the airline aims to provide seamless travel experiences while optimizing operational efficiency. The airline's business model revolves around analyzing trends in passenger behavior, improving on-time performance, and enhancing overall flight operations. Key metrics include passenger counts, flight delays, and seasonal travel trends. 

Insights and recommendations are provided on the following key areas:
- Passenger Demographics Analysis: Evaluation of passenger distribution across nationalities, age groups, and genders to understand key customer segments and their travel patterns.

- Flight Status Trends: Analysis of on-time performance, delays, and cancellations to identify operational efficiencies and areas requiring improvement.

- Seasonal and Regional Impacts: Examination of flight volumes and delays across different months, weekdays, and regions to highlight demand trends and operational bottlenecks.

SQL queries used to inspect the data and answer key business questions [here](Query_Airline.sql)

Interactive Tableau dashboard can be found [here](https://public.tableau.com/views/Airline-Project/Dashboard1?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link).


## Executive Summary
---
### Overview of Findings
In 2022, the airline industry demonstrated consistent travel demand, with over 98,000 flights and a clear preference for summer travel. Adults, particularly Chinese and Indonesian nationals, made up the majority of passengers, highlighting lucrative marketing opportunities in these demographics. However, operational challenges persist, as North America experiences the highest delays (60%), especially on weekdays, with peak disruptions occurring in January and July. While these values can be attributed to airlines recovering from the pandemic, the following sections will explore additional factors and strategies that can be improved upon to enhance operational efficiency and customer satisfaction.

## Insights Deep Dive

### Flight Volume Trends
- Summer recorded the highest flight volumes (25,123), while Winter saw a dip to 23,993 flights.
- A 3-month moving average revealed a stable upward trend, signaling growing confidence in air travel.
-The months of January, May, and August showed significant peaks in flight activity. January's spike was attributed to New Year travel, while May and August aligned with summer vacations.
(![image](https://github.com/user-attachments/assets/fe17b0cf-a4e5-461f-bc03-c3676f74fdfd)


### Passenger Demographics
- Adults made up 48% of all passengers, while minors are around 18.8%. Interestingly, seniors make up 33.2%, suggesting that a significant portion of travelers are older adults, possibly due to leisure travel or visiting family.
- The gender ratio was nearly equal, with 50.6% male and 49.4% female passengers.
- Chinese (18,317) and Indonesian (10,559) passengers are the dominant passenger nationality.
- Countries like the United States, Canada, and Australia were the top three most visited countries.

### Flight Delay Patterns
- North America experiences the highest delays (60%).
- Overall, Weekdays saw 71.4% of these delays, while weekends saw 28.6%
- While North America leads, Asia’s delay rate remains substantial accounting for 30% of its delays, especially in high-traffic countries like China and India.
- During Fall, weather disruptions and increased air traffic contributed to higher delay rates compared to other seasons.

### Seasonal Travel Insights
- With 25,123 flights, Summer outperformed all other seasons.
- Despite being the least busy season, Winter still recorded 23,993 flights. Offering travel incentives during this period, such as discounts on winter destinations, could help increase seat occupancy and improve overall efficiency.
- North America’s seasonal demand aligns with traditional holidays, while Asian markets show year-round travel due to business and leisure travel overlaps.

## Recommendations: 
Based on the insights above, we recommend businesses to consider:

1. Continue optimizing fleet utilization and staffing levels during the summer months. Additionally, introducing premium pricing strategies for peak travel days could maximize profitability while maintaining demand.
  
2. Design tailored marketing campaigns focused on frequent travelers to Western countries like the United States and Australia. For example, airlines can offer loyalty programs for these regions and give bonuses to those who fly during a specific season of the year.
  
3. Reduce Delays by increasing workforce allocation and ground support during weekday peak hours in North American airports. Partnering with local air traffic control to optimize scheduling and reduce congestion will also be critical.
   
4. Introduce discounted fares and bundle deals (e.g., flight + hotel) for winter travel to encourage bookings. Highlight winter destinations and experiences through seasonal advertising campaigns.
   
5. Reallocating resources to delay-prone seasons like Fall to plan for disruptions and adjust schedules accordingly.

## Caveats:
Throughout this analysis, multiple assumptions and caveats were made to combat the challenges within the data. They are noted below:

- Data Completeness: Assumes no missing records for flight counts or delays.
- Passenger Nationality: Passengers with missing nationality data were excluded.
- Seasonal Delays: Assumes consistent definitions of seasons across all regions.
- Limited Data of 2022: The analysis is based solely on flight and passenger data from 2022. Therefore, some insights may vary in subsequent years.
- Passenger-Centric Approach Instead of Sales: Due to the absence of sales data in the dataset, the analysis pivoted to a passenger-centric approach, focusing on demographics, travel volume, and delay patterns.



