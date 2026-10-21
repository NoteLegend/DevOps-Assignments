#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
cd final-devops-project
kubectl create namespace a20-helm
kubectl -n a20-helm create secret generic final-secret --from-file=value=/workspace/.local-tools/runtime/secret-good
helm lint helm/final-app
helm template final helm/final-app > ../evidence/helm-rendered.yaml
helm install final helm/final-app -n a20-helm --wait --timeout=3m
kubectl -n a20-helm exec deployment/final-app -- python -c "import urllib.request;print(urllib.request.urlopen('http://final-app/health').read().decode())"
helm upgrade final helm/final-app -n a20-helm --set version=v2 --wait --timeout=3m
kubectl -n a20-helm exec deployment/final-app -- python -c "import urllib.request;print(urllib.request.urlopen('http://final-app/health').read().decode())"
helm history final -n a20-helm
helm rollback final 1 -n a20-helm --wait --timeout=3m
kubectl -n a20-helm exec deployment/final-app -- python -c "import urllib.request;print(urllib.request.urlopen('http://final-app/health').read().decode())"
helm uninstall final -n a20-helm
kubectl delete namespace a20-helm
