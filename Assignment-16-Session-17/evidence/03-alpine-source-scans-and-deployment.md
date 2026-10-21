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
Executed 2026-10-07T14:16:47.389661+05:30
Working directory: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-16-Session-17
Script: verify.sh
Exit status: 0

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

2:15PM INF scanned ~13761 bytes (13.76 KB) in 10.6ms
2:15PM INF no leaks found
+ actionlint -shellcheck= .github/workflows/devsecops.yml
+ docker build -t devops-a16-app:local .
#0 building with "default" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 288B 0.0s done
#1 DONE 0.1s

#2 [internal] load metadata for docker.io/library/python:3.12-alpine
#2 DONE 2.8s

#3 [internal] load .dockerignore
#3 transferring context: 132B 0.0s done
#3 DONE 0.1s

#4 [internal] load build context
#4 transferring context: 319B 0.1s done
#4 DONE 0.2s

#5 [1/5] FROM docker.io/library/python:3.12-alpine@sha256:1b668429b3511ab407d8e00648891631b0b1a4d7e15e3ca70f38ab5b91ad4ab4
#5 resolve docker.io/library/python:3.12-alpine@sha256:1b668429b3511ab407d8e00648891631b0b1a4d7e15e3ca70f38ab5b91ad4ab4
#5 resolve docker.io/library/python:3.12-alpine@sha256:1b668429b3511ab407d8e00648891631b0b1a4d7e15e3ca70f38ab5b91ad4ab4 0.2s done
#5 DONE 0.8s

#5 [1/5] FROM docker.io/library/python:3.12-alpine@sha256:1b668429b3511ab407d8e00648891631b0b1a4d7e15e3ca70f38ab5b91ad4ab4
#5 sha256:e203d50c86bd38d307585d33fd69e7e7fd91e7535b65af46aa1d663cfb80c0fa 0B / 248B 0.2s
#5 sha256:283ac05c32e67060aa59f8a841b02df4cc0bd7fbf8d880f67d9b622e1cbd1935 0B / 16.36MB 0.2s
#5 sha256:bce3d672089f7ccc5125c3f8f95542fa3971138f323fb7f77e338a14396c85aa 0B / 416.28kB 0.2s
#5 sha256:e203d50c86bd38d307585d33fd69e7e7fd91e7535b65af46aa1d663cfb80c0fa 248B / 248B 0.3s done
#5 sha256:283ac05c32e67060aa59f8a841b02df4cc0bd7fbf8d880f67d9b622e1cbd1935 1.05MB / 16.36MB 0.6s
#5 sha256:283ac05c32e67060aa59f8a841b02df4cc0bd7fbf8d880f67d9b622e1cbd1935 2.10MB / 16.36MB 0.8s
#5 sha256:283ac05c32e67060aa59f8a841b02df4cc0bd7fbf8d880f67d9b622e1cbd1935 3.15MB / 16.36MB 0.9s
#5 sha256:283ac05c32e67060aa59f8a841b02df4cc0bd7fbf8d880f67d9b622e1cbd1935 4.19MB / 16.36MB 1.1s
#5 sha256:283ac05c32e67060aa59f8a841b02df4cc0bd7fbf8d880f67d9b622e1cbd1935 6.29MB / 16.36MB 1.2s
#5 sha256:283ac05c32e67060aa59f8a841b02df4cc0bd7fbf8d880f67d9b622e1cbd1935 7.34MB / 16.36MB 1.4s
#5 sha256:283ac05c32e67060aa59f8a841b02df4cc0bd7fbf8d880f67d9b622e1cbd1935 9.44MB / 16.36MB 1.5s
#5 sha256:283ac05c32e67060aa59f8a841b02df4cc0bd7fbf8d880f67d9b622e1cbd1935 10.49MB / 16.36MB 1.7s
#5 sha256:283ac05c32e67060aa59f8a841b02df4cc0bd7fbf8d880f67d9b622e1cbd1935 12.58MB / 16.36MB 2.1s
#5 sha256:bce3d672089f7ccc5125c3f8f95542fa3971138f323fb7f77e338a14396c85aa 416.28kB / 416.28kB 2.1s done
#5 sha256:283ac05c32e67060aa59f8a841b02df4cc0bd7fbf8d880f67d9b622e1cbd1935 14.68MB / 16.36MB 2.3s
#5 extracting sha256:bce3d672089f7ccc5125c3f8f95542fa3971138f323fb7f77e338a14396c85aa
#5 sha256:283ac05c32e67060aa59f8a841b02df4cc0bd7fbf8d880f67d9b622e1cbd1935 15.73MB / 16.36MB 2.4s
#5 extracting sha256:bce3d672089f7ccc5125c3f8f95542fa3971138f323fb7f77e338a14396c85aa 0.3s done
#5 sha256:283ac05c32e67060aa59f8a841b02df4cc0bd7fbf8d880f67d9b622e1cbd1935 16.36MB / 16.36MB 2.6s done
#5 extracting sha256:283ac05c32e67060aa59f8a841b02df4cc0bd7fbf8d880f67d9b622e1cbd1935
#5 extracting sha256:283ac05c32e67060aa59f8a841b02df4cc0bd7fbf8d880f67d9b622e1cbd1935 0.7s done
#5 extracting sha256:e203d50c86bd38d307585d33fd69e7e7fd91e7535b65af46aa1d663cfb80c0fa
#5 extracting sha256:e203d50c86bd38d307585d33fd69e7e7fd91e7535b65af46aa1d663cfb80c0fa 0.1s done
#5 DONE 4.4s

