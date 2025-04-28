FROM python:3.10-slim

# Install system dependencies for Python, pyICU, and pycld2 in one step, clean up cache and temp files
RUN apt update && apt install -y \
    pkg-config \
    git \
    libicu-dev \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && pip install --no-cache-dir -r requirements.txt \
    && rm -rf /root/.cache /tmp/* /usr/local/lib/python3.10/dist-packages/pip && rm -rf /usr/local/lib/python3.10/site-packages/pip

# Set working directory
WORKDIR /app

# Copy only the requirements file first to leverage Docker cache
COPY requirements.txt .

# Copy the application code
COPY . .

# Start the bot
CMD ["python", "main.py"]
