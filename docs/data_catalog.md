# Data Dictionary for Gold Layer

This document describes the structure of the Gold Layer in the Data Warehouse.
The Gold layer follows a Star Schema design optimized for analytical queries.

---

# 1. gold.dim_customers

## Purpose
Provides consolidated customer information enriched with ERP demographic and location attributes.

## Columns

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| customer_key | INT | Surrogate key uniquely identifying each customer record. |
| customer_id | INT | Original customer ID from CRM. |
| customer_number | NVARCHAR(50) | Business identifier used across systems. |
| first_name | NVARCHAR(50) | Customer first name. |
| last_name | NVARCHAR(50) | Customer last name. |
| country | NVARCHAR(50) | Standardized country name. |
| marital_status | NVARCHAR(50) | Marital status (Single, Married, n/a). |
| gender | NVARCHAR(50) | Gender value. CRM is treated as master source. |
| birthdate | DATE | Customer birthdate from ERP system. |
| create_date | DATE | Customer creation date in CRM. |

Primary Key: `customer_key`

---

# 2. gold.dim_products

## Purpose
Provides structured product information enriched with ERP category metadata.

## Columns

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| product_key | INT | Surrogate key uniquely identifying each product record. |
| product_id | INT | Original product ID from CRM. |
| product_number | NVARCHAR(50) | Business product identifier used in sales. |
| product_name | NVARCHAR(100) | Descriptive product name. |
| category_id | NVARCHAR(50) | Product category identifier. |
| category | NVARCHAR(50) | High-level classification (e.g., Bikes, Components). |
| subcategory | NVARCHAR(50) | Detailed classification within category. |
| maintenance | NVARCHAR(50) | Indicates if product requires maintenance. |
| cost | DECIMAL(18,2) | Product cost value. |
| product_line | NVARCHAR(50) | Product line (Road, Mountain, Touring, etc.). |
| start_date | DATE | Date when the product became active. |

Primary Key: `product_key`

---

# 3. gold.fact_sales

## Purpose
Stores transactional sales data at the order-line level.

## Grain
One row per order line.

## Columns

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| order_number | NVARCHAR(50) | Unique sales order identifier. |
| product_key | INT | Foreign key to gold.dim_products. |
| customer_key | INT | Foreign key to gold.dim_customers. |
| order_date | DATE | Date when order was placed. |
| shipping_date | DATE | Date when order was shipped. |
| due_date | DATE | Order due date. |
| sales | DECIMAL(18,2) | Total sales amount. |
| quantity | INT | Quantity sold. |
| price | DECIMAL(18,2) | Unit price. |

Foreign Keys:
- product_key → gold.dim_products(product_key)
- customer_key → gold.dim_customers(customer_key)

---

## Architecture

The Gold Layer follows a Star Schema model:

- Dimensions:
  - dim_customers
  - dim_products

- Fact Table:
  - fact_sales
