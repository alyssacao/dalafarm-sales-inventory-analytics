from dotenv import load_dotenv
load_dotenv()

import psycopg2
import os
import pandas as pd
import boto3
from datetime import date

# ===============================
# Environment variables
# ===============================
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT", 5432)
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")

S3_BUCKET = os.getenv("S3_BUCKET")
BASE_DIR = os.getenv("DALAFARM_BASE_DIR")

today = date.today().strftime("%Y-%m-%d")

# Local save directories
save_dir_inv = os.path.join(BASE_DIR, "inv_daily")
save_dir_sales = os.path.join(BASE_DIR, "sales_orders")
save_dir_prod = os.path.join(BASE_DIR, "products")
save_dir_warehouse = os.path.join(BASE_DIR, "warehouse")
save_dir_soi = os.path.join(BASE_DIR, "sales_order_items")

csv_paths = {}

def extract_postgres_to_csv():
    conn = psycopg2.connect(
        host=DB_HOST,
        port=DB_PORT,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD
    )

    queries = {
        "inventory": "SELECT * FROM inventory;",
        "sales_orders": "SELECT * FROM sales_orders;",
        "products": "SELECT * FROM products;",
        "warehouses": "SELECT * FROM warehouses;",
        "sales_order_items": "SELECT * FROM sales_order_items;"
    }

    for table, query in queries.items():
        df = pd.read_sql(query, conn)
        filename = f"{table}_{today}.csv" if table not in ["products", "warehouses"] else f"{table}.csv"
        path = os.path.join(BASE_DIR, table, filename)

        os.makedirs(os.path.dirname(path), exist_ok=True)
        df.to_csv(path, index=False)

        csv_paths[table] = path
        print(f"[OK] Saved {table} to {path}")

    conn.close()


def upload_to_s3():
    s3 = boto3.client("s3")

    for table, path in csv_paths.items():
        s3_key = f"{table}/{os.path.basename(path)}"
        s3.upload_file(path, S3_BUCKET, s3_key)
        print(f"[OK] Uploaded {s3_key} to s3://{S3_BUCKET}/")


if __name__ == "__main__":
    extract_postgres_to_csv()
    upload_to_s3()
