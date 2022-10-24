from flask import Flask
from os import environ

SECRET = environ.get("APP_SECRET_KEY")

if not SECRET:
    print("env 'APP_SECRET_KEY' not found")
    exit(1)

app = Flask(__name__)
app.secret_key = SECRET