FROM python:3.10-slim

# Install system dependencies for pyICU and pycld2
RUN apt-get update && apt-get install -y \
    libicu-dev \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Start the bot
CMD ["python", "main.py"]
