-- Let's create a new clean table after data cleaning to perform Exploratory Date Analysid (EDA)

CREATE TABLE ecommerce_sales_analytics_clean LIKE 
ecommerce_sales_analytics_staging;

INSERT INTO ecommerce_sales_analytics_clean 
SELECT *
FROM
ecommerce_sales_analytics_staging;

-- After we create a new clean table le'ts drop the staging table

DROP TABLE 
ecommerce_sales_analytics_staging;

 -- SQL Project - Exploratory Data Analysis (EDA)
 -- 1. How many orders are there ?
 
SELECT COUNT(order_id) AS total_orders
FROM 
ecommerce_sales_analytics_clean;
 
 -- 2. How many unique customers are there ?
 
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM
ecommerce_sales_analytics_clean;
 
-- 3. What is the total revenue ?

SELECT SUM(revenue) AS total_revenue
FROM 
ecommerce_sales_analytics_clean;
 
 -- 4. What is the average revenue per order ?
 
SELECT AVG(revenue) AS average_revenue
FROM
ecommerce_sales_analytics_clean;

-- 5. what is the highest revenue ?

SELECT MAX(revenue) AS highest_revenue
FROM 
ecommerce_sales_analytics_clean;

-- 6. What is the lowest revenue ?

SELECT MIN(revenue) AS lowest_revenue
FROM 
ecommerce_sales_analytics_clean;

-- 7. Which product category generated the highest revenue ?

SELECT ROUND(SUM(revenue), 2) AS total_revenue, 
       product_category
FROM
ecommerce_sales_analytics_clean
GROUP BY product_category
ORDER BY total_revenue DESC
LIMIT 1;

-- 8. Which region generated the highest revenue ?
 SELECT ROUND(SUM(revenue), 2) AS total_revenue, 
        region
FROM
ecommerce_sales_analytics_clean
GROUP BY region
ORDER BY total_revenue DESC
LIMIT 1;

-- 9. Which payment method is used the most ?

SELECT ROUND(SUM(revenue), 2)  AS total_revenue, 
       payment_method
FROM
ecommerce_sales_analytics_clean
GROUP BY payment_method
ORDER BY total_revenue DESC
LIMIT 1;

-- 10. Which product category has the highest average customer rating ?

SELECT ROUND(AVG(customer_rating), 2) AS average_customer_rating, 
       product_category
FROM
ecommerce_sales_analytics_clean
GROUP BY product_category
ORDER BY average_customer_rating DESC
LIMIT 1;

-- 11. Which region has the highest average delivery days ?

SELECT ROUND(AVG(delivery_days), 2) AS average_delivery_days, 
       region
FROM
ecommerce_sales_analytics_clean
GROUP BY region
ORDER BY average_delivery_days DESC
LIMIT 1;

-- 12. Which customer placed the most orders ?

SELECT SUM(order_id) AS orders, 
	   customer_id AS customer
FROM
ecommerce_sales_analytics_clean
GROUP BY customer
ORDER BY orders DESC
LIMIT 1;

-- 13. Which customer generated the highest reveue ?

SELECT ROUND(SUM(revenue), 2) AS highest_revenue, 
	   customer_id AS customer
FROM
ecommerce_sales_analytics_clean
GROUP BY customer
ORDER BY highest_revenue DESC
LIMIT 1;

-- 14. What is the average discount for each product category ?

SELECT ROUND(AVG(discount), 3) AS average_discount, 
       product_category
FROM
ecommerce_sales_analytics_clean
GROUP BY product_category
ORDER BY average_discount DESC;

-- 15. Which product category sold the highest quantity ?

SELECT SUM(quantity) AS highest_quantity, 
       product_category
FROM 
ecommerce_sales_analytics_clean
GROUP BY product_category
ORDER BY highest_quantity DESC
LIMIT 1;

-- 16. What is the monthly revenue trend ?
-- Calculate the total revenue for each month

SELECT ROUND(SUM(revenue), 2) AS monthly_revenue, 
       month(order_date) AS Month
FROM
ecommerce_sales_analytics_clean
GROUP BY month
ORDER BY Month DESC;

-- Show the monthly revenue trend

