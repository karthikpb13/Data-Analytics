create database london_housing;

use london_housing;

CREATE TABLE house_data (
    date DATE,
    area VARCHAR(50),
    average_price INT,
    code VARCHAR(20),
    houses_sold FLOAT,
    no_of_crimes FLOAT,
    year INT
);

select * from house_data;

-- Calculate total no. of houses sold per area

select area,sum(houses_sold) as total_houses_sold
from house_data
group by area;

-- Find the average house price by area 

select area, avg(average_price) as avg_house_price
from house_data
group by area;

-- Find the Yearly Trend of House Prices  

select area,year, avg(average_price) as avg_house_price
from house_data
group by year, area
order by year;


-- Find Areas with the Highest Crime Rates

select area, sum(no_of_crimes) as total_crimes
from house_data
group by area
order by total_crimes desc
limit 10;

-- What are the yearly trends in average house prices across different areas of London?
-- Which area has shown the highest increase in average house prices over the last decade?
-- What are the areas with the highest increase in the average price 

select year, area , avg(average_price) as avg_price
from house_data
group by year,area
order by year, area;

WITH price_trends AS (
    SELECT 
        area, 
        year, 
        AVG(average_price) AS avg_house_price
    FROM 
        house_data
    GROUP BY 
        year, area
)
SELECT 
    area, 
    MAX(avg_house_price) AS max_price, 
    MIN(avg_house_price) AS min_price,
    MAX(avg_house_price) - MIN(avg_house_price) AS price_increase
FROM 
    price_trends
GROUP BY 
    area
ORDER BY 
    price_increase DESC
LIMIT 10;

