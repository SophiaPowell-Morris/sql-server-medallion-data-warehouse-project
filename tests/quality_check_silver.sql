/* ================================================================================
Quality Checks
================================================================================
Script Purpose:
    This script performs various checks for data consistency, accuracy, and 
    standardization across the 'silver' schemas. It includes checks for:
        - NULL or duplicated primary keys
        - Unwanted spaces in string values
        - Data standardization and consistency
        - Invalid data ranges and orders
        - Data consistency between related fields

Usage Notes:
   - Run these checks AFTER data loading the 'silver' layer.
   - Investigate and resolve any discrepancies found during the checks
================================================================================ */

-- ================================================================================
-- Checking 'silver.crm_cust_info'
-- ================================================================================

-- Check for Nulls or Duplicates in the PK
-- Expectation: No Results 
SELECT 
  cst_id,
  count(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 
    OR cst_id IS NULL;

-- Check for unwanted spaces
-- Expectation: No results 
SELECT 
  cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

SELECT 
  cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);

SELECT 
  cst_gndr
FROM silver.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr);

SELECT 
  cst_marital_status
FROM silver.crm_cust_info
WHERE cst_marital_status != TRIM(cst_marital_status);

-- Data tandardization & Consistency
SELECT DISTINCT 
  cst_gndr
FROM silver.crm_cust_info;

SELECT DISTINCT 
  cst_marital_status
FROM silver.crm_cust_info;

-- ================================================================================
-- Checking 'silver.crm_prd_info'
-- ================================================================================
  
-- Check PR for duplicates and NULLS in the PK
-- Expectation: No results 
SELECT 
  prd_id,
  COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Check for unwanted spaces 
-- Expectation: No results 
SELECT 
  prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Check for Nulls or negative numbers
-- Expectation: No results 
SELECT 
  prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Data Standardization & Consistency 
-- Checking data quality in the 'prdt_line' column
SELECT DISTINCT 
  prdt_line
FROM silver.crm_prd_info;

-- Check of Invalid Date Order
-- Check quality of the 'start' and 'end' dates columns
SELECT 
  *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

-- ================================================================================
-- Checking 'silver.crm_sales_details'
-- ================================================================================

-- Check for Invalid Dates
-- Expection: No Invalid Dates
SELECT 
    NULLIF(sls_due_dt,0) AS sls_due_dt
FROM silver.crm_sales_details
WHERE sls_due_dt <= 0
   OR LEN(sls_due_dt) != 8
   OR sls_due_dt > 20500101
   OR sls_due_dt < 19000101;
  
-- Check for Invalid Date Orders (Order Date > Shipping / Due Date)
SELECT 
  *
FROM silver.crm_sales_details 
WHERE sls_order_dt > sls_ship_dt 
  OR sls_order_dt > sls_due_dt;

-- Check Data Consistency: Sales = Quantity * Price
-- Expectation: No Results 
SELECT DISTINCT
  sls_sales,
  sls_quantity,
  sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price  
   OR sls_sales IS NULL 
   OR sls_quantity IS NULL 
   OR sls_price IS NULL
   OR sls_sales <= 0 
   OR sls_quantity <= 0 
   OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;

-- ================================================================================
-- Checking 'silver.erp_cust_az12'
-- ================================================================================

-- Identify Out-of-Range Dates
-- Expectation: DOB between 1924-01-01 and Today
SELECT DISTINCT
  bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' 
   OR bdate > GETDATE();

-- Data Standardization & Consistency 
SELECT DISTINCT 
  gen
FROM silver.erp_cust_az12;

-- ================================================================================
-- Checking 'silver.erp_loc_a101'
-- ================================================================================

-- Data Standardization & Consistency 
SELECT DISTINCT 
  cntry
FROM silver.erp_loc_a101
ORDER BY cntry 

-- ================================================================================
-- Checking 'silver.erp_px_cat_g1v2'
-- ================================================================================
  
-- Check for Unwanted Spaces
-- Expectation: No Results 
SELECT 
  *
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat) 
   OR subcat != TRIM(subcat) 
   OR maintenance != TRIM(maintenance);

-- Data Standardization & Consistency 
SELECT DISTINCT
	cat
FROM silver.erp_px_cat_g1v2

SELECT DISTINCT
	subcat
FROM silver.erp_px_cat_g1v2

SELECT DISTINCT
	maintenance 
FROM silver.erp_px_cat_g1v2
