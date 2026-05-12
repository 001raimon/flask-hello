from flask import Flask, render_template, jsonify
from datetime import datetime, timezone

app = Flask(__name__)

_count = 0


@app.route("/")
def index():
    return render_template("index.html")


@app.route("/api/hi")
def api_hi():
    return jsonify({"message": "Hi!"})


@app.route("/api/time")
def api_time():
    return jsonify({"time": datetime.now(timezone.utc).isoformat()})


@app.route("/api/count")
def api_count():
    global _count
    _count += 1
    return jsonify({"count": _count})


if __name__ == "__main__":
    app.run(debug=True)
