#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
for attempt in {1..45}; do
 kubectl -n production-webapp get hpa,pods
 replicas=$(kubectl -n production-webapp get deploy web-app -o jsonpath='{.spec.replicas}')
 if [[ "$replicas" = 2 ]]; then break; fi
 sleep 10
done
test "$replicas" = 2
kubectl -n production-webapp exec deployment/web-app -- cat /data/student.txt
kubectl -n production-webapp describe hpa web-app-hpa
