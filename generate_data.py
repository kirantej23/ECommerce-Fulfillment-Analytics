import pandas as pd
import numpy as np
from faker import Faker
import random

fake = Faker()
num_records = 100000

print("Generating 100,000 records... please wait...")

data = {
    'order_id': [f"ORD{str(i).zfill(6)}" for i in range(1, num_records + 1)],
    'customer_id': [f"CUST{str(random.randint(1000, 9999))}" for _ in range(num_records)],
    'order_date': [fake.date_between(start_date='-1y', end_date='today') for _ in range(num_records)],
    'fulfillment_status': np.random.choice(['Shipped', 'Delivered', 'Cancelled', 'Processing'], p=[0.1, 0.8, 0.05, 0.05], size=num_records),
    'ship_mode': np.random.choice(['Standard', 'Express', 'Same Day'], p=[0.7, 0.2, 0.1], size=num_records),
    'product_category': np.random.choice(['Electronics', 'Clothing', 'Home Decor', 'Beauty', 'Toys'], size=num_records),
    'order_value': np.round(np.random.uniform(10, 500, size=num_records), 2),
    'delivery_region': np.random.choice(['North', 'South', 'East', 'West', 'Central'], size=num_records),
    'customer_rating': np.random.choice([1, 2, 3, 4, 5], p=[0.05, 0.08, 0.12, 0.35, 0.40], size=num_records)
}

df = pd.DataFrame(data)

# Convert to datetime
df['order_date'] = pd.to_datetime(df['order_date'])

# Base delivery days based on shipping modes
df['delivery_days'] = np.where(df['ship_mode'] == 'Same Day', 0,
                       np.where(df['ship_mode'] == 'Express', np.random.randint(1, 3, size=num_records),
                                np.random.randint(3, 8, size=num_records)))

# Inject an intentional operational bottleneck: North region Standard shipping takes much longer
north_standard_mask = (df['delivery_region'] == 'North') & (df['ship_mode'] == 'Standard')
df.loc[north_standard_mask, 'delivery_days'] += np.random.randint(4, 9, size=df[north_standard_mask].shape[0])

# Calculate final delivery dates and SLA metrics
df['delivery_date'] = df['order_date'] + pd.to_timedelta(df['delivery_days'], unit='D')
# SLA Target: On time if delivered within 5 days
df['on_time_delivery'] = np.where(df['delivery_days'] <= 5, 1, 0)

# Export to CSV
df.to_csv('ecommerce_fulfillment_data.csv', index=False)
print("Dataset 'ecommerce_fulfillment_data.csv' generated successfully!")