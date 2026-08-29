from flask import Flask, jsonify
import os
import psycopg2

app = Flask(__name__)


def get_db_connection():
    return psycopg2.connect(
        host=os.getenv("DB_HOST"),
        port=os.getenv("DB_PORT", "5432"),
        database=os.getenv("DB_NAME", "appdb"),
        user=os.getenv("DB_USER", "appuser"),
        password=os.getenv("DB_PASSWORD"),
    )


@app.route("/")
def home():
    return jsonify({
        "application": "8Byte DevOps Assignment",
        "status": "running"
    })


@app.route("/health")
def health():
    return jsonify({
        "status": "healthy"
    })


@app.route("/db-health")
def db_health():
    try:
        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.execute("SELECT 1")
        result = cursor.fetchone()
        cursor.close()
        connection.close()

        if result == (1,):
            return jsonify({
                "database": "connected"
            })

        return jsonify({
            "database": "connection failed"
        }), 500

    except Exception as error:
        return jsonify({
            "database": "connection failed",
            "error": str(error)
        }), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)