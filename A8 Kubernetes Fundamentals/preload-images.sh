#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
for image in busybox:1.36 nginx:1.27 nginx:1.24 nginx:1.25 gcr.io/google-samples/kubernetes-bootcamp:v1 jocatalin/kubernetes-bootcamp:v2; do
 docker pull "$image"
 minikube -p devops-course image load "$image"
done
kubectl wait --for=condition=Ready nodes --all --timeout=180s
kubectl get pods -n kube-system
