#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
# Inspect the course examples actually created during the initial directory apply.
kubectl -n default get pods liveness-demo readiness-demo startup-demo
for name in liveness-demo readiness-demo startup-demo; do kubectl -n default describe pod "$name"; done
kubectl -n default delete pods liveness-demo readiness-demo startup-demo
