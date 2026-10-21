from flask import Flask, jsonify, request, g
from pathlib import Path
import os, time, uuid, json, hashlib, resource, html
app = Flask(__name__)
requests_total = 0
@app.before_request
def begin():
    global requests_total
    requests_total += 1
    g.started = time.monotonic()
    g.trace_id = uuid.uuid4().hex
@app.after_request
def finish(response):
    print(json.dumps({'trace_id':g.trace_id, 'path':request.path,'status':response.status_code,'duration_ms':round((time.monotonic()-g.started)*1000,3)}),flush=True)
    response.headers['X-Trace-ID'] = g.trace_id
    return response
@app.get('/')
def index():
    message = html.escape(os.environ.get('APP_MESSAGE','Final DevOps application'))
    version = html.escape(os.environ.get('VERSION','v1'))
    return f'<h1>{message}</h1><p>Version: {version}</p><p>Live endpoints: /health /metrics /storage</p>'
@app.get('/health')
def health():
    return jsonify(status='healthy', version=os.environ.get('VERSION','v1'), secret_injected=bool(os.environ.get('APP_SECRET')))
@app.get('/metrics')
def metrics():
    usage=resource.getrusage(resource.RUSAGE_SELF)
    return f'# TYPE application_requests_total counter\napplication_requests_total {requests_total}\nprocess_cpu_seconds_total {usage.ru_utime+usage.ru_stime}\nprocess_peak_memory_bytes {usage.ru_maxrss*1024}\n',200,{'Content-Type':'text/plain; version=0.0.4; charset=utf-8'}
@app.get('/load')
def load():
    until=time.monotonic()+0.04
    while time.monotonic()<until:
        hashlib.sha256(b'bounded local HPA demonstration').digest()
    return jsonify(computed=True)
@app.route('/storage',methods=['GET','POST'])
def storage():
    directory=Path(os.environ.get('DATA_DIR','./runtime-data'))
    marker=directory/'marker.txt'
    if request.method=='POST':
        value=(request.get_json(silent=True) or {}).get('marker')
        if not isinstance(value,str) or len(value)>120:
            return jsonify(error='marker must be a string of at most 120 characters'),400
        directory.mkdir(parents=True,exist_ok=True)
        marker.write_text(value)
    return jsonify(marker=marker.read_text() if marker.exists() else '')
if __name__=='__main__':
    app.run(host=os.environ.get('APP_HOST','127.0.0.1'),port=8080)
