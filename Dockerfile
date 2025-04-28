FROM python:3.10-slim

RUN apt update && apt install -y --no-install-recommends \
    pkg-config \
    git \
    libicu-dev \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt \
    && rm -rf /root/.cache /tmp/* /usr/local/lib/python3.10/dist-packages/pip

COPY . .

CMD ["python", "main.py"]