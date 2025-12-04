from app.app import app
import requests

BASE_URL = "http://localhost:8080"

def test_greet_shows_name():    
    response = requests.post(
        f"{BASE_URL}/",
        data={'name': 'Neon Tester'},
        allow_redirects=True
    )
    assert response.status_code == 200
    assert 'Hello, Neon Tester' in response.text
