# Data Warehouse and Analytics Project

This **Data Warehouse and Analytics Project** will demonstrate an comprehemsive and analytics solution, from building a data warehouse to then generate actionable insights.
Designed as a porfolio project that highlights industry practices in both data engineering and analytics. 

---
## Project Overview
This project involves:
  1. **Data Architecture**: Designing a Modern Data Warehouse Using Medallion Architecture **Bronze**, **Silver**, and **Gold** layers.
  2. **ETL Pipelines**: Extracting, transforming, and loading data from the source systems into the warehouse.
  3. **Data Modelling**: Developing fact and dimension tables optimised for analytical queries.
  4. **Analytics & Reporting**: Creating SQL-based reports and dashboards for actionable insights.

This reposistory shows expertise in:
  - SQL Development
  - Data Architecture
  - Data Engineering
  - ETL Pipeline Development
  - Data Modeling
  - Data Analytics 

## Project Requirements

### Building the Data Warehouse (Data Engineering)

#### Objective 
Develop a modern data warehouse with a medallion data architecture using SQL Server including ETL processes, data modelling and analytics, to consolidate sales data, enabling analytical reporting and informed decision-making. 

#### Specifications 
- **Data Source**: Import data from two source systems (ERP and CRM) provided as CSV files.
- **Data Quality**: Cleanse and resolve data quality issues prior to analysis.
- **Scope**: Focus on the lastest dataset only; historisation of data is NOT required.
- **Documentation**: Provide clear documentation of the data model to support both business stakeholders and analytics teams.

---

### BI: Analytics & Reporting (Data Analytics)

#### Objective
Develop SQL-based analytics to deliver detailed insights into:
- **Customer Behaviour**
- **Product Performance**
- **Sales Trends**

These insights enpower stakeholders with key business metrics, enabling strategic decision-making. 

## Data Architecture 

The data architecture for this project follows the Medallion Architecture **Bronze**, **Silver**, and **Gold** layers:

![Medallion Architecure Diagram](https://github.com/user-attachments/assets/d0d0e6e8-e5a3-4627-b325-c3813f3f494a)

1. **Bronze Layer**: Stores data as-is from the source systems. Data is ingested from CSV Files into SQL Server Database.
2. **Silver Layer**: This layer includes data cleansing, standardization. and normalisation processes to prepare data for analysis.
3. **Gold Layer**: Houses business-ready data modeled into a star schema required for reporting and analysis.

## Repository Structure



