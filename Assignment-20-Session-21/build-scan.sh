#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
export DOCKER_CONFIG="$DEVOPS_WORKSPACE/.local-tools/runtime/anonymous-docker"
cd final-devops-project
../../../.local-tools/security-venv/bin/pytest -v
python -m compileall -q application
../../../.local-tools/security-venv/bin/bandit -r application -c security/bandit.yaml -f json -o ../evidence/sast.json
../../../.local-tools/security-venv/bin/pip-audit -r requirements.txt -f json -o ../evidence/sca.json
gitleaks dir . --redact --report-format json --report-path ../evidence/secrets.json
actionlint -shellcheck= .github/workflows/*.yml
docker build -t devops-a20-final:local -f docker/Dockerfile .
docker save devops-a20-final:local -o /workspace/.local-tools/runtime/a20-image.tar
trivy image --input ../../../.local-tools/runtime/a20-image.tar --format json --output ../evidence/image-scan.json
bash security/gate.sh ../../../.local-tools/runtime/a20-image.tar
minikube -p devops-course image load devops-a20-final:local
cd terraform
export TF_PLUGIN_CACHE_DIR="$DEVOPS_WORKSPACE/.local-tools/runtime/terraform-cache"
mkdir -p "$TF_PLUGIN_CACHE_DIR"
terraform init -backend=false -input=false
terraform fmt
terraform fmt -check
terraform validate
