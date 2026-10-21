from application.app import app

def test_home():
    assert b'Final DevOps' in app.test_client().get('/').data
def test_health():
    response=app.test_client().get('/health')
    assert response.json['status']=='healthy'
    assert 'X-Trace-ID' in response.headers
def test_metrics():
    assert b'application_requests_total' in app.test_client().get('/metrics').data
def test_storage(tmp_path,monkeypatch):
    monkeypatch.setenv('DATA_DIR',str(tmp_path))
    client=app.test_client()
    assert client.post('/storage',json={'marker':'persistent-test'}).json['marker']=='persistent-test'
    assert client.get('/storage').json['marker']=='persistent-test'
def test_storage_rejects_invalid():
    assert app.test_client().post('/storage',json={'marker':123}).status_code==400
