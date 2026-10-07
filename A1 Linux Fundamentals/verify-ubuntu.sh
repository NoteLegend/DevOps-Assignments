#!/usr/bin/env bash
set -euo pipefail
../../.local-tools/vm.sh 'cd /workspace/DevOps-Assignments/Assignment-01-Session-01-02 && bash practice-ubuntu.sh && shellcheck system-information.sh && docker --version'
