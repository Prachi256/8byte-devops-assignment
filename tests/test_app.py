import sys
import os

# Support both local execution and Docker execution
backend_path = os.path.abspath(
    os.path.join(os.path.dirname(__file__), "..", "app", "backend")
)

if os.path.exists(os.path.join(backend_path, "app.py")):
    sys.path.insert(0, backend_path)
else:
    sys.path.insert(0, "/app")

from app import app


def test_home():
    client = app.test_client()

    response = client.get("/")

    assert response.status_code == 200

    data = response.get_json()

    assert data["status"] == "running"


def test_health():
    client = app.test_client()

    response = client.get("/health")

    assert response.status_code == 200

    data = response.get_json()

    assert data["status"] == "healthy"