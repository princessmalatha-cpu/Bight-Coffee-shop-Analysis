-- Databricks notebook source
-- DBTITLE 1,Cell 1




SELECT 
    transaction_id,
    DATE_FORMAT(transaction_date, 'M/d/yyyy') AS transaction_date,
    day_name,
    day_number,
    month_name,
    month_number,
    year,
    time_of_day,
    Time_bucket,
    transaction_qty,
    store_id,
    product_id,
    product_type,
    product_detail,
    unit_price,
    total_amount
FROM coffeeshop.brightcoffeeshop.bright_coffee_shop;

SELECT 
 table_catalog,
 table_schema,
 table_name,
 created,
 last_altered
 FROM information_schema.tables
 WHERE table_name in ('bright_coffee_shop','sales_data')
 AND table_schema IN('brightcoffeeshop','bright_coffee_schema');





DESCRIBE coffeeshop.brightcoffeeshop.bright_coffee_shop;

--Checking product_type we have on the table--
SELECT DISTINCT product_type
FROM coffeeshop.brightcoffeeshop.bright_coffee_shop;

-----Checking product category--
SELECT  transaction_qty,
       unit_price,
       (transaction_qty * unit_price) AS Total_Amount
       FROM coffeeshop.brightcoffeeshop.bright_coffee_shop;
SELECT 
    transaction_id,
    DATE_FORMAT(transaction_date, 'M/d/yyyy') AS transaction_date,
    day_name,
    day_number,
    month_name,
    month_number,
    year,
    time_of_day,
    Time_bucket,
    transaction_qty,
    store_id,
    product_id,
    product_type,
    product_detail,
    unit_price,
    total_amount
FROM workspace.bright_coffee_schema.sales_data
LIMIT 100;

DESCRIBE coffeeshop.brightcoffeeshop.bright_coffee_shop;

--Checking the product Cat--
SELECT DISTINCT product_type
FROM coffeeshop.brightcoffeeshop.bright_coffee_shop
LIMIT 100;
  
-- Cleaning Product Cat--
SELECT DISTINCT 
      product_type,
      CASE 
          WHEN product_type IS NULL THEN 'unknown'
          WHEN product_type =' ' THEN 'unknown'
          ELSE product_type
      END AS Product_category
FROM coffeeshop.brightcoffeeshop.bright_coffee_shop;

-- Inspecting Product Type--
SELECT DISTINCT product_type
FROM coffeeshop.brightcoffeeshop.bright_coffee_shop;


--Cleaning Product Type--
SELECT DISTINCT 
      product_type,
      CASE 
          WHEN product_type IS NULL THEN 'unknown'
          WHEN product_type =' ' THEN 'unknown'
          ELSE product_type
      END AS Product_type
FROM coffeeshop.brightcoffeeshop.bright_coffee_shop;

-- Creating the revenue Column--
SELECT transaction_qty*unit_price AS Total_Amount
FROM coffeeshop.brightcoffeeshop.bright_coffee_shop;

SELECT 
*,
unit_price * transaction_qty AS Total_Amount
FROM workspace.bright_coffee_schema.sales_data;

SELECT transaction_qty, ROUND(SUM (CAST(transaction_qty AS DOUBLE) * CAST (REPLACE(unit_price,',','.')AS DOUBLE)),0) AS Total_Amount
FROM coffeeshop.brightcoffeeshop.bright_coffee_shop
GROUP BY transaction_qty;


-- DATA CLEANING

--Checking duplicates

SELECT transaction_id,
        COUNT(*) AS Duplicate_cnt
FROM workspace.bright_coffee_schema.sales_data
GROUP BY transaction_id
HAVING COUNT(*)>1;

--CHECKING THE DATE COLUMN

SELECT DISTINCT 
    transaction_date AS original_date,
    DATE_FORMAT(transaction_date, 'M/d/yyyy') AS formatted_date
FROM coffeeshop.brightcoffeeshop.bright_coffee_shop
ORDER BY transaction_date;

SELECT DISTINCT DATE_FORMAT(transaction_date, 'MMMM') AS Month_name
FROM coffeeshop.brightcoffeeshop.bright_coffee_shop;

--CHECKING TIME BUCKET COLUMN (pre-processed time categories)
SELECT DISTINCT Time_bucket
FROM coffeeshop.brightcoffeeshop.bright_coffee_shop;


-- Product Analysis
SELECT
product_type,
product_detail,
unit_price,
SUM(transaction_qty) AS total_transaction_qty,
ROUND(SUM(transaction_qty * unit_price), 2) AS Total_Amount
FROM coffeeshop.brightcoffeeshop.bright_coffee_shop
GROUP BY
product_type,
product_detail,
unit_price
ORDER BY Total_Amount DESC;


-- Time-based Analysis (using Time_bucket column)

SELECT 
    transaction_id,
    DATE_FORMAT(transaction_date, 'M/d/yyyy') AS transaction_date,
    day_name,
    Time_bucket,
    transaction_qty,
    product_type,
    product_detail,
    unit_price,
    total_amount
FROM coffeeshop.brightcoffeeshop.bright_coffee_shop
WHERE Time_bucket = 'Morning'
LIMIT 100;

SELECT 
    transaction_id,
    DATE_FORMAT(transaction_date, 'M/d/yyyy') AS transaction_date,
    day_name,
    Time_bucket,
    transaction_qty,
    product_type,
    product_detail,
    unit_price,
    total_amount
FROM workspace.bright_coffee_schema.sales_data
WHERE Time_bucket = 'Closing hours'
LIMIT 100;

-------------------------------------
--Checking the Sales Value Category-----------------------------
SELECT
MAX (transaction_qty * unit_price) AS High_sales_value,
MIN (transaction_qty * unit_price) AS Low_sales_value
FROM  coffeeshop.brightcoffeeshop.bright_coffee_shop;

----------------------------------------------------------------------------------------------------------------
SELECT
CASE 
    WHEN (unit_price * transaction_qty) > 10000 THEN 'high'
    WHEN (unit_price * transaction_qty) BETWEEN 5000 AND 10000 THEN 'Medium'
    ELSE 'Very Low'
END AS Sales_Value_Category
FROM coffeeshop.brightcoffeeshop.bright_coffee_shop;
----------------------------------------------------------------------------------------------------------------
--Quantity Category
SELECT
CASE 
    WHEN transaction_qty =1 THEN 'low'
    WHEN transaction_qty BETWEEN 2 AND 3 THEN 'Medium'
    ELSE 'high'
END AS Quantity_Category
FROM coffeeshop.brightcoffeeshop.bright_coffee_shop;
----------------------------------------------------------------------------------------------------------------
--Quantity Category
SELECT
CASE 
    WHEN transaction_qty BETWEEN 1 AND 50 THEN 'low'
    WHEN transaction_qty BETWEEN 50 AND 100 THEN 'Medium'
    ELSE 'Very Low'
END AS Quantity_Category
FROM coffeeshop.brightcoffeeshop.bright_coffee_shop;

SELECT 
    transaction_id,
    DATE_FORMAT(transaction_date, 'M/d/yyyy') AS transaction_date,
    day_name,
    day_number,
    month_name,
    month_number,
    year,
    time_of_day,
    Time_bucket,
    transaction_qty,
    store_id,
    product_id,
    product_type,
    product_detail,
    unit_price,
    total_amount
FROM coffeeshop.brightcoffeeshop.bright_coffee_shop;




