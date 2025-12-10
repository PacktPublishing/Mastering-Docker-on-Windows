from fastapi import FastAPI
import onnxruntime as ort

model = ort.InferenceSession("model.onnx")
app = FastAPI()

@app.post("/predict")
async def predict(data: dict):
    inputs = data["inputs"]
    output = model.run(None, {"input": inputs})
    return {"output": output}
