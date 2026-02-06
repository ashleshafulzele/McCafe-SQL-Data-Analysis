
CREATE  DATABASE McCafe;
USE McCafe;

CREATE TABLE city
(
	city_id	INT PRIMARY KEY,
	city_name VARCHAR(15),	
	population	BIGINT,
	estimated_rent	FLOAT,
	city_rank INT
);

CREATE TABLE products
(
	product_id	INT PRIMARY KEY,
	product_name VARCHAR(35),	
	Price float
);

CREATE TABLE customers
(
	customer_id INT PRIMARY KEY,	
	customer_name VARCHAR(25),	
	city_id INT,
	CONSTRAINT fk_city FOREIGN KEY (city_id) REFERENCES city(city_id)
);

CREATE TABLE sales
(
	sale_id	INT PRIMARY KEY,
	sale_date	date,
	product_id	INT,
	customer_id	INT,
	total FLOAT,
	rating INT,
	CONSTRAINT fk_products FOREIGN KEY (product_id) REFERENCES products(product_id),
	CONSTRAINT fk_customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 
);

SELECT * FROM city;
SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM sales;


-- Reports & Data Analysis

-- Q.1 Coffee Consumers Count
-- How many people in each city are estimated to consume coffee, given that 25% of the population does?
SELECT city_name, 
population, (population * 0.25) As  estimated_coffee_consumers
FROM city;

-- Q.2 Total Revenue from Coffee Sales
-- What is the total revenue generated from coffee sales across all cities in the last quarter of 2023?

SELECT 
SUM(s.total) AS total_revenue_Q4_2023
FROM sales s
JOIN products p 
ON s.product_id = p.product_id
WHERE 
p.product_name LIKE '%Coffee%' 
AND s.sale_date BETWEEN '2023-10-01' AND '2023-12-31';

-- Q.3 Sales Count for Each Product
-- How many units of each coffee product have been sold?

SELECT 
p.product_name,
COUNT(s.sale_id) AS units_sold
FROM sales s
JOIN products p 
ON s.product_id = p.product_id
WHERE p.product_name LIKE '%Coffee%'
GROUP BY p.product_name
ORDER BY units_sold DESC;

-- Q.4 Average Sales Amount per City
-- What is the average sales amount per customer in each city?

SELECT 
c.city_name,
AVG(s.total) AS avg_sales_per_customer
FROM sales s
JOIN customers cu ON s.customer_id = cu.customer_id
JOIN city c ON cu.city_id = c.city_id
GROUP BY c.city_name;

-- Q.5  City Population and Coffee Consumers
-- Provide a list of cities along with their populations and estimated coffee consumers.

SELECT 
city_name,
population,
(population * 0.25) AS estimated_coffee_consumers
FROM city;

-- Q.6  Top Selling Products by City
-- What are the top 3 selling products in each city based on sales volume?

SELECT city_name, product_name, total_sales
FROM (
SELECT 
c.city_name,
p.product_name,
COUNT(s.sale_id) AS total_sales,
ROW_NUMBER() OVER (PARTITION BY c.city_name ORDER BY COUNT(s.sale_id) DESC) AS rn
FROM sales s
JOIN products p ON s.product_id = p.product_id
JOIN customers cu ON s.customer_id = cu.customer_id
JOIN city c ON cu.city_id = c.city_id
GROUP BY c.city_name, p.product_name
) t
WHERE rn <= 3;

-- Q.7 Customer Segmentation by City
-- How many unique customers are there in each city who have purchased coffee products?

SELECT 
c.city_name,
COUNT(DISTINCT cu.customer_id) AS unique_coffee_customers
FROM sales s
JOIN products p ON s.product_id = p.product_id
JOIN customers cu ON s.customer_id = cu.customer_id
JOIN city c ON cu.city_id = c.city_id
WHERE p.product_name LIKE '%Coffee%'
GROUP BY c.city_name;

-- Q.8 Average Sale vs Rent
-- Find each city and their average sale per customer and avg rent per customer

SELECT 
c.city_name,
AVG(s.total) AS avg_sale_per_customer,
(c.estimated_rent) AS avg_rent_per_customer
FROM sales s
JOIN customers cu ON s.customer_id = cu.customer_id
JOIN city c ON cu.city_id = c.city_id
GROUP BY c.city_name, c.estimated_rent;

-- Q.9 Monthly Sales Growth
-- Sales growth rate: Calculate the percentage growth (or decline) in sales over different time periods (monthly).

WITH monthly_sales AS (
SELECT 
DATE_FORMAT(sale_date, '%Y-%m') AS sale_month,
SUM(total) AS monthly_revenue
FROM sales
GROUP BY sale_month
)
SELECT 
sale_month,
monthly_revenue,
LAG(monthly_revenue) OVER (ORDER BY sale_month) AS prev_month_revenue,
((monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY sale_month)) 
/ LAG(monthly_revenue) OVER (ORDER BY sale_month)) * 100 AS growth_rate_percent
FROM monthly_sales;

-- Q.10 Market Potential Analysis
-- Identify top 3 city based on highest sales, return city name, total sale, total rent, total customers, estimated coffee consumer

SELECT 
c.city_name,
SUM(s.total) AS total_sales,
SUM(c.estimated_rent) AS total_rent,
COUNT(DISTINCT cu.customer_id) AS total_customers,
(c.population * 0.25) AS estimated_coffee_consumers
FROM sales s
JOIN customers cu ON s.customer_id = cu.customer_id
JOIN city c ON cu.city_id = c.city_id
GROUP BY c.city_name, c.population
ORDER BY total_sales DESC
LIMIT 3;





























































































































































































































































