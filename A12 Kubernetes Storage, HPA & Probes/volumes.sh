#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
kubectl create namespace a12-volumes
kubectl -n a12-volumes apply -f 01-kubernetes-volumes
kubectl -n a12-volumes wait --for=condition=Ready pod --all --timeout=180s
kubectl -n a12-volumes get pods,pvc
kubectl get pv,storageclass
for name in emptydir-demo hostpath-demo storage-demo; do
 kubectl -n a12-volumes exec "$name" -- sh -c 'echo actual-volume-test >/data/check.txt; cat /data/check.txt'
done
for file in 01-kubernetes-volumes/*.yaml; do
 case "$file" in *pod*|*emptydir*|*hostpath*) kubectl -n a12-volumes delete -f "$file"; kubectl -n a12-volumes apply -f "$file" ;; esac
done
kubectl -n a12-volumes wait --for=condition=Ready pod --all --timeout=180s
kubectl -n a12-volumes exec emptydir-demo -- sh -c 'test ! -f /data/check.txt && echo emptyDir-reset-after-pod-deletion'
kubectl -n a12-volumes exec hostpath-demo -- cat /data/check.txt
kubectl -n a12-volumes exec storage-demo -- cat /data/check.txt
kubectl -n a12-volumes describe pvc dynamic-pvc
kubectl delete namespace a12-volumes
kubectl delete pv student-pv
