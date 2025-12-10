import pandas as pd

data = [
    {"id": 1, "value": 42},
    {"id": 2, "value": None},
    {"id": 3, "value": 17}
]

valid_records = []
for record in data:
    try:
        if record["value"] is None:
            raise ValueError("Missing value")
        valid_records.append(record)
    except Exception as e:
        print(f"REJECTED record {record['id']}: {e}")

df = pd.DataFrame(valid_records)
df.to_csv("/data/cleaned.csv", index=False)
print(f"INGESTED {len(valid_records)} records successfully")
