# SQL_Data_Warehouse_Project
Building a modern data warehouse with SQL server, including ETL Processes,data modeling and analytics

**End-to-End Data Warehouse Project**
Overview
Developed an end-to-end Data Warehouse solution using SQL Server based on the Medallion Architecture (Bronze, Silver, Gold). This project integrates data from multiple source systems such as CRM and ERP, transforms raw data into clean, structured, and analytics-ready datasets for business reporting and insights.

**Architecture**
The solution follows a layered architecture:
Bronze Layer: Raw data ingestion from source systems without transformation.
Silver Layer: Data cleansing, validation, standardization, and transformation.
Gold Layer: Business-ready data modeling using fact and dimension tables.

**Data Integration**:
Integrated data from multiple enterprise systems:
**CRM**: Customer, Product, and Sales data
**ERP**: Product categories, Customer enrichment, and Location data

**Data Modeling**:
Designed a **Star Schema** data model for analytics:
**Fact Table:** fact_sales
Dimension Tables: dim_customers, dim_products
Business logic implemented:
Sales Amount = Quantity × Price

**Data Pipeline Flow**:
Source Systems → Bronze Layer → Silver Layer → Gold Layer → Analytics

**Technologies Used**:
SQL Server | MySQL | ETL | Data Warehousing | Star Schema | Power BI | Tableau

**Key Features**
✔ End-to-End ETL Pipeline Development
✔ Multi-source Data Integration
✔ Data Cleansing & Transformation
✔ Dimensional Data Modeling
✔ Analytics-ready Data Warehouse Solution

**Repo structure:**
data-warehouse-project/
│
├── datasets/
│   ├── source_crm/
│   └── source_erp/
│
├── scripts/
│   ├── bronze/
│   │   ├── bronze_load.sql
│   │
│   ├── silver/
│   │   ├── silver_load.sql
│   │
│   └── gold/
│       ├── gold_load.sql
│
├── docs/
│   ├── architecture_diagram.png
│   ├── data_flow.png
│   └── star_schema.png
│
└── README.md
