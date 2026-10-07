#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
cd final-devops-project
kubectl create namespace a20
kubectl -n a20 create secret generic final-secret --from-file=value=/workspace/.local-tools/runtime/secret-good
kubectl -n a20 apply --dry-run=server -f kubernetes
kubectl -n a20 apply -f kubernetes
kubectl -n a20 rollout status deployment/final-app --timeout=180s
kubectl -n a20 exec deployment/final-app -- python -c "import urllib.request;print(urllib.request.urlopen('http://final-app/health').read().decode())"
../../../.local-tools/vm.sh 'nohup kubectl -n a20 port-forward --address=0.0.0.0 svc/final-app 8091:80 >/tmp/devops-a20-forward.log 2>&1 </dev/null & echo $! >/tmp/devops-a20-forward.pid'
curl --retry 15 --retry-all-errors --retry-delay 2 --max-time 10 -fsS http://127.0.0.1:8091/health
/tmp/devops-tools-venv/bin/python ../../../.local-tools/evidence.py .. 02-final-application --url http://127.0.0.1:8091
node_ip=$(minikube -p devops-course ip)
../../../.local-tools/vm.sh "curl -fsS -H 'Host: final.local' http://$node_ip/health"
kubectl -n a20 exec deployment/final-app -- python -c "import urllib.request; r=urllib.request.Request('http://final-app/storage',data=b'{\"marker\":\"actual-persistence-check\"}',headers={'Content-Type':'application/json'});print(urllib.request.urlopen(r).read().decode())"
pod=$(kubectl -n a20 get pods -l app=final-app -o jsonpath='{.items[0].metadata.name}')
kubectl -n a20 delete pod "$pod"
kubectl -n a20 rollout status deployment/final-app --timeout=180s
kubectl -n a20 exec deployment/final-app -- python -c "import urllib.request;print(urllib.request.urlopen('http://final-app/storage').read().decode())"
# The old port-forward targets a removed Pod; restart it after replacement.
../../../.local-tools/vm.sh 'kill "$(cat /tmp/devops-a20-forward.pid)" 2>/dev/null || true; nohup kubectl -n a20 port-forward --address=0.0.0.0 svc/final-app 8091:80 >/tmp/devops-a20-forward.log 2>&1 </dev/null & echo $! >/tmp/devops-a20-forward.pid'
kubectl -n a20 run load-generator --image=busybox:1.36 --restart=Never --command -- sh -c 'for i in 1 2 3 4 5 6 7 8; do (while true; do wget -qO- http://final-app/load >/dev/null; done) & done; wait'
for attempt in {1..30}; do
 kubectl -n a20 get hpa
 kubectl -n a20 top pods || true
 replicas=$(kubectl -n a20 get deploy final-app -o jsonpath='{.spec.replicas}')
 if ((replicas > 2)); then break; fi
 sleep 10
done
test "$replicas" -gt 2
kubectl -n a20 describe hpa final-app
kubectl -n a20 delete pod load-generator
# Fault 1: an invalid image causes ImagePullBackOff, diagnosed from events.
kubectl -n a20 set image deployment/final-app app=devops-a20-final:does-not-exist
sleep 20
kubectl -n a20 get pods
kubectl -n a20 describe pods -l app=final-app > ../evidence/before-image-fault.txt
cat ../evidence/before-image-fault.txt
kubectl -n a20 set image deployment/final-app app=devops-a20-final:local
kubectl -n a20 rollout status deployment/final-app --timeout=180s
# Fault 2: readiness targets an absent endpoint.
kubectl -n a20 patch deployment final-app --type=json -p '[{"op":"replace","path":"/spec/template/spec/containers/0/readinessProbe/httpGet/path","value":"/missing"}]'
sleep 15
kubectl -n a20 get pods
kubectl -n a20 describe pods -l app=final-app > ../evidence/before-readiness-fault.txt
kubectl -n a20 logs deployment/final-app --tail=8
kubectl -n a20 patch deployment final-app --type=json -p '[{"op":"replace","path":"/spec/template/spec/containers/0/readinessProbe/httpGet/path","value":"/health"}]'
kubectl -n a20 rollout status deployment/final-app --timeout=180s
# Fault 3: Service selector matches no Pods.
kubectl -n a20 patch svc final-app -p '{"spec":{"selector":{"app":"wrong-app"}}}'
sleep 2
kubectl -n a20 describe svc final-app > ../evidence/before-service-fault.txt
cat ../evidence/before-service-fault.txt
if kubectl -n a20 exec deployment/final-app -- python -c "import urllib.request; urllib.request.urlopen('http://final-app/health',timeout=3)"; then exit 1; else echo 'Expected failure with empty Service endpoints'; fi
kubectl -n a20 patch svc final-app -p '{"spec":{"selector":{"app":"final-app"}}}'
sleep 3
kubectl -n a20 exec deployment/final-app -- python -c "import urllib.request;print(urllib.request.urlopen('http://final-app/health').read().decode())"
kubectl -n a20 get deploy,pods,svc,ingress,hpa,pvc
kubectl -n a20 describe pods -l app=final-app > ../evidence/after-fault-repairs.txt
