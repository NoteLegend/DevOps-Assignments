#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
terraform version
cd terraform-project
export TF_PLUGIN_CACHE_DIR="$DEVOPS_WORKSPACE/.local-tools/runtime/terraform-cache"
mkdir -p "$TF_PLUGIN_CACHE_DIR"
terraform init -backend=false -input=false
terraform fmt
terraform fmt -check
terraform validate
