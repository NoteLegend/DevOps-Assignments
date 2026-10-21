# Executed commands and captured output

```bash
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

```

```text
Executed 2026-10-07T14:13:54.906995+05:30
Working directory: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-16-Session-17
Script: verify.sh
Exit status: 1

+ source ../../.local-tools/env.sh
++ _devops_trace=0
++ case $- in
++ _devops_trace=1
++ set +x
++ unset _devops_trace
+ export DOCKER_CONFIG=/home/rushixd/Wurk/Scaler/DevOps/.local-tools/runtime/anonymous-docker
+ DOCKER_CONFIG=/home/rushixd/Wurk/Scaler/DevOps/.local-tools/runtime/anonymous-docker
+ python -m compileall -q application
+ ../../.local-tools/security-venv/bin/pytest -v
============================= test session starts ==============================
platform linux -- Python 3.14.7, pytest-9.1.1, pluggy-1.6.0 -- /home/rushixd/Wurk/Scaler/DevOps/.local-tools/security-venv/bin/python
cachedir: .pytest_cache
rootdir: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-16-Session-17
configfile: pytest.ini
plugins: platformdirs-4.12.3
collecting ... collected 3 items

tests/test_app.py::test_health PASSED                                    [ 33%]
tests/test_app.py::test_add PASSED                                       [ 66%]
tests/test_app.py::test_invalid_input PASSED                             [100%]

============================== 3 passed in 0.14s ===============================
+ ../../.local-tools/security-venv/bin/bandit -r application -c security/bandit.yaml -f json -o evidence/sast.json
[main]	INFO	profile include tests: None
[main]	INFO	profile exclude tests: None
[main]	INFO	cli include tests: None
[main]	INFO	cli exclude tests: None
[json]	INFO	JSON output written to file: evidence/sast.json
+ ../../.local-tools/security-venv/bin/pip-audit -r requirements.txt -f json -o evidence/sca.json
No known vulnerabilities found
+ gitleaks dir . --redact --report-format json --report-path evidence/secrets.json

    ○
    │╲
    │ ○
    ○ ░
    ░    gitleaks

2:13PM INF scanned ~909660 bytes (909.66 KB) in 286ms
2:13PM WRN leaks found: 2

```
