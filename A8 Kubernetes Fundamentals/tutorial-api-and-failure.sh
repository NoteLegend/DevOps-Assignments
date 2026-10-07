#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
kubectl create namespace a08-more
kubectl -n a08-more create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1
kubectl -n a08-more rollout status deployment/kubernetes-bootcamp --timeout=180s
kubectl -n a08-more expose deployment kubernetes-bootcamp --type=NodePort --port=8080
../../.local-tools/vm.sh 'nohup kubectl proxy --port=8001 >/tmp/devops-a08-proxy.log 2>&1 </dev/null & echo $! >/tmp/devops-a08-proxy.pid'
../../.local-tools/vm.sh 'curl --retry 10 --retry-all-errors --retry-delay 1 -fsS http://127.0.0.1:8001/version; curl -fsS http://127.0.0.1:8001/api/v1/namespaces/a08-more/services/kubernetes-bootcamp:8080/proxy/'
pod=$(kubectl -n a08-more get pods -l app=kubernetes-bootcamp -o jsonpath='{.items[0].metadata.name}')
kubectl -n a08-more label pod "$pod" version=v1
kubectl -n a08-more get pods -l version=v1
kubectl -n a08-more describe service kubernetes-bootcamp
kubectl -n a08-more delete pod "$pod"
kubectl -n a08-more rollout status deployment/kubernetes-bootcamp --timeout=180s
kubectl -n a08-more get pods
kubectl -n a08-more set image deployment/kubernetes-bootcamp kubernetes-bootcamp=jocatalin/kubernetes-bootcamp:v10
if kubectl -n a08-more rollout status deployment/kubernetes-bootcamp --timeout=30s; then exit 1; else echo 'Invalid v10 image prevents rollout, as expected'; fi
kubectl -n a08-more describe pods
kubectl -n a08-more rollout undo deployment/kubernetes-bootcamp
kubectl -n a08-more rollout status deployment/kubernetes-bootcamp --timeout=180s
../../.local-tools/vm.sh 'curl -fsS http://127.0.0.1:8001/api/v1/namespaces/a08-more/services/kubernetes-bootcamp:8080/proxy/; kill "$(cat /tmp/devops-a08-proxy.pid)"'
kubectl delete namespace a08-more
