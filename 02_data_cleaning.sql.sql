-- SQL Project - DATA Cleaning

SELECT * 
FROM 
ecommerce_sales_analytics.ecommerce_sales_analytics_5000;

-- first thing we need to do is create a staging table. This is the one we will work in and clean the data. We want a table with the raw data in case something happens

CREATE TABLE ecommerce_sales_analytics_staging LIKE
ecommerce_sales_analytics_5000;

INSERT INTO ecommerce_sales_analytics_staging
SELECT * 
FROM 
ecommerce_sales_analytics_5000;

-- 1. Remove Duplicates
-- First let's check for duplicates

SELECT * FROM ecommerce_sales_analytics_staging;

SELECT order_id, 
       order_date, 
       customer_id, 
       ROW_NUMBER() OVER (PARTITION BY order_id, order_date, customer_id) AS row_num 
FROM 
ecommerce_sales_analytics_staging;

-- While there is no duplicates let's move to the next step 
-- 2. Standardize the DATA
SELECT * FROM
ecommerce_sales_analytics_staging;

SELECT product_category, region, payment_method
FROM
ecommerce_sales_analytics_staging
GROUP BY product_category, region, payment_method;

-- There is no string errors here
-- Let's look into DATA type
SELECT order_date, 
	   str_to_date(order_date, '%m/%d/%Y') 
FROM 
ecommerce_sales_analytics_staging;

UPDATE ecommerce_sales_analytics_staging
SET order_date = str_to_date(order_date, '%m/%d/%Y');

SELECT * FROM
ecommerce_sales_analytics_staging;

ALTER TABLE 
ecommerce_sales_analytics_staging
MODIFY COLUMN order_date date;

-- AFTER changing data type and check for string errors we move to the next step
-- 3. NULL and Blank values

SELECT * 
FROM
ecommerce_sales_analytics_staging
WHERE order_id IS NULL
      OR order_date IS NULL
      OR customer_id IS NULL
      OR TRIM(product_category) = ''
      OR TRIM(region) = ''
      OR quantity IS NULL
      OR unit_price IS NULL
      OR discount IS NULL
	  OR TRIM(payment_method) = ''
      OR delivery_days IS NULL
      OR customer_rating IS NULL
      OR revenue IS NULL;

-- Checked for NULL and Blank values, No issues found
-- 4. Remove unnecessary columns or rows

SELECT * FROM 
ecommerce_sales_analytics_staging;

-- no unnecessary rows or columns, all is useful and important 