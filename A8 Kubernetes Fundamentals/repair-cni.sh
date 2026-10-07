#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
kubectl get nodes
kubectl -n kube-system get pods -l app=kindnet
docker exec devops-course crictl images | grep kindnet
kubectl -n kube-system delete pod -l app=kindnet --force --grace-period=0
docker exec devops-course systemctl restart containerd kubelet
kubectl wait --for=condition=Ready nodes --all --timeout=180s
kubectl -n kube-system get pods
