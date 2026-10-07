# Executed commands and captured output

```bash
#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
cd final-devops-project/terraform
terraform fmt
terraform fmt -check
terraform validate
# Bash syntax only: this performs no installation or cloud action.
bash -n bootstrap.sh.tftpl

```

```text
Executed 2026-10-07T14:32:48.556839+05:30
Working directory: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-20-Session-21
Script: validate-cloud-bootstrap.sh
Exit status: 0

+ source ../../.local-tools/env.sh
++ _devops_trace=0
++ case $- in
++ _devops_trace=1
++ set +x
++ unset _devops_trace
+ cd final-devops-project/terraform
+ terraform fmt
+ terraform fmt -check
+ terraform validate
Success! The configuration is valid.

+ bash -n bootstrap.sh.tftpl

```
