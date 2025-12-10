FROM ubuntu:22.04
RUN apt-get update && apt-get install -y libprotobuf-dev libomp5 && \
    python3 -m pip install --no-cache-dir fastapi uvicorn onnxruntime
