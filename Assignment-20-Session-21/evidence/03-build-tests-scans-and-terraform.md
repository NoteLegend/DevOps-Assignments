# Executed commands and captured output

```bash
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

```

```text
Executed 2026-10-07T14:24:41.916743+05:30
Working directory: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-20-Session-21
Script: build-scan.sh
Exit status: 1

+ source ../../.local-tools/env.sh
++ _devops_trace=0
++ case $- in
++ _devops_trace=1
++ set +x
++ unset _devops_trace
+ export DOCKER_CONFIG=/home/rushixd/Wurk/Scaler/DevOps/.local-tools/runtime/anonymous-docker
+ DOCKER_CONFIG=/home/rushixd/Wurk/Scaler/DevOps/.local-tools/runtime/anonymous-docker
+ cd final-devops-project
+ ../../../.local-tools/security-venv/bin/pytest -v
============================= test session starts ==============================
platform linux -- Python 3.14.7, pytest-9.1.1, pluggy-1.6.0 -- /home/rushixd/Wurk/Scaler/DevOps/.local-tools/security-venv/bin/python
cachedir: .pytest_cache
rootdir: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-20-Session-21/final-devops-project
configfile: pytest.ini
plugins: platformdirs-4.12.3
collecting ... collected 5 items

application/tests/test_app.py::test_home PASSED                          [ 20%]
application/tests/test_app.py::test_health PASSED                        [ 40%]
application/tests/test_app.py::test_metrics PASSED                       [ 60%]
application/tests/test_app.py::test_storage PASSED                       [ 80%]
application/tests/test_app.py::test_storage_rejects_invalid PASSED       [100%]

============================== 5 passed in 0.17s ===============================
+ python -m compileall -q application
+ ../../../.local-tools/security-venv/bin/bandit -r application -c security/bandit.yaml -f json -o ../evidence/sast.json
[main]	INFO	profile include tests: None
[main]	INFO	profile exclude tests: None
[main]	INFO	cli include tests: None
[main]	INFO	cli exclude tests: None
[json]	INFO	JSON output written to file: ../evidence/sast.json

```
