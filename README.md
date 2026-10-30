# 📈Ecommerce Sales Analysis Using MySQL

## 📌Project Overview

This project analyzes an ecommerce sales dataset using MYSQL. The covers the complete data analysis workflow, including database creation, data cleaning, and exploration data analysis (EDA) to uncover valuable business insights.

---

## Objectives

- Clean and prepare dataset for analysis.
- Analyze sales performance.
- Understand customer purchasing behavior.
- Identify top-performing products and regions.
- Practice SQL using real-world buiness scenarios

---

## 🗒️Dataset
- order_id
- order_date
- customer_id
- product_category
- region
- quantity
- unit_price
- discount
- payment_method
- delievery_days
- customer_rating
- revenue

---

## 🛠️Tools Used
- MySQL
- MySQL Workbench

---

## 🧹Data Cleaning

- Created a staging table
- Removed duplicate records.
- Checked and handle NULL values.
- Checked blank values.
- Removed unnecessary data.
- Create a clean table for analysis

## 🔎Exploratory Data Analysis (EDA)

The analysis answered business questions such as :

- Total number of orders
- Number of unique customers
- Monthly revenue trend
- Yearly revenue trend
- Top product categories by revenue
- Top customers by revenue
- Top regions by revenue
- Runing (cumulative) revenue over time
- Revenue before and after discounts
- Customers with revenue above the overall average
- Regions with average revenue above the global average 
- Percentage contribution of each category to total revenue

---

## 📊SQL Concepts Used

- SELECT
- WHERE 
- GROUP BY
- ORDER BY
- Aggregate Fuctions 
- CASE
- CTE (Common Table Expressions)
- Subqueries
- Window Functions 
  - RANK()
  - LAG()
- Date Functions
- ROUND()
- LIMIT

--- 

## 🎯Key Insights

- Sales Trends: Analyzed monthly revenue trends to understand how sales performance changes over time.
- Product Categories: Compared category revenue and contribution to total sales.
- Customer Performance: Identified top customers based on total spending.
- Regional Performance: Compared sales performance across different regions.
- Discount Analysis: Examined the relationship between discounts and sales performance.
- Data Quality: Checked duplicate records and prepared a cleaned dataset for reliable analysis.

## Project Structure

```
01_database_setup.sql
02_data_cleaning.sql
03_clean_table_and_eda.sql
README.md
```

---

## 💡Results

- Created SQL queries to analyze monthly revenue and sales trends.
- Ranked product categories by revenue and calculated their share of total sales.
- Identified the highest-spending customers.
- Evaluated sales performance across different regions.
- Compared sales metrics across discount levels.
- Organized the analysis into reusable SQL queries and a cleaned dataset.

---

## ✔️Conclusion 

This project used MySQL to analyze e-commerce sales data and explore revenue trends, product category performance, customer spending, regional sales, and discounts.

Through data cleaning, aggregation, ranking, window functions, and exploratory data analysis (EDA), I strengthened my SQL skills and ability to extract meaningful insights from sales data.

The project demonstrates how SQL can transform raw e-commerce data into structured business insights that support sales performance monitoring and data-driven decision-making.

---

## Author

Anis Mo
