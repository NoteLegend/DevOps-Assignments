#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
export DOCKER_CONFIG="$DEVOPS_WORKSPACE/.local-tools/runtime/anonymous-docker"
bash security/gate.sh ../../.local-tools/runtime/a16-image.tar
actionlint -shellcheck= .github/workflows/devsecops.yml
