import pytest
from app.app import app as flask_app

@pytest.fixture
def client():
    flask_app.config['TESTING'] = True
    with flask_app.test_client() as client:
        yield client

def test_default_route(client):
    response = client.get('/')
    assert response.status_code == 200
    assert b'Enter your name' in response.data

def test_health_endpoint(client):
    response = client.get('/health')
    assert response.status_code == 200
    assert response.data == b'OK'

def test_ready_endpoint(client):
    response = client.get('/ready')
    assert response.status_code == 200
    assert response.data == b'READY'