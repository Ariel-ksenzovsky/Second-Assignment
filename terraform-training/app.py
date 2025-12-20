from flask import Flask, jsonify, request
import os
import time
import pymysql

app = Flask(__name__)

DB_HOST = os.getenv("DATABASE_HOST", "mysql-db")
DB_PORT = int(os.getenv("DATABASE_PORT", "3306"))
DB_USER = os.getenv("DATABASE_USER", "sqladminuser")
DB_PASS = os.getenv("DATABASE_PASSWORD", "StrongSqlAdminPass123!")
DB_NAME = os.getenv("DATABASE_NAME", "mydb")


def get_connection():
    last = None
    for i in range(20):
        try:
            return pymysql.connect(
                host=DB_HOST,
                port=DB_PORT,
                user=DB_USER,
                password=DB_PASS,
                database=DB_NAME,
                connect_timeout=5,
            )
        except Exception as e:
            last = e
            print(f"MySQL not ready yet ({i+1}/20): {e}")
            time.sleep(2)
    raise last


@app.route("/")
def index():
    try:
        conn = get_connection()
        with conn.cursor() as cur:
            cur.execute("SELECT 1;")
            row = cur.fetchone()
        conn.close()
        return f"✅ MySQL connection OK (SELECT 1 => {row[0]})"
    except Exception as e:
        return f"❌ MySQL connection error: {repr(e)}", 500


@app.route("/messages")
def messages():
    try:
        conn = get_connection()
        with conn.cursor() as cur:
            cur.execute("SELECT messagesText FROM Messages LIMIT 50;")
            rows = cur.fetchall()
        conn.close()
        msgs = [r[0] for r in rows]
        return jsonify(messages=msgs)
    except Exception as e:
        return jsonify(error=repr(e)), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
