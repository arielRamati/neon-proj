from app import app
import requests
import os

BASE_URL = os.getenv("BASE_URL", "http://neon-proj-neon-proj.default.svc.cluster.local")


def test_greet_shows_name():    
    response = requests.post(
        f"{BASE_URL}/",
        data={'name': 'Neon Tester'},
        allow_redirects=True
    )
    assert response.status_code == 200
    assert 'Hello, Neon Tester' in response.text
