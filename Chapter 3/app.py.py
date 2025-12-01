from flask import Flask, request, jsonify 
import json, os

app = Flask(__name__) 
DATA_FILE = "/data/notes.json"

@app.get("/notes") 
def get_notes(): 
    if not os.path.exists(DATA_FILE): 
        return jsonify([]) 
    with open(DATA_FILE, "r") as f: 
        return jsonify(json.load(f))

@app.post("/notes") 
def add_note(): 
    payload = request.json 
    note = payload.get("note") 
    notes = [] 
    if os.path.exists(DATA_FILE): 
        with open(DATA_FILE, "r") as f: 
            notes = json.load(f) 
    notes.append(note) 
    with open(DATA_FILE, "w") as f: 
        json.dump(notes, f) 
    return {"status": "ok", "count": len(notes)}

if __name__ == "__main__": 
    app.run(host="0.0.0.0", port=5000)
