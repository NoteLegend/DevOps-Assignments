#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
cd final-devops-project/terraform
terraform fmt
terraform fmt -check
terraform validate
# Bash syntax only: this performs no installation or cloud action.
bash -n bootstrap.sh.tftpl
