from application.app import app

def test_health():
    assert app.test_client().get('/health').json == {'status':'healthy'}
def test_add():
    assert app.test_client().post('/add',json={'a':10,'b':20}).json['result'] == 30
def test_invalid_input():
    assert app.test_client().post('/add',json={'a':'x'}).status_code == 400
