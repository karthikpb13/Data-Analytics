create database Census_2011;

use Census_2011;

CREATE TABLE census (
    District_code INT PRIMARY KEY,
    State_name VARCHAR(60),
    District_name VARCHAR(60),
    Population INT,
    Male INT,
    Female INT,
    Literate INT,
    Workers INT,
    Male_Workers INT,
    Female_Workers INT,
    Cultivator_Workers INT,
    Agricultural_Workers INT,
    Household_Workers INT,
    Hindus INT,
    Muslims INT,
    Christians INT,
    Sikhs INT,
    Buddhists INT,
    Jains INT,
    Secondary_Education INT,
    Higher_Education INT,
    Graduate_Education INT,
    Age_Group_0_29 INT,
    Age_Group_30_49 INT,
    Age_Group_50 INT
);

select * from census;

-- Finding Districts with Highest population and Lowest Population 

SELECT State_name, District_name, Population 
FROM census
ORDER BY Population DESC 
LIMIT 10;

SELECT State_name, District_name, Population 
FROM census 
ORDER BY Population asc 
LIMIT 10;

-- Finding State with Highest population

SELECT State_name, SUM(Population) AS Total_Population
FROM census
GROUP BY State_name
ORDER BY Total_Population DESC;

-- Finding Gender Ratio of Each State 

select State_name, sum(Male) / sum(Female) * 1000 as Gender_ratio
from census
group by State_name
order by Gender_ratio;  -- It Shows Males per 1000 Females 

select State_name, sum(Female) / sum(Male) * 1000 as Gender_ratio
from census
group by State_name
order by Gender_ratio;  -- It Shows Females per 1000 Males

-- Finding Literacy Rate 

select State_name, sum(Literate) / sum(Population) * 100 as Literacy_Rate
from census
group by State_name
order by Literacy_Rate desc;

-- Finding States with Highest Secondory and higher Education

select State_name,
		(sum(Secondary_Education) / sum(Population) )* 100 as Secondary_Education_Rate,
        (sum(Higher_Education) / sum(Population)) * 100 as Higher_Education_Rate
from census
group by State_name
order by Secondary_Education_Rate desc, Higher_Education_Rate desc;

-- Finding States with Highest Rates of Working Women 

select State_name, 
	(sum(Female_Workers) / sum(Female)) * 100 as Working_Women_Rate
from census
group by State_name
order by Working_Women_Rate desc;

-- Finding Trends in Cultivators v/s Agricultural Workers 

select State_name,
	sum(Cultivator_Workers) as Cultivators,
    sum(Agricultural_Workers) as Agricultural_Workers
from census
group by State_name
order by State_name;


-- Taking Insights into Relegious Based population

SELECT State_name,
       SUM(Hindus) / SUM(Population) * 100 AS Hindu_Percentage,
       SUM(Muslims) / SUM(Population) * 100 AS Muslim_Percentage,
       SUM(Christians) / SUM(Population) * 100 AS Christian_Percentage,
       SUM(Sikhs) / SUM(Population) * 100 AS Sikh_Percentage,
       SUM(Buddhists) / SUM(Population) * 100 AS Buddhist_Percentage,
       SUM(Jains) / SUM(Population) * 100 AS Jain_Percentage
FROM census
GROUP BY State_name
ORDER BY State_name;

select * from census;

PRAGMA table_info(your_table_name);


