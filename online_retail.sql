-- SQL Data Analysis Project: Online Retail Dataset
-- Author: Anano Edzgveradze
-- ==========================================
-- 1. Raw vs Clean Counts
-- ==========================================
SELECT 'online_retail_raw' AS table_name, COUNT(*) AS row_count
FROM online_retail_raw
UNION ALL
SELECT 'online_retail_clean' AS table_name, COUNT(*) AS row_count
FROM online_retail_clean;
-- ==========================================
-- 2. Summary by Country
-- ==========================================
DROP TABLE IF EXISTS summary_country;
CREATE TABLE summary_country AS
SELECT
country,
COUNT(DISTINCT invoice_no) AS total_orders,
COUNT(DISTINCT customer_id) AS unique_customers,
SUM(quantity) AS total_units_sold,
ROUND(SUM(total_amount), 2) AS total_revenue
FROM online_retail_clean
GROUP BY country
ORDER BY total_revenue DESC;
SELECT *
FROM summary_country
ORDER BY total_revenue DESC;
-- ==========================================
-- 3. Summary by Month
-- ==========================================
DROP TABLE IF EXISTS summary_monthly;
CREATE TABLE summary_monthly AS
SELECT
DATE_TRUNC('month', invoice_date)::date AS month,
COUNT(DISTINCT invoice_no) AS total_orders,
COUNT(DISTINCT customer_id) AS unique_customers,
SUM(quantity) AS total_units_sold,
ROUND(SUM(total_amount), 2) AS total_revenue
FROM online_retail_clean
GROUP BY DATE_TRUNC('month', invoice_date)::date
ORDER BY month;
SELECT *
FROM summary_monthly
ORDER BY month;
-- ==========================================
-- 4. Top Customers
-- ==========================================
DROP TABLE IF EXISTS summary_top_customers;
CREATE TABLE summary_top_customers AS
SELECT
customer_id,
COUNT(DISTINCT invoice_no) AS total_orders,
SUM(quantity) AS total_units_bought,
ROUND(SUM(total_amount), 2) AS total_spent
FROM online_retail_clean
GROUP BY customer_id
ORDER BY total_spent DESC;
SELECT *
FROM summary_top_customers
ORDER BY total_spent DESC
LIMIT 10;
-- ==========================================
-- 5. Top Products
-- ==========================================
DROP TABLE IF EXISTS summary_top_products;
CREATE TABLE summary_top_products AS
SELECT
stock_code,
description,
SUM(quantity) AS total_units_sold,
ROUND(SUM(total_amount), 2) AS total_revenue,
COUNT(DISTINCT invoice_no) AS total_orders
FROM online_retail_clean
GROUP BY stock_code, description
ORDER BY total_revenue DESC;
SELECT *
FROM summary_top_products
ORDER BY total_revenue DESC