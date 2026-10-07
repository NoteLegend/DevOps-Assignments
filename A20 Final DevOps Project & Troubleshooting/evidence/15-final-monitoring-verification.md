# Executed commands and captured output

```bash
#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
cd final-devops-project
# Continue the verified GitOps/monitoring run after metrics-server sampling lag.
curl -fsSG http://127.0.0.1:9090/api/v1/query --data-urlencode query=up > ../evidence/final-targets-up.json
python -c "import json; x=json.load(open('../evidence/final-targets-up.json'))['data']['result']; assert len(x)==2 and all(r['value'][1]=='1' for r in x); print('Both monitoring targets are UP')"
for query in 'up' 'application_requests_total' 'process_cpu_seconds_total' 'process_peak_memory_bytes' '100*(1-avg(rate(node_cpu_seconds_total{mode="idle"}[1m])))' '100*(1-node_memory_MemAvailable_bytes/node_memory_MemTotal_bytes)'; do curl -fsSG http://127.0.0.1:9090/api/v1/query --data-urlencode "query=$query"; done
kubectl -n a20 logs deployment/final-app --tail=10
for attempt in $(seq 1 30); do
  if kubectl -n a20 top pods; then break; fi
  if [[ $attempt == 30 ]]; then exit 1; fi
  sleep 3
done
/tmp/devops-tools-venv/bin/python ../../../.local-tools/evidence.py .. 06-final-monitoring-targets --url http://127.0.0.1:9090/targets
# Actual monitoring transport failure: disconnect the local forwarded target.
../../../.local-tools/vm.sh 'kill "$(cat /tmp/devops-a20-forward.pid)"'
sleep 20
curl -fsS http://127.0.0.1:9090/api/v1/alerts | tee ../evidence/final-alert-firing.json
python -c "import json; assert any(x['state']=='firing' for x in json.load(open('../evidence/final-alert-firing.json'))['data']['alerts'])"
/tmp/devops-tools-venv/bin/python ../../../.local-tools/evidence.py .. 07-final-monitoring-alert --url http://127.0.0.1:9090/alerts
../../../.local-tools/vm.sh 'nohup kubectl -n a20 port-forward --address=0.0.0.0 svc/final-app 8091:80 >/tmp/devops-a20-forward.log 2>&1 </dev/null & echo $! >/tmp/devops-a20-forward.pid'
sleep 15
curl -fsS http://127.0.0.1:8091/health
curl -fsS http://127.0.0.1:9090/api/v1/alerts | tee ../evidence/final-alert-recovered.json
python -c "import json; assert not json.load(open('../evidence/final-alert-recovered.json'))['data']['alerts']"
docker rm -f devops-a20-node devops-a20-prom
../../../.local-tools/vm.sh 'kill "$(cat /tmp/devops-a20-forward.pid)"'
kubectl delete namespace a20

```

