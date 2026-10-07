#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
cd final-devops-project
git -C gitops/desired init -b main
git -C gitops/desired config user.name 'DevOps Practical'
git -C gitops/desired config user.email 'practical@example.invalid'
git -C gitops/desired add deployment.yaml
git -C gitops/desired commit -m 'Declare verified final application in local Git'
../../../.local-tools/vm.sh 'nohup python3 /workspace/DevOps-Assignments/Assignment-20-Session-21/final-devops-project/gitops/reconcile.py >/tmp/devops-a20-reconcile.log 2>&1 </dev/null & echo $! >/tmp/devops-a20-reconcile.pid'
sleep 10
kubectl -n a20 rollout status deployment/final-app --timeout=180s
kubectl -n a20 set env deployment/final-app VERSION=manual-drift
sleep 10
kubectl -n a20 rollout status deployment/final-app --timeout=180s
kubectl -n a20 get deployment final-app -o jsonpath='{.spec.template.spec.containers[0].env[0].value}{"\n"}' | grep '^v1$'
sed -i 's/value: v1/value: v2/' gitops/desired/deployment.yaml
git -C gitops/desired add deployment.yaml
git -C gitops/desired commit -m 'Promote final app to v2 through desired Git state'
sleep 10
kubectl -n a20 rollout status deployment/final-app --timeout=180s
kubectl -n a20 exec deployment/final-app -- python -c "import urllib.request;print(urllib.request.urlopen('http://final-app/health').read().decode())" | grep v2
../../../.local-tools/vm.sh 'cat /tmp/devops-a20-reconcile.log; kill "$(cat /tmp/devops-a20-reconcile.pid)"'
git -C gitops/desired log --oneline
git -C gitops/desired remote -v
git -C gitops/desired bundle create ../history.bundle --all
git -C gitops/desired bundle verify ../history.bundle
# Forward the current, GitOps-updated Pod to the monitoring target.
../../../.local-tools/vm.sh 'kill "$(cat /tmp/devops-a20-forward.pid)" 2>/dev/null || true; nohup kubectl -n a20 port-forward --address=0.0.0.0 svc/final-app 8091:80 >/tmp/devops-a20-forward.log 2>&1 </dev/null & echo $! >/tmp/devops-a20-forward.pid'
curl --retry 15 --retry-all-errors --retry-delay 2 --max-time 10 -fsS http://127.0.0.1:8091/health
docker run -d --name devops-a20-node --label assignment=20 --network host --pid host -v /:/host:ro,rslave prom/node-exporter:v1.10.2 --path.rootfs=/host
docker run -d --name devops-a20-prom --label assignment=20 --network host -v /workspace/DevOps-Assignments/Assignment-20-Session-21/final-devops-project/monitoring/prometheus.yml:/etc/prometheus/prometheus.yml:ro -v /workspace/DevOps-Assignments/Assignment-20-Session-21/final-devops-project/monitoring/alerts.yml:/etc/prometheus/alerts.yml:ro prom/prometheus:v3.5.0
curl --retry 20 --retry-all-errors --retry-delay 2 --max-time 10 -fsS http://127.0.0.1:9090/-/ready
sleep 20
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