#6 [2/5] WORKDIR /app
#6 DONE 0.4s

#7 [3/5] COPY requirements.txt .
#7 DONE 0.4s

#8 [4/5] RUN pip install --no-cache-dir -r requirements.txt
#8 3.593 Collecting Flask==3.1.3 (from -r requirements.txt (line 1))
#8 3.799   Downloading flask-3.1.3-py3-none-any.whl.metadata (3.2 kB)
#8 3.847 Collecting blinker>=1.9.0 (from Flask==3.1.3->-r requirements.txt (line 1))
#8 3.878   Downloading blinker-1.9.0-py3-none-any.whl.metadata (1.6 kB)
#8 3.936 Collecting click>=8.1.3 (from Flask==3.1.3->-r requirements.txt (line 1))
#8 3.966   Downloading click-8.5.0-py3-none-any.whl.metadata (2.6 kB)
#8 3.998 Collecting itsdangerous>=2.2.0 (from Flask==3.1.3->-r requirements.txt (line 1))
#8 4.035   Downloading itsdangerous-2.2.0-py3-none-any.whl.metadata (1.9 kB)
#8 4.093 Collecting jinja2>=3.1.2 (from Flask==3.1.3->-r requirements.txt (line 1))
#8 4.115   Downloading jinja2-3.1.6-py3-none-any.whl.metadata (2.9 kB)
#8 4.236 Collecting markupsafe>=2.1.1 (from Flask==3.1.3->-r requirements.txt (line 1))
#8 4.257   Downloading markupsafe-3.0.4-cp312-cp312-musllinux_1_2_x86_64.whl.metadata (2.7 kB)
#8 4.313 Collecting werkzeug>=3.1.0 (from Flask==3.1.3->-r requirements.txt (line 1))
#8 4.337   Downloading werkzeug-3.1.9-py3-none-any.whl.metadata (4.1 kB)
#8 4.393 Downloading flask-3.1.3-py3-none-any.whl (103 kB)
#8 4.467 Downloading blinker-1.9.0-py3-none-any.whl (8.5 kB)
#8 4.494 Downloading click-8.5.0-py3-none-any.whl (125 kB)
#8 4.527 Downloading itsdangerous-2.2.0-py3-none-any.whl (16 kB)
#8 4.559 Downloading jinja2-3.1.6-py3-none-any.whl (134 kB)
#8 4.582 Downloading markupsafe-3.0.4-cp312-cp312-musllinux_1_2_x86_64.whl (23 kB)
#8 4.601 Downloading werkzeug-3.1.9-py3-none-any.whl (228 kB)
#8 4.662 Installing collected packages: markupsafe, itsdangerous, click, blinker, werkzeug, jinja2, Flask
#8 5.846 Successfully installed Flask-3.1.3 blinker-1.9.0 click-8.5.0 itsdangerous-2.2.0 jinja2-3.1.6 markupsafe-3.0.4 werkzeug-3.1.9
#8 5.847 WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager, possibly rendering your system unusable. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv. Use the --root-user-action option if you know what you are doing and want to suppress this warning.
#8 6.133 
#8 6.133 [notice] A new release of pip is available: 25.0.1 -> 26.2.1
#8 6.133 [notice] To update, run: pip install --upgrade pip
#8 DONE 6.4s

