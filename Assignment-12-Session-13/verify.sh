#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
minikube -p devops-course addons enable metrics-server
kubectl -n kube-system rollout status deployment/metrics-server --timeout=180s
kubectl create namespace a12
kubectl -n a12 apply -f hpa
kubectl -n a12 rollout status deployment/hpa-demo --timeout=180s
kubectl -n a12 get hpa,pods
kubectl -n a12 run load-generator --image=busybox:1.36 --restart=Never --command -- sh -c 'for i in 1 2 3 4 5 6 7 8; do (while true; do wget -qO- http://hpa-demo-service >/dev/null; done) & done; wait'
for attempt in {1..36}; do
 kubectl -n a12 get hpa
 kubectl -n a12 top pods || true
 replicas=$(kubectl -n a12 get deploy hpa-demo -o jsonpath='{.spec.replicas}')
 if ((replicas > 1)); then break; fi
 sleep 10
done
test "$replicas" -gt 1
kubectl -n a12 describe hpa hpa-demo
kubectl -n a12 get pods -o wide
kubectl -n a12 delete pod load-generator
kubectl apply -f mini-project/namespace.yaml -f mini-project/pvc.yaml -f mini-project/deployment.yaml -f mini-project/service.yaml -f mini-project/hpa.yaml
kubectl -n production-webapp rollout status deployment/web-app --timeout=180s
kubectl -n production-webapp get pvc,hpa,pods
pod=$(kubectl -n production-webapp get pods -l app=web-app -o jsonpath='{.items[0].metadata.name}')
kubectl -n production-webapp exec "$pod" -- sh -c 'echo "DevOps practical persistence check" >/data/student.txt'
kubectl -n production-webapp exec "$pod" -- cat /data/student.txt
kubectl -n production-webapp delete pod "$pod"
kubectl -n production-webapp rollout status deployment/web-app --timeout=180s
kubectl -n production-webapp exec deployment/web-app -- cat /data/student.txt
kubectl -n production-webapp exec deployment/web-app -- curl -fsS localhost
kubectl -n production-webapp run load-generator --image=busybox:1.36 --restart=Never --command -- sh -c 'for i in 1 2 3 4 5 6 7 8 9 10 11 12; do (while true; do wget -qO- http://web-service >/dev/null; done) & done; wait'
for attempt in {1..36}; do
 kubectl -n production-webapp get hpa
 kubectl -n production-webapp top pods || true
 replicas=$(kubectl -n production-webapp get deploy web-app -o jsonpath='{.spec.replicas}')
 if ((replicas > 2)); then break; fi
 sleep 10
done
test "$replicas" -gt 2
kubectl -n production-webapp describe hpa web-app-hpa
kubectl -n production-webapp delete pod load-generator
kubectl -n production-webapp get deployment web-app -o jsonpath='{.spec.template.spec.containers[0].startupProbe}{"\n"}{.spec.template.spec.containers[0].readinessProbe}{"\n"}{.spec.template.spec.containers[0].livenessProbe}{"\n"}'
kubectl delete namespace a12 production-webapp
