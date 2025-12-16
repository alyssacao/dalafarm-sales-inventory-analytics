# DalaFarm Inventory & Product Sales Analytics

## Overview
This project builds an end-to-end analytics pipeline that transforms raw
PostgreSQL sales and inventory data into actionable insights for business teams.

## Tech Stack
- PostgreSQL (source)
- Amazon S3 (raw storage)
- Amazon Redshift (data warehouse)
- dbt (data modeling & transformations)
- Power BI (visualization)

## Architecture
PostgreSQL → CSV → S3 → Redshift → dbt → Power BI

## Key Business Outcomes
- Improved inventory visibility and stockout prevention
- Identification of top- and low-performing products
- Automated daily data refresh with consistent KPIs

## Dashboards
- Sales Analytics
- Inventory Analytics