#9 [5/5] COPY application ./application
#9 DONE 0.5s

#10 exporting to image
#10 exporting layers
#10 exporting layers 2.2s done
#10 exporting manifest sha256:8273f372a65b52466fdb4821381ce1f3bad64a76c471233261f4ac62fa63349b 0.1s done
#10 exporting config sha256:2c764981b8c8b4cbdb2c5942ee970579f01e556e8926bd7d23ec03e7b68bbfb6
#10 exporting config sha256:2c764981b8c8b4cbdb2c5942ee970579f01e556e8926bd7d23ec03e7b68bbfb6 0.1s done
#10 exporting attestation manifest sha256:df8e51bd77566a5cdaf181f671aa3d983cdb0eab4d1a95e9e754b15662f650ff
#10 exporting attestation manifest sha256:df8e51bd77566a5cdaf181f671aa3d983cdb0eab4d1a95e9e754b15662f650ff 0.3s done
#10 exporting manifest list sha256:d862892457c21978ad356ce41db0085e066cda7cb2905af9d2a00238a3753213
#10 exporting manifest list sha256:d862892457c21978ad356ce41db0085e066cda7cb2905af9d2a00238a3753213 0.1s done
#10 naming to docker.io/library/devops-a16-app:local
#10 naming to docker.io/library/devops-a16-app:local 0.0s done
#10 unpacking to docker.io/library/devops-a16-app:local
#10 unpacking to docker.io/library/devops-a16-app:local 0.8s done
#10 DONE 3.9s
+ docker save devops-a16-app:local -o /workspace/.local-tools/runtime/a16-image.tar
+ trivy image --input ../../.local-tools/runtime/a16-image.tar --format json --output evidence/image-scan.json
2026-10-07T14:15:38+05:30	INFO	[vuln] Vulnerability scanning is enabled
2026-10-07T14:15:38+05:30	INFO	[secret] Secret scanning is enabled
2026-10-07T14:15:38+05:30	INFO	[secret] If your scanning is slow, please try '--scanners vuln' to disable secret scanning
2026-10-07T14:15:38+05:30	INFO	[secret] Please see https://trivy.dev/docs/v0.75/guide/scanner/secret#recommendation for faster secret detection
2026-10-07T14:15:38+05:30	INFO	[python] Licenses acquired from one or more METADATA files may be subject to additional terms. Use `--debug` flag to see all affected packages.
2026-10-07T14:15:38+05:30	INFO	Detected OS	family="alpine" version="3.24.2"
2026-10-07T14:15:38+05:30	INFO	[alpine] Detecting vulnerabilities...	os_version="3.24" repository="3.24" pkg_num=38
2026-10-07T14:15:38+05:30	INFO	Number of language-specific files	num=1
2026-10-07T14:15:38+05:30	INFO	[python-pkg] Detecting vulnerabilities...
2026-10-07T14:15:38+05:30	WARN	Using severities from other vendors for some vulnerabilities. Read https://trivy.dev/docs/v0.75/guide/scanner/vulnerability#severity-selection for details.
+ bash security/gate.sh ../../.local-tools/runtime/a16-image.tar
2026-10-07T14:15:39+05:30	INFO	[vuln] Vulnerability scanning is enabled
2026-10-07T14:15:39+05:30	INFO	[secret] Secret scanning is enabled
2026-10-07T14:15:39+05:30	INFO	[secret] If your scanning is slow, please try '--scanners vuln' to disable secret scanning
2026-10-07T14:15:39+05:30	INFO	[secret] Please see https://trivy.dev/docs/v0.75/guide/scanner/secret#recommendation for faster secret detection
2026-10-07T14:15:39+05:30	INFO	Detected OS	family="alpine" version="3.24.2"
2026-10-07T14:15:39+05:30	INFO	[alpine] Detecting vulnerabilities...	os_version="3.24" repository="3.24" pkg_num=38
2026-10-07T14:15:39+05:30	INFO	Number of language-specific files	num=1
2026-10-07T14:15:39+05:30	INFO	[python-pkg] Detecting vulnerabilities...
2026-10-07T14:15:39+05:30	WARN	Using severities from other vendors for some vulnerabilities. Read https://trivy.dev/docs/v0.75/guide/scanner/vulnerability#severity-selection for details.

