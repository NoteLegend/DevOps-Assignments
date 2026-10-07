# Executed commands and captured output

```bash
#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
docker build -t devops-a19-monitor:local monitoring
docker run -d --name devops-a19-app --label assignment=19 --network host devops-a19-monitor:local
docker run -d --name devops-a19-node --label assignment=19 --network host --pid host -v /:/host:ro,rslave prom/node-exporter:v1.10.2 --path.rootfs=/host
docker run -d --name devops-a19-prom --label assignment=19 --network host -v /workspace/DevOps-Assignments/Assignment-19-Session-20/monitoring/prometheus.yml:/etc/prometheus/prometheus.yml:ro -v /workspace/DevOps-Assignments/Assignment-19-Session-20/monitoring/alerts.yml:/etc/prometheus/alerts.yml:ro prom/prometheus:v3.5.0
curl --retry 20 --retry-all-errors --retry-delay 2 --max-time 10 -fsS http://127.0.0.1:8090/health
curl --retry 20 --retry-all-errors --retry-delay 2 --max-time 10 -fsS http://127.0.0.1:9090/-/ready
sleep 15
curl -fsSG http://127.0.0.1:9090/api/v1/query --data-urlencode 'query=up' | tee evidence/targets.json
python -c "import json; v=json.load(open('evidence/targets.json'))['data']['result'];assert len(v)==2 and all(x['value'][1]=='1' for x in v)"
curl -fsSG http://127.0.0.1:9090/api/v1/query --data-urlencode 'query=100*(1-avg(rate(node_cpu_seconds_total{mode="idle"}[1m])))' | tee evidence/cpu.json
curl -fsSG http://127.0.0.1:9090/api/v1/query --data-urlencode 'query=100*(1-node_memory_MemAvailable_bytes/node_memory_MemTotal_bytes)' | tee evidence/memory.json
curl -fsSG http://127.0.0.1:9090/api/v1/query --data-urlencode 'query=application_requests_total' | tee evidence/requests.json
docker logs --tail 12 devops-a19-app
/tmp/devops-tools-venv/bin/python ../../.local-tools/evidence.py . 02-prometheus-targets --url http://127.0.0.1:9090/targets
docker stop devops-a19-app
sleep 20
curl -fsS http://127.0.0.1:9090/api/v1/alerts | tee evidence/alerts-firing.json
python -c "import json; a=json.load(open('evidence/alerts-firing.json')); assert any(x['state']=='firing' for x in a['data']['alerts'])"
/tmp/devops-tools-venv/bin/python ../../.local-tools/evidence.py . 03-prometheus-alert --url http://127.0.0.1:9090/alerts
docker start devops-a19-app
sleep 15
curl -fsS http://127.0.0.1:8090/health
curl -fsS http://127.0.0.1:9090/api/v1/alerts | tee evidence/alerts-recovered.json
python -c "import json; assert not json.load(open('evidence/alerts-recovered.json'))['data']['alerts']"
docker ps --filter label=assignment=19
docker rm -f devops-a19-app devops-a19-prom devops-a19-node

```

