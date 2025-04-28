FROM python:3.10-slim

RUN apt update && apt install -y --no-install-recommends \
    pkg-config \
    git \
    libicu-dev \
    gcc \
    g++ \
    libtk8.6 \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "main.py"]