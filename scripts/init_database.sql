/*
Creating database 'DataWarehouse' in sql_server
Creating schema brone,silver,gold

Warning:
  Running the script will drop the entire 'DataWarehouse' databse if exists.
  All data in the database will deleted permanently deleted.Proceed with caution
  and ensure you have proper backups beforre running the scripts.
*/

USE master;
Go

--Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases where name='DataWarehouse')
Begin
	ALTER Database DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP Database DataWarehouse;
END;
GO

--Create DataWarehouse database
Create Database DataWarehouse;
Go

USE DataWarehouse;
Go

--Create Schemas
CREATE SCHEMA bronze;
Go

CREATE SCHEMA silver;
Go

CREATE SCHEMA gold;
Go