```text
Executed 2026-10-07T14:46:17.337024+05:30
Working directory: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-20-Session-21
Script: monitoring-final-verification.sh
Exit status: 0

+ source ../../.local-tools/env.sh
++ _devops_trace=0
++ case $- in
++ _devops_trace=1
++ set +x
++ unset _devops_trace
+ cd final-devops-project
+ curl -fsSG http://127.0.0.1:9090/api/v1/query --data-urlencode query=up
+ python -c 'import json; x=json.load(open('\''../evidence/final-targets-up.json'\''))['\''data'\'']['\''result'\'']; assert len(x)==2 and all(r['\''value'\''][1]=='\''1'\'' for r in x); print('\''Both monitoring targets are UP'\'')'
Both monitoring targets are UP
+ for query in 'up' 'application_requests_total' 'process_cpu_seconds_total' 'process_peak_memory_bytes' '100*(1-avg(rate(node_cpu_seconds_total{mode="idle"}[1m])))' '100*(1-node_memory_MemAvailable_bytes/node_memory_MemTotal_bytes)'
+ curl -fsSG http://127.0.0.1:9090/api/v1/query --data-urlencode query=up
{"status":"success","data":{"resultType":"vector","result":[{"metric":{"__name__":"up","instance":"127.0.0.1:9100","job":"local-node"},"value":[1791364479.884,"1"]},{"metric":{"__name__":"up","instance":"127.0.0.1:8091","job":"application"},"value":[1791364479.884,"1"]}]}}+ for query in 'up' 'application_requests_total' 'process_cpu_seconds_total' 'process_peak_memory_bytes' '100*(1-avg(rate(node_cpu_seconds_total{mode="idle"}[1m])))' '100*(1-node_memory_MemAvailable_bytes/node_memory_MemTotal_bytes)'
+ curl -fsSG http://127.0.0.1:9090/api/v1/query --data-urlencode query=application_requests_total
{"status":"success","data":{"resultType":"vector","result":[{"metric":{"__name__":"application_requests_total","instance":"127.0.0.1:8091","job":"application"},"value":[1791364479.894,"52"]}]}}+ for query in 'up' 'application_requests_total' 'process_cpu_seconds_total' 'process_peak_memory_bytes' '100*(1-avg(rate(node_cpu_seconds_total{mode="idle"}[1m])))' '100*(1-node_memory_MemAvailable_bytes/node_memory_MemTotal_bytes)'
+ curl -fsSG http://127.0.0.1:9090/api/v1/query --data-urlencode query=process_cpu_seconds_total
{"status":"success","data":{"resultType":"vector","result":[{"metric":{"__name__":"process_cpu_seconds_total","instance":"127.0.0.1:9100","job":"local-node"},"value":[1791364479.905,"0.25"]},{"metric":{"__name__":"process_cpu_seconds_total","instance":"127.0.0.1:8091","job":"application"},"value":[1791364479.905,"1.553626"]}]}}+ for query in 'up' 'application_requests_total' 'process_cpu_seconds_total' 'process_peak_memory_bytes' '100*(1-avg(rate(node_cpu_seconds_total{mode="idle"}[1m])))' '100*(1-node_memory_MemAvailable_bytes/node_memory_MemTotal_bytes)'
+ curl -fsSG http://127.0.0.1:9090/api/v1/query --data-urlencode query=process_peak_memory_bytes
{"status":"success","data":{"resultType":"vector","result":[{"metric":{"__name__":"process_peak_memory_bytes","instance":"127.0.0.1:8091","job":"application"},"value":[1791364479.914,"35885056"]}]}}+ for query in 'up' 'application_requests_total' 'process_cpu_seconds_total' 'process_peak_memory_bytes' '100*(1-avg(rate(node_cpu_seconds_total{mode="idle"}[1m])))' '100*(1-node_memory_MemAvailable_bytes/node_memory_MemTotal_bytes)'
+ curl -fsSG http://127.0.0.1:9090/api/v1/query --data-urlencode 'query=100*(1-avg(rate(node_cpu_seconds_total{mode="idle"}[1m])))'
{"status":"success","data":{"resultType":"vector","result":[{"metric":{},"value":[1791364479.923,"18.962887999999978"]}]}}+ for query in 'up' 'application_requests_total' 'process_cpu_seconds_total' 'process_peak_memory_bytes' '100*(1-avg(rate(node_cpu_seconds_total{mode="idle"}[1m])))' '100*(1-node_memory_MemAvailable_bytes/node_memory_MemTotal_bytes)'
+ curl -fsSG http://127.0.0.1:9090/api/v1/query --data-urlencode 'query=100*(1-node_memory_MemAvailable_bytes/node_memory_MemTotal_bytes)'
{"status":"success","data":{"resultType":"vector","result":[{"metric":{"instance":"127.0.0.1:9100","job":"local-node"},"value":[1791364479.933,"24.340228539256657"]}]}}+ kubectl -n a20 logs deployment/final-app --tail=10
Found 2 pods, using pod/final-app-69cfbfdb97-jdthn
Defaulted container "app" out of: app, storage-permissions (init)
{"trace_id": "a8b919aaa6c64150b023741df0db2a8d", "path": "/health", "status": 200, "duration_ms": 0.2}
10.244.0.1 - - [07/Oct/2026 09:14:33] "GET /health HTTP/1.1" 200 -
{"trace_id": "8ef348a551b24df18f903ebf2fc6f149", "path": "/health", "status": 200, "duration_ms": 0.239}
10.244.0.1 - - [07/Oct/2026 09:14:35] "GET /health HTTP/1.1" 200 -
{"trace_id": "65d9111ee90d45d9ba5245696a031414", "path": "/metrics", "status": 200, "duration_ms": 0.141}
127.0.0.1 - - [07/Oct/2026 09:14:36] "GET /metrics HTTP/1.1" 200 -
{"trace_id": "47de1e1f57944e4aa1a3dd1c60a08f76", "path": "/health", "status": 200, "duration_ms": 0.189}
10.244.0.1 - - [07/Oct/2026 09:14:38] "GET /health HTTP/1.1" 200 -
{"trace_id": "9f89873cfc3549dba61efe4440ddf1b2", "path": "/health", "status": 200, "duration_ms": 0.152}
10.244.0.1 - - [07/Oct/2026 09:14:38] "GET /health HTTP/1.1" 200 -
++ seq 1 30
+ for attempt in $(seq 1 30)
+ kubectl -n a20 top pods
NAME                         CPU(cores)   MEMORY(bytes)   
final-app-69cfbfdb97-2wnd5   27m          22Mi            
final-app-69cfbfdb97-jdthn   15m          22Mi            
+ break
+ /tmp/devops-tools-venv/bin/python ../../../.local-tools/evidence.py .. 06-final-monitoring-targets --url http://127.0.0.1:9090/targets
+ ../../../.local-tools/vm.sh 'kill "$(cat /tmp/devops-a20-forward.pid)"'
+ sleep 20
+ curl -fsS http://127.0.0.1:9090/api/v1/alerts
+ tee ../evidence/final-alert-firing.json
{"status":"success","data":{"alerts":[{"labels":{"alertname":"ApplicationDown","instance":"127.0.0.1:8091","job":"application","severity":"critical"},"annotations":{"summary":"Local assignment application is unavailable"},"state":"firing","activeAt":"2026-10-07T09:14:50.847299963Z","value":"0e+00"}]}}+ python -c 'import json; assert any(x['\''state'\'']=='\''firing'\'' for x in json.load(open('\''../evidence/final-alert-firing.json'\''))['\''data'\'']['\''alerts'\''])'
+ /tmp/devops-tools-venv/bin/python ../../../.local-tools/evidence.py .. 07-final-monitoring-alert --url http://127.0.0.1:9090/alerts
+ ../../../.local-tools/vm.sh 'nohup kubectl -n a20 port-forward --address=0.0.0.0 svc/final-app 8091:80 >/tmp/devops-a20-forward.log 2>&1 </dev/null & echo $! >/tmp/devops-a20-forward.pid'
+ sleep 15
+ curl -fsS http://127.0.0.1:8091/health
{"secret_injected":true,"status":"healthy","version":"v2"}
+ curl -fsS http://127.0.0.1:9090/api/v1/alerts
+ tee ../evidence/final-alert-recovered.json
{"status":"success","data":{"alerts":[]}}+ python -c 'import json; assert not json.load(open('\''../evidence/final-alert-recovered.json'\''))['\''data'\'']['\''alerts'\'']'
+ docker rm -f devops-a20-node devops-a20-prom
devops-a20-node
devops-a20-prom
+ ../../../.local-tools/vm.sh 'kill "$(cat /tmp/devops-a20-forward.pid)"'
+ kubectl delete namespace a20
namespace "a20" deleted

```
