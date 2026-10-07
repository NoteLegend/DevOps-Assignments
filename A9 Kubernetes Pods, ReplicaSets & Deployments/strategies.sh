#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
kubectl create namespace a09
kubectl -n a09 run client --image=busybox:1.36 --restart=Never --command -- sleep 3600
kubectl -n a09 wait --for=condition=Ready pod/client --timeout=180s
kubectl -n a09 apply -f strategies/rolling-v1.yaml
kubectl -n a09 rollout status deployment/rolling --timeout=180s
kubectl -n a09 get pods,rs -l app=rolling
timeout 25 kubectl -n a09 get pods -l app=rolling -w > evidence/rolling-watch.txt & watcher=$!
kubectl -n a09 apply -f strategies/rolling-v2.yaml
kubectl -n a09 get pods,rs -l app=rolling
kubectl -n a09 rollout status deployment/rolling --timeout=180s
wait "$watcher" || test "$?" = 124
cat evidence/rolling-watch.txt
kubectl -n a09 apply -f strategies/blue.yaml -f strategies/green.yaml -f strategies/blue-green-service.yaml
for name in blue green; do kubectl -n a09 rollout status "deployment/$name" --timeout=180s; done
kubectl -n a09 exec client -- wget -qO- http://blue-green
kubectl -n a09 patch svc blue-green -p '{"spec":{"selector":{"app":"green"}}}'
sleep 2
kubectl -n a09 exec client -- wget -qO- http://blue-green
kubectl -n a09 apply -f strategies/stable.yaml -f strategies/canary.yaml -f strategies/canary-service.yaml
for name in stable canary; do kubectl -n a09 rollout status "deployment/$name" --timeout=180s; done
kubectl -n a09 exec client -- sh -c 'for i in $(seq 1 100); do wget -qO- http://canary; done' | sort | uniq -c | tee evidence/canary-distribution.txt
grep -q stable evidence/canary-distribution.txt
grep -q canary evidence/canary-distribution.txt
kubectl -n a09 apply -f strategies/recreate-v1.yaml
kubectl -n a09 rollout status deployment/recreate --timeout=180s
timeout 25 kubectl -n a09 get pods -l app=recreate -w > evidence/recreate-watch.txt & watcher=$!
kubectl -n a09 apply -f strategies/recreate-v2.yaml
kubectl -n a09 rollout status deployment/recreate --timeout=180s
wait "$watcher" || test "$?" = 124
cat evidence/recreate-watch.txt
kubectl -n a09 get deployments,rs,pods -o wide
