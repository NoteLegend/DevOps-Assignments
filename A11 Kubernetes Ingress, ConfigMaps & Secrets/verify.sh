#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
minikube -p devops-course addons enable ingress
kubectl -n ingress-nginx rollout status deployment/ingress-nginx-controller --timeout=240s
kubectl create namespace a11
python3 - <<'PYGEN'
from pathlib import Path
import secrets
r=Path('../../.local-tools/runtime');v=secrets.token_hex(24);(r/'secret-good').write_text(v);(r/'secret-bad').write_text(v+'\n')
for p in [r/'secret-good',r/'secret-bad']:p.chmod(0o600)
PYGEN
kubectl -n a11 create secret generic db-secret --from-file=password=/workspace/.local-tools/runtime/secret-bad
kubectl -n a11 apply -f manifests
kubectl -n a11 rollout status deployment/config-demo --timeout=180s
kubectl -n a11 exec deployment/config-demo -- sh -c 'echo "ConfigMap value: $VERSION"; if [ -n "$DB_PASSWORD" ]; then echo "Secret injected: PASS (value hidden)"; fi'
# Course troubleshooting case: the trailing newline in a base64 source.
kubectl -n a11 exec deployment/config-demo -- sh -c 'case "$DB_PASSWORD" in *"
") echo "BEFORE: trailing newline detected" ;; *) exit 1 ;; esac'
kubectl -n a11 delete secret db-secret
kubectl -n a11 create secret generic db-secret --from-file=password=/workspace/.local-tools/runtime/secret-good
kubectl -n a11 rollout restart deployment/config-demo
kubectl -n a11 rollout status deployment/config-demo --timeout=180s
kubectl -n a11 exec deployment/config-demo -- sh -c 'case "$DB_PASSWORD" in *"
") exit 1 ;; *) echo "AFTER: Secret value is nonempty with no trailing newline" ;; esac'
node_ip=$(minikube -p devops-course ip)
../../.local-tools/vm.sh "curl -fsS -H 'Host: course.local' http://$node_ip"
kubectl -n a11 get deployment,svc,ingress,configmap
kubectl -n a11 describe ingress config-demo
kubectl delete namespace a11
