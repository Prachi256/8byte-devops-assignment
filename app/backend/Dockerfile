FROM python:3.12-slim

WORKDIR /app

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY app/backend/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY app/backend/app.py .

COPY tests /app/tests

EXPOSE 5000

CMD ["python", "app.py"]