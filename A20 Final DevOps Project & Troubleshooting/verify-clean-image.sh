#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
export DOCKER_CONFIG="$DEVOPS_WORKSPACE/.local-tools/runtime/anonymous-docker"
cd final-devops-project
docker build -t devops-a20-final:local -f docker/Dockerfile .
docker run --rm devops-a20-final:local sh -c 'test -z "$(find /app -name "*.pyc")" && echo "No host bytecode copied into runtime"'
docker save devops-a20-final:local -o /workspace/.local-tools/runtime/a20-image.tar
trivy image --input ../../../.local-tools/runtime/a20-image.tar --format json --output ../evidence/image-scan.json
bash security/gate.sh ../../../.local-tools/runtime/a20-image.tar
minikube -p devops-course image load devops-a20-final:local
