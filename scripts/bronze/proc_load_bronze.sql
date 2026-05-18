/*
======================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
======================================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
      - Truncates the bronze tables before loading data.
      - Uses the BULK INSERT command to load data from csv Files to bronze tables.

Parameters:
    None.
  This stored procedure does not accept any parameters or return any values.

Usage Example:
EXEC bronze.load_bronze;
=======================================================================================
*/
Create or Alter PROCEDURE bronze.load_bronze as
BEGIN
	DECLARE @start_time DATETIME,@end_time DATETIME,@batch_start_time DATETIME,@batch_end_time DATETIME;
	SET @batch_start_time= GETDATE();
	BEGIN TRY
		PRINT '======================================================';
		PRINT 'LOADING BRONZE LAYER';
		PRINT '======================================================';

		PRINT '------------------------------------------------------';
		PRINT 'LOADING CRM TABLES';
		PRINT '------------------------------------------------------';

		SET @start_time= GETDATE ();
		PRINT '>>Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>>INSERTING DATA: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info 
		from 'E:\SQL_pdfs\sql-data-warehouse-project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK);
		SET @end_time= GETDATE ();
		PRINT '>>Load Duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) as NVARCHAR)+ ' seconds';
		Print '-------------------------------';

		SET @start_time= GETDATE ();
		PRINT '>>Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>>INSERTING DATA: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info 
		from 'E:\SQL_pdfs\sql-data-warehouse-project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK);
		SET @end_time= GETDATE ();
		PRINT '>>Load Duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) as NVARCHAR)+ ' seconds';
		Print '-------------------------------';

		SET @start_time= GETDATE ();
		PRINT '>>Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>>INSERTING DATA: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details 
		from 'E:\SQL_pdfs\sql-data-warehouse-project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK);
		SET @end_time= GETDATE ();
		PRINT '>>Load Duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) as NVARCHAR)+ ' seconds';
		Print '-------------------------------';

		PRINT '------------------------------------------------------';
		PRINT 'LOADING ERP TABLES';
		PRINT '------------------------------------------------------';

		SET @start_time= GETDATE ();
		PRINT '>>Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>>INSERTING DATA: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12 
		from 'E:\SQL_pdfs\sql-data-warehouse-project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		with (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK);
		SET @end_time= GETDATE ();
		PRINT '>>Load Duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) as NVARCHAR)+ ' seconds';
		Print '-------------------------------';

		SET @start_time= GETDATE ();
		PRINT '>>Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>>INSERTING DATA: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101 
		from 'E:\SQL_pdfs\sql-data-warehouse-project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		with (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK);
		SET @end_time= GETDATE ();
		PRINT '>>Load Duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) as NVARCHAR)+ ' seconds';
		Print '-------------------------------';

		SET @start_time= GETDATE ();
		PRINT '>>Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>>INSERTING DATA: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2 
		from 'E:\SQL_pdfs\sql-data-warehouse-project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		with (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK);
		SET @end_time= GETDATE ();
		PRINT '>>Load Duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) as NVARCHAR)+ ' seconds';
		Print '-------------------------------';

		SET @batch_end_time= GETDATE();
		PRINT '========================================';
		PRINT 'Loading Bronze Layer is Completed';
		PRINT '   - Total Load Duration: '+ CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) as NVARCHAR)+ ' seconds';
		PRINT '========================================';
	END TRY
	BEGIN CATCH
		PRINT '======================================================';
		PRINT 'Error Occured during loading bronze layer';
		PRINT 'Error Message: '+ CAST(Error_Number() as NVARCHAR);
		PRINT 'Error Message: '+ Error_Message();
		PRINT 'Error Message: '+ CAST(Error_State() as NVARCHAR)
		PRINT '======================================================';
	END CATCH
END

EXEC bronze.load_bronze;
