-- Databricks notebook source
SELECT *
FROM coffeeshop.brightcoffeeshop.coffee_shop_analysis;

DESCRIBE coffeeshop.brightcoffeeshop.coffee_shop_analysis;

--Checking product_type we have on the table--
SELECT DISTINCT product_type
FROM coffeeshop.brightcoffeeshop.coffee_shop_analysis;

-----Checking product category--
SELECT  transaction_qty,
       unit_price,
       (transaction_qty * unit_price) AS Total_Amount
       FROM coffeeshop.brightcoffeeshop.coffee_shop_analysis;


--Checking the product Cat--
SELECT DISTINCT product_type
FROM coffeeshop.brightcoffeeshop.coffee_shop_analysis
LIMIT 100;
  
-- Cleaning Product_cat - Mapping product_type to broader product_category--
SELECT DISTINCT 
      product_type,
      CASE
        WHEN product_type IN ('Gourmet brewed coffee', 'Drip coffee', 'Organic brewed coffee', 'Premium brewed coffee', 'Barista Espresso') THEN 'Coffee'
        WHEN product_type IN ('Brewed Chai tea', 'Brewed Black tea', 'Brewed Green tea', 'Brewed herbal tea', 'Chai tea', 'Black tea', 'Green tea', 'Herbal tea') THEN 'Tea'
        WHEN product_type IN ('Hot chocolate', 'Organic Chocolate', 'Drinking Chocolate') THEN 'Drinking Chocolate'
        WHEN product_type IN ('Pastry', 'Scone', 'Biscotti') THEN 'Bakery'
        WHEN product_type IN ('Espresso Beans', 'Gourmet Beans', 'House blend Beans', 'Organic Beans', 'Premium Beans', 'Green beans') THEN 'Coffee beans'
        WHEN product_type IN ('Regular syrup', 'Sugar free syrup') THEN 'Flavours'
        WHEN product_type IN ('Clothing', 'Housewares') THEN 'Branded'
        ELSE 'Other'
      END AS Product_category
FROM coffeeshop.brightcoffeeshop.coffee_shop_analysis
ORDER BY Product_category, product_type;

-- Inspecting Product Type--
SELECT DISTINCT product_type
FROM coffeeshop.brightcoffeeshop.coffee_shop_analysis;


--Viewing Product Type and Category mapping--
SELECT DISTINCT 
      product_type,
      product_category
FROM coffeeshop.brightcoffeeshop.coffee_shop_analysis
ORDER BY product_category, product_type;

-- Creating the revenue Column--
SELECT transaction_qty*unit_price AS Total_Amount
FROM coffeeshop.brightcoffeeshop.coffee_shop_analysis;

SELECT 
*,
unit_price * transaction_qty AS Total_Amount
FROM coffeeshop.brightcoffeeshop.coffee_shop_analysis;

SELECT transaction_qty, ROUND(SUM (CAST(transaction_qty AS DOUBLE) * CAST (REPLACE(unit_price,',','.')AS DOUBLE)),0) AS Total_Amount
FROM coffeeshop.brightcoffeeshop.coffee_shop_analysis
GROUP BY transaction_qty;


-- DATA CLEANING

--Checking duplicates (note: this table doesn't have transaction_id)
-- Using all columns to check for complete duplicates
SELECT *,
        COUNT(*) AS Duplicate_cnt
FROM coffeeshop.brightcoffeeshop.coffee_shop_analysis
GROUP BY ALL
HAVING COUNT(*) > 1
ORDER BY Duplicate_cnt DESC; 




--FINAL CODE FOR CHECKING DUPLICATES FOR ALL COLUMNS
SELECT *,
        COUNT(*) AS Duplicate_cnt
FROM coffeeshop.brightcoffeeshop.coffee_shop_analysis
GROUP BY ALL
HAVING COUNT(*)>1;

--CHECKING THE DATE COLUMN (using pre-processed date components)--

SELECT DISTINCT year, month_name, month_number
FROM coffeeshop.brightcoffeeshop.coffee_shop_analysis
ORDER BY year, month_number;

SELECT DISTINCT month_name
FROM coffeeshop.brightcoffeeshop.coffee_shop_analysis;

--CHECKING TIME BUCKET COLUMN (pre-processed time categories)
SELECT DISTINCT Time_bucket
FROM coffeeshop.brightcoffeeshop.coffee_shop_analysis;


-- Product Analysis
SELECT
product_type,
product_detail,
unit_price,
SUM(transaction_qty) AS total_transaction_qty,
ROUND(SUM(transaction_qty * unit_price), 2) AS Total_Amount
FROM coffeeshop.brightcoffeeshop.coffee_shop_analysis
GROUP BY
product_type,
product_detail,
unit_price
ORDER BY Total_Amount DESC;


-- Time-based Analysis (using Time_bucket column)

SELECT *
FROM coffeeshop.brightcoffeeshop.coffee_shop_analysis
WHERE Time_bucket = 'Morning'
LIMIT 100;

-- Note: workspace.bright_coffee_schema.sales_data has transaction_id and time_of_day columns
-- coffeeshop.brightcoffeeshop.coffee_shop_analysis does not have these columns
SELECT 
    transaction_date,
    day_name,
    day_number,
    month_name,
    month_number,
    year,
    Time_bucket,
    transaction_qty,
    store_id,
    product_id,
    product_type,
    product_detail,
    unit_price,
    total_amount
FROM coffeeshop.brightcoffeeshop.coffee_shop_analysis
WHERE Time_bucket = 'Afternoon'
LIMIT 100;

-------------------------------------
--Checking the Sales Value Category-----------------------------
SELECT
MAX (transaction_qty * unit_price) AS High_sales_value,
MIN (transaction_qty * unit_price) AS Low_sales_value
FROM  coffeeshop.brightcoffeeshop.coffee_shop_analysis;

----------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------
--Quantity Category
SELECT
CASE 
    WHEN transaction_qty =1 THEN 'low'
    WHEN transaction_qty BETWEEN 2 AND 3 THEN 'Medium'
    ELSE 'high'
END AS Quantity_Category
FROM coffeeshop.brightcoffeeshop.coffee_shop_analysis;
-----------------------------------------------------------------------

--checking total revenue per store location
SELECT store_location, SUM(unit_price * transaction_qty) AS Total_revenue
FROM coffeeshop.brightcoffeeshop.coffee_shop_analysis
GROUP BY store_location
ORDER BY Total_revenue DESC;

--checking high performing and low performing products by type
SELECT product_type, SUM(unit_price * transaction_qty) AS Total_revenue
FROM coffeeshop.brightcoffeeshop.coffee_shop_analysis
GROUP BY product_type
ORDER BY Total_revenue DESC;

--checking high performing and low performing products
SELECT product_type, SUM(unit_price * transaction_qty) AS Total_revenue
FROM coffeeshop.brightcoffeeshop.coffee_shop_analysis
GROUP BY product_type
ORDER BY Total_revenue DESC;


-----------------------
-- Time analysis using pre-processed time_bucket column
SELECT DISTINCT time_bucket
FROM coffeeshop.brightcoffeeshop.coffee_shop_analysis;

-- Month analysis using pre-processed month_name column
SELECT DISTINCT month_name
FROM coffeeshop.brightcoffeeshop.coffee_shop_analysis;



--Checking the days (using pre-processed day_name column)---
SELECT DISTINCT day_name, day_number
FROM coffeeshop.brightcoffeeshop.coffee_shop_analysis
ORDER BY day_number;






