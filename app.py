from flask import Flask
import os


app = Flask(__name__)


ENVIRONMENT = os.environ.get("APP_ENV", "unknown")


@app.route("/")
def home():
    return f"<h1>harness-demo-app</h1><p>Deployed via Harness CI/CD — {ENVIRONMENT}</p>", 200


@app.route("/health")
def health():
    return {"status": "ok", "environment": ENVIRONMENT}, 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
