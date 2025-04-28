FROM python:3.10-slim

<<<<<<< HEAD
RUN apt update && apt install -y --no-install-recommends \
=======
RUN apt update && apt install -y \
>>>>>>> 85bb86c (add)
    pkg-config \
    git \
    libicu-dev \
    gcc \
    g++ \
    libtk8.6 \
    libgl1-mesa-glx \
    libglib2.0-0 \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

WORKDIR /app

COPY requirements.txt .

<<<<<<< HEAD
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "main.py"]
=======
RUN pip install -r requirements.txt

COPY . .

CMD ["python", "main.py"]
>>>>>>> 85bb86c (add)
