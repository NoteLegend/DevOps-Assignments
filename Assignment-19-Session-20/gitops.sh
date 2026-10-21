#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
kubectl create namespace a19
git -C gitops/desired init -b main
git -C gitops/desired config user.name 'DevOps Practical'
git -C gitops/desired config user.email 'practical@example.invalid'
git -C gitops/desired add deployment.yaml
git -C gitops/desired commit -m 'Declare initial local Kubernetes workload'
../../.local-tools/vm.sh 'nohup python3 /workspace/DevOps-Assignments/Assignment-19-Session-20/gitops/reconcile.py >/tmp/devops-a19-reconcile.log 2>&1 </dev/null & echo $! >/tmp/devops-a19-reconcile.pid'
sleep 10
kubectl -n a19 rollout status deployment/gitops-web --timeout=180s
kubectl -n a19 exec deployment/gitops-web -- wget -qO- http://localhost:8080
kubectl -n a19 scale deployment/gitops-web --replicas=3
kubectl -n a19 get deploy gitops-web
sleep 10
kubectl -n a19 get deploy gitops-web -o jsonpath='{.spec.replicas}{"\n"}' | grep '^1$'
sed -i 's/gitops-v1/gitops-v2/' gitops/desired/deployment.yaml
git -C gitops/desired add deployment.yaml
git -C gitops/desired commit -m 'Declare version two in Git'
sleep 10
kubectl -n a19 rollout status deployment/gitops-web --timeout=180s
kubectl -n a19 exec deployment/gitops-web -- wget -qO- http://localhost:8080 | grep gitops-v2
../../.local-tools/vm.sh 'cat /tmp/devops-a19-reconcile.log; kill "$(cat /tmp/devops-a19-reconcile.pid)"'
git -C gitops/desired log --oneline
git -C gitops/desired remote -v
git -C gitops/desired bundle create ../history.bundle --all
git -C gitops/desired bundle verify ../history.bundle
kubectl delete namespace a19