Report Summary

┌──────────────────────────────────────────────────────────────────────────────┬────────────┬─────────────────┬─────────┐
│                                    Target                                    │    Type    │ Vulnerabilities │ Secrets │
├──────────────────────────────────────────────────────────────────────────────┼────────────┼─────────────────┼─────────┤
│ ../../.local-tools/runtime/a16-image.tar (alpine 3.24.2)                     │   alpine   │        0        │    -    │
├──────────────────────────────────────────────────────────────────────────────┼────────────┼─────────────────┼─────────┤
│ usr/local/lib/python3.12/site-packages/blinker-1.9.0.dist-info/METADATA      │ python-pkg │        0        │    -    │
├──────────────────────────────────────────────────────────────────────────────┼────────────┼─────────────────┼─────────┤
│ usr/local/lib/python3.12/site-packages/click-8.5.0.dist-info/METADATA        │ python-pkg │        0        │    -    │
├──────────────────────────────────────────────────────────────────────────────┼────────────┼─────────────────┼─────────┤
│ usr/local/lib/python3.12/site-packages/flask-3.1.3.dist-info/METADATA        │ python-pkg │        0        │    -    │
├──────────────────────────────────────────────────────────────────────────────┼────────────┼─────────────────┼─────────┤
│ usr/local/lib/python3.12/site-packages/itsdangerous-2.2.0.dist-info/METADATA │ python-pkg │        0        │    -    │
├──────────────────────────────────────────────────────────────────────────────┼────────────┼─────────────────┼─────────┤
│ usr/local/lib/python3.12/site-packages/jinja2-3.1.6.dist-info/METADATA       │ python-pkg │        0        │    -    │
├──────────────────────────────────────────────────────────────────────────────┼────────────┼─────────────────┼─────────┤
│ usr/local/lib/python3.12/site-packages/markupsafe-3.0.4.dist-info/METADATA   │ python-pkg │        0        │    -    │
├──────────────────────────────────────────────────────────────────────────────┼────────────┼─────────────────┼─────────┤
│ usr/local/lib/python3.12/site-packages/pip-25.0.1.dist-info/METADATA         │ python-pkg │        0        │    -    │
├──────────────────────────────────────────────────────────────────────────────┼────────────┼─────────────────┼─────────┤
│ usr/local/lib/python3.12/site-packages/werkzeug-3.1.9.dist-info/METADATA     │ python-pkg │        0        │    -    │
└──────────────────────────────────────────────────────────────────────────────┴────────────┴─────────────────┴─────────┘
Legend:
- '-': Not scanned
- '0': Clean (no security findings detected)

+ minikube -p devops-course image load devops-a16-app:local
+ kubectl create namespace a16
namespace/a16 created
+ kubectl -n a16 apply --dry-run=server -f kubernetes
deployment.apps/devsecops created (server dry run)
service/devsecops created (server dry run)
+ kubectl -n a16 apply -f kubernetes
deployment.apps/devsecops created
service/devsecops created
+ kubectl -n a16 rollout status deployment/devsecops --timeout=180s
Waiting for deployment "devsecops" rollout to finish: 0 of 2 updated replicas are available...
Waiting for deployment "devsecops" rollout to finish: 1 of 2 updated replicas are available...
deployment "devsecops" successfully rolled out
+ kubectl -n a16 exec deployment/devsecops -- python -c 'import urllib.request;print(urllib.request.urlopen('\''http://devsecops/health'\'').read().decode())'
{"status":"healthy"}

+ kubectl -n a16 get pods,svc
NAME                             READY   STATUS    RESTARTS   AGE
pod/devsecops-549b9747c8-7qz8k   1/1     Running   0          14s
pod/devsecops-549b9747c8-xncpk   1/1     Running   0          14s

NAME                TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)   AGE
service/devsecops   ClusterIP   10.99.56.38   <none>        80/TCP    14s
+ kubectl delete namespace a16
namespace "a16" deleted

```
