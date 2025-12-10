FROM python:3.11-slim
WORKDIR /app
RUN pip install fastapi sqlite-utils
COPY storage.py .
CMD ["python", "storage.py"]
