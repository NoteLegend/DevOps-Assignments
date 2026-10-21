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
