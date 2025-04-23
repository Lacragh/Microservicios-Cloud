# Stage 1: Dependencies  
FROM python:3.11-slim AS builder  
WORKDIR /app  
COPY requirements.txt ./  
RUN pip install --no-cache-dir -r requirements.txt  

# Stage 2: Runtime  
FROM python:3.11-slim  
WORKDIR /app  
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages  
COPY . .  
ENV PYTHONUNBUFFERED=1  
CMD ["python","processor.py"]
