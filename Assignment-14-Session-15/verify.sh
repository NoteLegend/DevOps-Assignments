#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
helm version --short
helm create demo-chart
helm lint demo-chart
helm template example demo-chart > evidence/generated-chart.yaml
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update prometheus-community
helm repo list
helm search repo prometheus-community/prometheus | sed -n '1,12p'
kubectl create namespace a14
helm lint mini-project/notes-chart
helm template notes-dev mini-project/notes-chart > evidence/notes-rendered.yaml
helm install notes-dev mini-project/notes-chart -n a14 --wait --timeout=3m
helm list -n a14
helm status notes-dev -n a14
helm get all notes-dev -n a14
kubectl -n a14 exec deployment/notes-dev-deploy -- curl -fsS localhost
kubectl -n a14 exec deployment/notes-dev-deploy -- printenv ENVIRONMENT APP_NAME
helm upgrade notes-dev mini-project/notes-chart -n a14 -f mini-project/notes-chart/values-prod.yaml --wait --timeout=3m
kubectl -n a14 get pods
kubectl -n a14 exec deployment/notes-dev-deploy -- printenv ENVIRONMENT
helm upgrade notes-dev mini-project/notes-chart -n a14 -f mini-project/notes-chart/values-prod.yaml --set image.tag=broken-tag-does-not-exist
sleep 35
kubectl -n a14 get pods
kubectl -n a14 describe deployment notes-dev-deploy
helm history notes-dev -n a14
helm rollback notes-dev 2 -n a14 --wait --timeout=3m
kubectl -n a14 get pods
kubectl -n a14 exec deployment/notes-dev-deploy -- curl -fsS localhost
helm history notes-dev -n a14
helm uninstall notes-dev -n a14
helm list -n a14
kubectl -n a14 get all
kubectl delete namespace a14
