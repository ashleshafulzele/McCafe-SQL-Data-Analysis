# McCafe-SQL-Data-Analysis
SQL-based data analysis project on McCafe sales, analyzing coffee consumers, revenue, product performance, city-wise trends, customer segmentation, monthly sales growth, and market potential using joins, aggregates, CTEs, and window functions in MySQL.

## Description  
A MySQL-based data analytics project that analyzes McCafe sales and customer data to derive business insights on coffee consumption, revenue, product performance, city-wise trends, customer segmentation, and market potential using SQL queries.

---

## Project Objective  
To use SQL for real-world business analysis by answering key questions related to sales, customers, and market potential of McCafe across different cities.

---

## Database Schema  

### Tables Used

1. city  
- city_id (Primary Key)  
- city_name  
- population  
- estimated_rent  
- city_rank  

2. products  
- product_id (Primary Key)  
- product_name  
- price  

3. customers  
- customer_id (Primary Key)  
- customer_name  
- city_id (Foreign Key referencing city.city_id)  

4. sales  
- sale_id (Primary Key)  
- sale_date  
- product_id (Foreign Key referencing products.product_id)  
- customer_id (Foreign Key referencing customers.customer_id)  
- total  
- rating  

---

## Business Questions Answered  

1. Coffee Consumers Count: Estimated coffee consumers (25 percent of population) per city  
2. Total Revenue from Coffee Sales in Q4 2023  
3. Units Sold per Coffee Product  
4. Average Sales per Customer in Each City  
5. City Population versus Coffee Consumers  
6. Top 3 Selling Products per City  
7. Unique Coffee Customers per City  
8. Average Sale versus Rent per Customer  
9. Monthly Sales Growth Rate  
10. Top 3 Cities by Market Potential  

All SQL queries for the above are included in Queries.sql.

---

## Tools and Technologies  
- MySQL  
- SQL (Joins, Aggregations, CTEs, Window Functions)  
- Git and GitHub  

---

## Key Insights and Recommendations  

- Focus marketing efforts on top 3 revenue-generating cities.  
- Promote best-selling coffee products through combo offers.  
- Introduce loyalty programs for frequent customers.  
- Target high-population but low-sales cities with discounts.  
- Use seasonal promotions when monthly sales growth declines.

---

## Repository Structure  

```

McCafe-SQL-Data-Analysis/
|
|-- McCafe_Database.sql
|-- Queries.sql
|-- README.md

```
