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
