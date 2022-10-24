FROM python:3.9.15-slim-bullseye 

LABEL org.opencontainers.image.source=https://github.com/UZziell/Blur-Detection-Web-App
LABEL org.opencontainers.image.description="Blur Detection webapp"

ENV FLASK_RUN_HOST=0.0.0.0 FLASK_RUN_PORT=5000 FLASK_DEBUG=true FLASK_APP=main.py

WORKDIR /usr/src/app
RUN adduser --system --no-create-home nonroot

# RUN apt-get update && apt-get install -y --no-install-recommends libglib2.0-0 libgl1; rm -rf /var/lib/apt/lists/* 

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . ./

USER nonroot
CMD ["flask", "run"]