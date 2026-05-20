/*
=============================================================================
Quality Checks
=============================================================================
Script Purpose:
  This script performs various quality checks for data consistency, accuracy, 
  and standardization across the 'silver' schema. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between Hated fields.
Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
=============================================================================
*/

--=============================================================================
--Checking silver.crm_cust_info
--=============================================================================
--Check for Nulls or Duplicates in Primary Key
--Expection: No result
select cst_id,count(*) as count_of_cust from silver.crm_cust_info group by cst_id Having count(*)>1 or cst_id is null;

--Check for unwanted spaces
--Expection: No result
select cst_firstname from silver.crm_cust_info where cst_firstname != Trim(cst_firstname);
select cst_lastname from silver.crm_cust_info where cst_lastname != Trim(cst_lastname);

--Data Standardization & consistency
select distinct(cst_gndr) from silver.crm_cust_info;

--=============================================================================
--Checking silver.crm_prd_info Table
--============================================================================= 
--Check for Nulls or Duplicates in Primary Key
--Expection: No result
select prd_id,count(*) from silver.crm_prd_info group by prd_id Having count(*)>1 or prd_id is null;

--Check unwanted spaces
--Expection: No result
select prd_nm from silver.crm_prd_info where prd_nm != Trim(prd_nm);

--Check for Nulls or Negative Numbers
--Expection: No result
select prd_cost from silver.crm_prd_info where prd_cost<0 or prd_cost is null;

--Data Standardization & consistency
select distinct(prd_line) from silver.crm_prd_info;

--=============================================================================
--Checking silver.crm_sales_details Table
--============================================================================= 
-- Check for Invaild Dates Orders
select * from silver.crm_sales_details
where sls_order_dt > sls_ship_dt or sls_order_dt > sls_due_dt;

--Check Data Consistency: Between Sales,Quantity, and Price
--> Sales= Quantity * Price
--> Values must not be NULL, zero, or negative
SELECT DISTINCT
sls_sales,
sls_quantity,
sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity* sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0 ORDER BY sls_sales,sls_quantity,sls_price;

--=============================================================================
--Checking silver.erp_cust_az12 Table
--============================================================================= 
--Check CID Values
select 
CASE
	When CID like 'NAS%' THEN substring(CID,4,len(CID))
	ELSE CID
END as CID,
BDATE,
GEN
from silver.erp_cust_az12;

--Check Out of Range Dates
select BDATE from silver.erp_cust_az12 where BDATE>GETDATE();

--Data Standardization and Consistency
select Distinct(GEN) from silver.erp_cust_az12;

--=============================================================================
--Checking silver.erp_loc_a101 Table
--============================================================================= 
--Data Standardization and Consistency
select Distinct(cntry) from silver.erp_loc_a101;

--=============================================================================
--Checking silver.erp_px_cat_g1v2 Table
--============================================================================= 
--check unwanted spaces
select * from silver.erp_px_cat_g1v2 where cat != TRIM(cat) or subcat != TRIM(subcat) or maintenance != TRIm(maintenance);

--Data Standardization and Consistency
select Distinct(cat) from silver.erp_px_cat_g1v2;
select Distinct(subcat) from silver.erp_px_cat_g1v2;
select Distinct(maintenance) from silver.erp_px_cat_g1v2;
