# E-Commerce Analytics Pipeline

An end-to-end data engineering pipeline built with modern open-source tools, demonstrating a production-grade architecture from raw data ingestion to analytical reporting.

End-to-end data pipeline: MongoDB → DuckDB → dbt → Airflow

## Architecture

MongoDB (Source)
↓
Python Extract & Load
↓
DuckDB (Analytical Layer)
↓
dbt Core (Transformations)
├── Staging Layer (cleansing & standardization)
└── Marts Layer (business aggregations)
↓
Apache Airflow (Orchestration)
└── Daily DAG with Data Quality Checks

## Tech Stack

| Tool | Purpose |
|------|---------|
| MongoDB | NoSQL source system (raw transactional data) |
| DuckDB | Local analytical database |
| dbt Core | Data transformations & testing |
| Apache Airflow | Pipeline orchestration |
| Docker | Containerization |
| Python | Extract & Load scripts |

## Pipeline Overview

The pipeline runs as a daily Airflow DAG with 4 sequential tasks:

1. **extract_from_mongodb_to_duckdb** — Extracts raw data from MongoDB collections and loads into DuckDB
2. **run_dbt_staging** — Runs staging models: cleansing, type casting, column standardization
3. **run_dbt_marts** — Runs mart models: order revenue analysis, customer metrics
4. **data_quality_check** — Validates row counts against minimum thresholds

## dbt Models

**Staging**
- `stg_orders` — Order data with timestamp casting
- `stg_customers` — Customer dimension
- `stg_order_items` — Order line items
- `stg_products` — Product catalog
- `stg_sellers` — Seller data

**Marts**
- `mart_orders` — Order-level revenue and delivery metrics
- `mart_customers` — Customer lifetime value and order history

## Dataset

[Brazilian E-Commerce Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) — 100k+ orders across 9 CSV files.

## How to Run

### Prerequisites
- Docker Desktop
- Python 3.12
- MongoDB

### Steps

```bash
# 1. Load data into MongoDB
python ecommerce_pipeline/load_to_mongodb.py

# 2. Start Airflow
cd airflow
docker compose up -d

# 3. Trigger the pipeline
# Open http://localhost:8080 and trigger ecommerce_pipeline DAG
```

## Author

Tuğba Şeker Can — Senior Data & BI Engineer
[LinkedIn](https://www.linkedin.com/in/tugbaseker)