```text
Executed 2026-10-07T14:22:20.411651+05:30
Working directory: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-19-Session-20
Script: monitoring.sh
Exit status: 0

+ source ../../.local-tools/env.sh
++ _devops_trace=0
++ case $- in
++ _devops_trace=1
++ set +x
++ unset _devops_trace
+ docker build -t devops-a19-monitor:local monitoring
#0 building with "default" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 140B 0.0s done
#1 DONE 0.1s

#2 [internal] load metadata for docker.io/library/python:3.12-slim
#2 DONE 1.6s

#3 [internal] load .dockerignore
#3 transferring context: 2B 0.0s done
#3 DONE 0.1s

#4 [internal] load build context
#4 transferring context: 1.29kB 0.0s done
#4 DONE 0.1s

#5 [1/3] FROM docker.io/library/python:3.12-slim@sha256:05cda9777409a9c3ffddd94a4c476b79f0769a0b4857f0c7ed9226b6800b0d6f
#5 resolve docker.io/library/python:3.12-slim@sha256:05cda9777409a9c3ffddd94a4c476b79f0769a0b4857f0c7ed9226b6800b0d6f
#5 resolve docker.io/library/python:3.12-slim@sha256:05cda9777409a9c3ffddd94a4c476b79f0769a0b4857f0c7ed9226b6800b0d6f 0.2s done
#5 DONE 0.2s

#6 [2/3] WORKDIR /app
#6 CACHED

#7 [3/3] COPY application/app.py .
#7 DONE 0.3s

#8 exporting to image
#8 exporting layers
#8 exporting layers 0.6s done
#8 exporting manifest sha256:0960338f8858eeb8ef8ba29ac95ad4fa2ca6b5b1dcff35498cbca39b4d779a07 0.1s done
#8 exporting config sha256:a05b9383e0a6fced6cb4bbf27f4d82dcc22fea0fb201f6c4e0465ca7bdaab361
#8 exporting config sha256:a05b9383e0a6fced6cb4bbf27f4d82dcc22fea0fb201f6c4e0465ca7bdaab361 0.1s done
#8 exporting attestation manifest sha256:99642489bd21e46121cdb770314d11c84c45b01fcfbfad10e5ba9d2d8a3f4fb1
#8 exporting attestation manifest sha256:99642489bd21e46121cdb770314d11c84c45b01fcfbfad10e5ba9d2d8a3f4fb1 0.3s done
#8 exporting manifest list sha256:c99ab82949e2baf332bfc3fbdf490db1a436b47d6813fa6eb596c279fcd6547a
#8 exporting manifest list sha256:c99ab82949e2baf332bfc3fbdf490db1a436b47d6813fa6eb596c279fcd6547a 0.1s done
#8 naming to docker.io/library/devops-a19-monitor:local
#8 naming to docker.io/library/devops-a19-monitor:local 0.0s done
#8 unpacking to docker.io/library/devops-a19-monitor:local 0.1s done
#8 DONE 1.6s
+ docker run -d --name devops-a19-app --label assignment=19 --network host devops-a19-monitor:local
e34119e315c1e04ac3731cf81db9d7cb72420500ca1922d6ccd4a0622aa0df53
+ docker run -d --name devops-a19-node --label assignment=19 --network host --pid host -v /:/host:ro,rslave prom/node-exporter:v1.10.2 --path.rootfs=/host
080163ef076fcae5607d3230310e34a416c1c91e0b0a961633a3d73409384571
+ docker run -d --name devops-a19-prom --label assignment=19 --network host -v /workspace/DevOps-Assignments/Assignment-19-Session-20/monitoring/prometheus.yml:/etc/prometheus/prometheus.yml:ro -v /workspace/DevOps-Assignments/Assignment-19-Session-20/monitoring/alerts.yml:/etc/prometheus/alerts.yml:ro prom/prometheus:v3.5.0
0f435038d78c89e38645793bfd6fba655ea6f78caf6ee815f47ca44168a3d722
+ curl --retry 20 --retry-all-errors --retry-delay 2 --max-time 10 -fsS http://127.0.0.1:8090/health
{"status":"healthy"}+ curl --retry 20 --retry-all-errors --retry-delay 2 --max-time 10 -fsS http://127.0.0.1:9090/-/ready
Prometheus Server is Ready.
+ sleep 15
+ curl -fsSG http://127.0.0.1:9090/api/v1/query --data-urlencode query=up
+ tee evidence/targets.json
{"status":"success","data":{"resultType":"vector","result":[{"metric":{"__name__":"up","instance":"127.0.0.1:8090","job":"application"},"value":[1791363083.837,"1"]},{"metric":{"__name__":"up","instance":"127.0.0.1:9100","job":"local-node"},"value":[1791363083.837,"1"]}]}}+ python -c 'import json; v=json.load(open('\''evidence/targets.json'\''))['\''data'\'']['\''result'\''];assert len(v)==2 and all(x['\''value'\''][1]=='\''1'\'' for x in v)'
+ curl -fsSG http://127.0.0.1:9090/api/v1/query --data-urlencode 'query=100*(1-avg(rate(node_cpu_seconds_total{mode="idle"}[1m])))'
+ tee evidence/cpu.json
{"status":"success","data":{"resultType":"vector","result":[{"metric":{},"value":[1791363083.882,"88.75607499999983"]}]}}+ curl -fsSG http://127.0.0.1:9090/api/v1/query --data-urlencode 'query=100*(1-node_memory_MemAvailable_bytes/node_memory_MemTotal_bytes)'
+ tee evidence/memory.json
{"status":"success","data":{"resultType":"vector","result":[{"metric":{"instance":"127.0.0.1:9100","job":"local-node"},"value":[1791363083.894,"22.52198798695455"]}]}}+ curl -fsSG http://127.0.0.1:9090/api/v1/query --data-urlencode query=application_requests_total
+ tee evidence/requests.json
{"status":"success","data":{"resultType":"vector","result":[{"metric":{"__name__":"application_requests_total","instance":"127.0.0.1:8090","job":"application"},"value":[1791363083.903,"3"]}]}}+ docker logs --tail 12 devops-a19-app
{"trace_id": "89ce0aafbf5f490a89bbd6e95cc4ef0a", "path": "/health", "status": 200, "duration_ms": 0.226}
{"trace_id": "c70e27efc0614f698f9f17dfc4c2a04d", "path": "/metrics", "status": 200, "duration_ms": 0.323}
{"trace_id": "0938f67081da47aebcac200e3a8680bb", "path": "/metrics", "status": 200, "duration_ms": 0.396}
+ /tmp/devops-tools-venv/bin/python ../../.local-tools/evidence.py . 02-prometheus-targets --url http://127.0.0.1:9090/targets
+ docker stop devops-a19-app
devops-a19-app
+ sleep 20
+ curl -fsS http://127.0.0.1:9090/api/v1/alerts
+ tee evidence/alerts-firing.json
{"status":"success","data":{"alerts":[{"labels":{"alertname":"ApplicationDown","instance":"127.0.0.1:8090","job":"application","severity":"critical"},"annotations":{"summary":"Local assignment application is unavailable"},"state":"firing","activeAt":"2026-10-07T08:51:40.847299963Z","value":"0e+00"}]}}+ python -c 'import json; a=json.load(open('\''evidence/alerts-firing.json'\'')); assert any(x['\''state'\'']=='\''firing'\'' for x in a['\''data'\'']['\''alerts'\''])'
+ /tmp/devops-tools-venv/bin/python ../../.local-tools/evidence.py . 03-prometheus-alert --url http://127.0.0.1:9090/alerts
+ docker start devops-a19-app
devops-a19-app
+ sleep 15
+ curl -fsS http://127.0.0.1:8090/health
{"status":"healthy"}+ curl -fsS http://127.0.0.1:9090/api/v1/alerts
+ tee evidence/alerts-recovered.json
{"status":"success","data":{"alerts":[]}}+ python -c 'import json; assert not json.load(open('\''evidence/alerts-recovered.json'\''))['\''data'\'']['\''alerts'\'']'
+ docker ps --filter label=assignment=19
CONTAINER ID   IMAGE                        COMMAND                  CREATED              STATUS              PORTS     NAMES
0f435038d78c   prom/prometheus:v3.5.0       "/bin/prometheus --c…"   About a minute ago   Up About a minute             devops-a19-prom
080163ef076f   prom/node-exporter:v1.10.2   "/bin/node_exporter …"   About a minute ago   Up About a minute             devops-a19-node
e34119e315c1   devops-a19-monitor:local     "python -u app.py"       About a minute ago   Up 15 seconds                 devops-a19-app
+ docker rm -f devops-a19-app devops-a19-prom devops-a19-node
devops-a19-app
devops-a19-prom
devops-a19-node

```
