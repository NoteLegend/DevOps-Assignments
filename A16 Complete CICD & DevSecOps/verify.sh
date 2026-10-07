#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
export DOCKER_CONFIG="$DEVOPS_WORKSPACE/.local-tools/runtime/anonymous-docker"
python -m compileall -q application
../../.local-tools/security-venv/bin/pytest -v
../../.local-tools/security-venv/bin/bandit -r application -c security/bandit.yaml -f json -o evidence/sast.json
../../.local-tools/security-venv/bin/pip-audit -r requirements.txt -f json -o evidence/sca.json
gitleaks dir . --redact --report-format json --report-path evidence/secrets.json
actionlint -shellcheck= .github/workflows/*.yml
docker build -t devops-a16-app:local .
docker save devops-a16-app:local -o /workspace/.local-tools/runtime/a16-image.tar
trivy image --input ../../.local-tools/runtime/a16-image.tar --format json --output evidence/image-scan.json
bash security/gate.sh ../../.local-tools/runtime/a16-image.tar
minikube -p devops-course image load devops-a16-app:local
kubectl create namespace a16
kubectl -n a16 apply --dry-run=server -f kubernetes
kubectl -n a16 apply -f kubernetes
kubectl -n a16 rollout status deployment/devsecops --timeout=180s
kubectl -n a16 exec deployment/devsecops -- python -c "import urllib.request;print(urllib.request.urlopen('http://devsecops/health').read().decode())"
kubectl -n a16 get pods,svc
kubectl delete namespace a16
