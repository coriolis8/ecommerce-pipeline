import pandas as pd
from pymongo import MongoClient
import os

# MongoDB bağlantısı
client = MongoClient("mongodb://localhost:27017/")
db = client["ecommerce"]

# Seeds klasörü
seeds_path = r"C:\Projects\ecommerce-pipeline\ecommerce_pipeline\seeds"

# Yüklenecek dosyalar
files = {
    "orders":      "olist_orders_dataset.csv",
    "customers":   "olist_customers_dataset.csv",
    "order_items": "olist_order_items_dataset.csv",
    "products":    "olist_products_dataset.csv",
    "sellers":     "olist_sellers_dataset.csv",
}

for collection_name, filename in files.items():
    filepath = os.path.join(seeds_path, filename)
    df = pd.read_csv(filepath)
    records = df.to_dict("records")
    
    # Koleksiyonu temizle ve yükle
    db[collection_name].drop()
    db[collection_name].insert_many(records)
    
    print(f"✅ {collection_name}: {len(records)} kayıt yüklendi")

print("\n🎉 Tüm veriler MongoDB'ye yüklendi!")
client.close()