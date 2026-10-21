from flask import Flask, jsonify, request
app = Flask(__name__)
@app.get('/')
def index():
    return '<h1>DevSecOps local application</h1><p>Actual build, tests and scans are in evidence/.</p>'
@app.get('/health')
def health():
    return jsonify(status='healthy')
@app.post('/add')
def add():
    data = request.get_json(silent=True) or {}
    a, b = data.get('a'), data.get('b')
    if not isinstance(a, (int, float)) or not isinstance(b, (int, float)):
        return jsonify(error='a and b must be numbers'), 400
    return jsonify(result=a+b)
