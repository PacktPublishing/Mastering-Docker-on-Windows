from fastapi import FastAPI
import sqlite3
import os

DB_PATH = "/data/storage.db"
os.makedirs(os.path.dirname(DB_PATH), exist_ok=True)
conn = sqlite3.connect(DB_PATH)
cursor = conn.cursor()

cursor.execute("""
CREATE TABLE IF NOT EXISTS embeddings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    text TEXT NOT NULL,
    vector BLOB NOT NULL
)
""")
conn.commit()

app = FastAPI()

@app.post("/store")
def store_embedding(text: str, vector: bytes):
    cursor.execute("INSERT INTO embeddings (text, vector) VALUES (?, ?)", (text, vector))
    conn.commit()
    return {"status": "stored"}

@app.get("/lookup/{id}")
def get_embedding(id: int):
    cursor.execute("SELECT text, vector FROM embeddings WHERE id = ?", (id,))
    result = cursor.fetchone()
    if result:
        return {"text": result[0], "vector": result[1]}
    return {"error": "Not found"}
