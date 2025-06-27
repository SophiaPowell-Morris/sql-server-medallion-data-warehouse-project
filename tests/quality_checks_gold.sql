/*
================================================================================
Quality Checks
================================================================================
Script Purpose:
    This script peforms quality checks to validate the integrity, consistency,
    and accuracy of the 'Gold' layer. These checks ensure:
        - Uniqueness of surrogate keys in dimension tables.
        - Referential integrity between fact and dimension tables.
        - Validation of relationships in the data model for analytical purposes. 

Usage:
    - Run these checks AFTER data loading the 'Silver' layer.
    - Investigate and resolve any discrepancies found during the checks. 
================================================================================
*/

-- ===========================================================
-- Checking 'gold.dim_customers.gender'
-- ===========================================================
-- Checking for values in the Gender column
-- Expectation: 'n/a', 'Male', 'Female'
SELECT DISTINCT 
	gender
FROM gold.dim_customer 

-- ===========================================================
-- Checking 'gold.dim_customers.customer_key'
-- ===========================================================
-- Checking for Uniqueness of the Customer Key 
-- Expectation: No results 
SELECT 
	customer_key,
	COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- ===========================================================
-- Checking 'gold.dim_products.product_key'
-- ===========================================================
-- Check for uniqueness of Product Key in gold.dim_products
-- Expectation: No results 
SELECT 
	product_key,
  COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- ===========================================================
-- Checking 'gold.fact_sales'
-- ===========================================================

-- Foreign Key Integrity (Dimensions)
-- Check all Dimensions can successfully join to the Fact table.
-- Check the data model connectivity between fact and dimensions. 
-- Expectation: No results 

SELECT 
	*
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON        f.customer_key = c.customer_key
LEFT JOIN gold.dim_products p
ON.       f.product_key = p.product_key
WHERE c.customer_key IS NULL OR p.customer_key IS NULL 
