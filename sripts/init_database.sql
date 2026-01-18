/* 
===============================================================
Create Database and Schemas
===============================================================

Script Overview:
This script creates a database named 'DataWarehouse' after first
verifying whether it already exists. If the database is found,
it will be dropped and recreated to ensure a clean setup.

Once the database is created, the script initializes three schemas
to support a layered data architecture:
  - bronze  : raw ingested data
  - silver  : cleaned and transformed data
  - gold    : analytics-ready data

WARNING:
Executing this script will permanently delete the existing
'DataWarehouse' database if it exists.
All data contained within the database will be lost.

Proceed with caution and ensure that appropriate backups
are in place before running this script.
=============================================================== 
*/


-- Create Database 'DataWarehouse'

Use master;
Go	

--Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO


CREATE DATABASE DataWarehouse;
GO


USE DataWarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
