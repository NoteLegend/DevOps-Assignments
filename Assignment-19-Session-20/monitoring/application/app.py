from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
import time, json, uuid
requests = 0
class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        global requests
        started = time.monotonic(); trace_id = uuid.uuid4().hex; requests += 1
        if self.path == '/metrics':
            body = f'# TYPE application_requests_total counter\napplication_requests_total {requests}\n'.encode()
        elif self.path == '/health':
            body = b'{"status":"healthy"}'
        else:
            body = b'<h1>Local monitoring application</h1><p>/health and /metrics are live endpoints.</p>'
        self.send_response(200)
        content_type = 'text/plain; version=0.0.4; charset=utf-8' if self.path == '/metrics' else ('application/json' if self.path == '/health' else 'text/html')
        self.send_header('Content-Type',content_type)
        self.end_headers(); self.wfile.write(body)
        print(json.dumps({'trace_id':trace_id,'path':self.path,'status':200,'duration_ms':round((time.monotonic()-started)*1000,3)}),flush=True)
    def log_message(self, *args):
        pass
if __name__ == '__main__':
    ThreadingHTTPServer(('0.0.0.0',8090),Handler).serve_forever()
