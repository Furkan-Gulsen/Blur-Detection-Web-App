FROM python:3.9.15-bullseye
ENV FLASK_RUN_HOST=0.0.0.0 FLASK_RUN_PORT=5000 FLASK_DEBUG=true FLASK_APP=main.py

WORKDIR /usr/src/app
RUN adduser --system --no-create-home nonroot

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

RUN apt-get update && apt-get install -y --no-install-recommends libgl1; rm -rf /var/lib/apt/lists/* 

COPY . ./

USER nonroot
CMD ["flask", "run"]