WITH monthly_revenue_trend AS
(
SELECT ROUND(SUM(revenue), 2) AS monthly_revenue, 
       month(order_date) AS Month
FROM
ecommerce_sales_analytics_clean
GROUP BY month
ORDER BY Month DESC
),
monthly_lag AS
(
SELECT Month, 
       monthly_revenue,
       LAG(monthly_revenue) OVER (ORDER BY Month) AS previous_revenue
FROM monthly_revenue_trend
)
SELECT Month,
       monthly_revenue,
       previous_revenue,
       ROUND((monthly_revenue - previous_revenue), 2) AS
       diffrence
FROM monthly_lag;

-- 17. What is the yearly revenue trend ?

SELECT ROUND(SUM(revenue), 2) AS yearly_revenue,
       YEAR(order_date) AS Year
FROM
ecommerce_sales_analytics_clean
GROUP BY Year 
ORDER BY yearly_revenue DESC;

-- 18. Which are the top 10 customers by revenue ?

SELECT ROUND(SUM(revenue), 2) AS revenue,
       customer_id AS customers
FROM
ecommerce_sales_analytics_clean
GROUP BY customer_id
ORDER BY revenue DESC
LIMIT 10;

-- 19. Rank product categories by total revenue 

WITH product_categories_revenue AS
(
SELECT ROUND(SUM(revenue), 2) AS total_revenue,
       product_category
FROM
ecommerce_sales_analytics_clean
GROUP BY product_category
)
SELECT total_revenue,
      product_category,
      RANK() OVER (ORDER BY total_revenue DESC) AS product_categories_rank
FROM
product_categories_revenue;

-- 20. The cumulative (running) revenue over time

 WITH revenue_over_time AS
 (
 SELECT ROUND(SUM(revenue), 2) AS monthly_revenue,
        MONTH(order_date) AS Month
FROM
ecommerce_sales_analytics_clean
GROUP BY Month 
 )
 SELECT monthly_revenue,
        Month,
        SUM(monthly_revenue) OVER (ORDER BY monthly_revenue) AS cumulative_revenue
FROM
revenue_over_time 
ORDER BY Month ASC;

-- 21. Comparing revenue befoe and after applying discounts

SELECT ROUND(SUM(unit_price * quantity), 2) AS revenue_before_discount,
       ROUND(SUM(unit_price * quantity * (1 - discount)), 2) AS revenue_after_discount
FROM
ecommerce_sales_analytics_clean;

-- 22. Which customers have revenue above the overall average ?

WITH overall_average_revenue AS
(
SELECT ROUND(SUM(revenue), 2) AS total_revenue,
       customer_id AS customers
FROM
ecommerce_sales_analytics_clean
GROUP BY customers
)
SELECT customers,
       total_revenue
FROM overall_average_revenue
WHERE total_revenue >
(
SELECT AVG(total_revenue)
FROM overall_average_revenue
)
ORDER BY total_revenue DESC;

-- 23. Which regions have an average revenue higher than the global average ?

WITH global_average_revenue AS
(
SELECT region,
       ROUND(AVG(revenue), 2) AS average_revenue
FROM
ecommerce_sales_analytics_clean
GROUP BY region
)
SELECT region,
       average_revenue
FROM 
global_average_revenue
WHERE average_revenue >
(
SELECT ROUND(AVG(average_revenue), 2) 
FROM
global_average_revenue
)
ORDER BY average_revenue DESC;

-- 24. Finding percentage contribution of each product category to total revenue

WITH category_revenue AS 
(
SELECT product_category,
       ROUND(SUM(revenue), 2) category_revenue
FROM
ecommerce_sales_analytics_clean
GROUP BY product_category
),
total_revenue AS
(
SELECT ROUND(SUM(revenue), 2) AS total_revenue
FROM
ecommerce_sales_analytics_clean
)
SELECT cr.product_category,
       cr.category_revenue,
       tr.total_revenue,
       ROUND((cr.category_revenue / tr.total_revenue) * 100, 2) AS percentage_contribution
FROM category_revenue cr CROSS JOIN total_revenue tr
ORDER BY percentage_contribution DESC;




