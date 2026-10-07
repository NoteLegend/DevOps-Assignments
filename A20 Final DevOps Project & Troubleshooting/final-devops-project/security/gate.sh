#!/usr/bin/env bash
set -euo pipefail
trivy image --input "$1" --severity HIGH,CRITICAL --exit-code 1
