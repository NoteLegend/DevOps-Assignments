#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
minikube start -p devops-course --driver=docker --cpus=3 --memory=4096 --kubernetes-version=v1.36.0
minikube status -p devops-course
kubectl version
kubectl cluster-info
kubectl wait --for=condition=Ready nodes --all --timeout=240s
kubectl get nodes -o wide
kubectl get pods -n kube-system
kubectl create namespace a08 --dry-run=client -o yaml | kubectl apply -f -
kubectl -n a08 create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1 --dry-run=client -o yaml | kubectl apply -f -
kubectl -n a08 rollout status deployment/kubernetes-bootcamp --timeout=180s
kubectl -n a08 get deployments,pods
kubectl -n a08 describe deployment kubernetes-bootcamp
kubectl -n a08 logs deployment/kubernetes-bootcamp
kubectl -n a08 exec deployment/kubernetes-bootcamp -- env | grep -E 'HOSTNAME|KUBERNETES_SERVICE_HOST'
kubectl -n a08 expose deployment kubernetes-bootcamp --type=NodePort --port=8080 --dry-run=client -o yaml | kubectl apply -f -
../../.local-tools/vm.sh 'test ! -f /tmp/devops-a08-forward.pid || kill "$(cat /tmp/devops-a08-forward.pid)" 2>/dev/null || true'
../../.local-tools/vm.sh 'nohup kubectl -n a08 port-forward --address=0.0.0.0 svc/kubernetes-bootcamp 8080:8080 >/tmp/devops-a08-forward.log 2>&1 </dev/null & echo $! >/tmp/devops-a08-forward.pid'
curl --retry 15 --retry-all-errors --retry-delay 2 --max-time 10 -fsS http://127.0.0.1:8080
/tmp/devops-tools-venv/bin/python ../../.local-tools/evidence.py . 02-tutorial-application --url http://127.0.0.1:8080
kubectl -n a08 scale deployment kubernetes-bootcamp --replicas=4
kubectl -n a08 rollout status deployment/kubernetes-bootcamp --timeout=180s
kubectl -n a08 get pods -o wide
kubectl -n a08 set image deployment/kubernetes-bootcamp kubernetes-bootcamp=docker.io/jocatalin/kubernetes-bootcamp:v2
kubectl -n a08 rollout status deployment/kubernetes-bootcamp --timeout=180s
kubectl -n a08 get pods
kubectl -n a08 rollout history deployment/kubernetes-bootcamp
kubectl -n a08 rollout undo deployment/kubernetes-bootcamp
kubectl -n a08 rollout status deployment/kubernetes-bootcamp --timeout=180s
kubectl -n a08 get deployment kubernetes-bootcamp -o jsonpath='{.spec.template.spec.containers[0].image}{"\n"}'
kubectl -n a08 get deployment,svc -o yaml > evidence/tutorial-resources.yaml
../../.local-tools/vm.sh 'kill "$(cat /tmp/devops-a08-forward.pid)"'
kubectl delete namespace a08
