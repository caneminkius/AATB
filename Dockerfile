# ===== Stage 1: Build stage =====
FROM python:3.10-slim AS builder

# Install build dependencies
RUN apt update && apt install -y \
    gcc \
    g++ \
    libicu-dev \
    pkg-config \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirement files
COPY requirements.txt .

# Install Python packages into /install
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# ===== Stage 2: Final stage =====
FROM python:3.10-slim

# Install only necessary system dependencies
RUN apt update && apt install -y \
    libicu-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy installed packages from builder stage
COPY --from=builder /install /usr/local

# Copy app code
COPY . .

# Start the bot
CMD ["python", "main.py"]