create database reatil_orders;

use retail_orders;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    ship_mode VARCHAR(50),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_id INT,
    quantity INT,
    discount DECIMAL(5, 2),
    sell_price DECIMAL(10, 2),
    profit DECIMAL(10, 2)
);

ALTER TABLE orders MODIFY COLUMN product_id VARCHAR(255);

select * from orders;

select * from orders
where product_id='FUR-BO-10001798';

-- Find top 10 highest revenue genrating products 

SELECT product_id, SUM(sell_price) AS sells
FROM orders
GROUP BY product_id
ORDER BY sells DESC
LIMIT 10;

-- Find top 5 highest selling product in each region

WITH ranked_sales AS (
    SELECT region, 
           product_id, 
           SUM(sell_price) AS sells,
           ROW_NUMBER() OVER (PARTITION BY region ORDER BY SUM(sell_price) DESC) AS `rank`
    FROM orders
    GROUP BY region, product_id
)
SELECT region, product_id, sells
FROM ranked_sales
WHERE `rank` <= 5
ORDER BY region, sells DESC;

-- Find month over month comparison for 2022 and 2023 sales eg : Jan 2022 vs Jan 2023 

SELECT 
    MONTH(order_date) AS month,
    SUM(CASE WHEN YEAR(order_date) = 2022 THEN sell_price ELSE 0 END) AS sales_2022,
    SUM(CASE WHEN YEAR(order_date) = 2023 THEN sell_price ELSE 0 END) AS sales_2023
FROM orders
WHERE YEAR(order_date) IN (2022, 2023)
GROUP BY MONTH(order_date)
ORDER BY month;

-- For each category which month had highest sales
SELECT 
    category, 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(sell_price) AS total_sales
FROM orders
GROUP BY category, YEAR(order_date), MONTH(order_date)
HAVING total_sales = (
    SELECT MAX(total_sales)
    FROM (
        SELECT 
            category, 
            YEAR(order_date) AS year,
            MONTH(order_date) AS month,
            SUM(sell_price) AS total_sales
        FROM orders
        GROUP BY category, YEAR(order_date), MONTH(order_date)
    ) AS sales_per_month
    WHERE sales_per_month.category = orders.category
)
ORDER BY category, year, month;


-- Which subcategory had highest growth by profit in 2023 compare to 2022
WITH profit_data AS (
    -- Calculate profit for each category by year (2022 and 2023)
    SELECT 
        category,  
        YEAR(order_date) AS year, 
        SUM(profit) AS total_profit
    FROM orders
    WHERE YEAR(order_date) IN (2022, 2023)
    GROUP BY category, YEAR(order_date)
)
SELECT 
    p2022.category, 
    p2022.total_profit AS profit_2022,
    p2023.total_profit AS profit_2023,
    ((p2023.total_profit - p2022.total_profit) / p2022.total_profit) * 100 AS profit_growth_percentage
FROM profit_data p2022
JOIN profit_data p2023 ON p2022.category = p2023.category
WHERE p2022.year = 2022 AND p2023.year = 2023
ORDER BY profit_growth_percentage DESC
LIMIT 1;


    
    
    
    
    