# app.py
from flask import Flask
app = Flask(__name__)

@app.route("/")
def home():
    return "<h1>harness-demo-app</h1><p>Deployed via Harness CI/CD</p>", 200

@app.route("/health")
def health():
    return {"status": "ok"}, 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

