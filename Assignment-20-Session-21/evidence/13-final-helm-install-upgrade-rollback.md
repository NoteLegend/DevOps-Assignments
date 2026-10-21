# Executed commands and captured output

```bash
#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
cd final-devops-project
kubectl create namespace a20-helm
kubectl -n a20-helm create secret generic final-secret --from-file=value=/workspace/.local-tools/runtime/secret-good
helm lint helm/final-app
helm template final helm/final-app > ../evidence/helm-rendered.yaml
helm install final helm/final-app -n a20-helm --wait --timeout=3m
kubectl -n a20-helm exec deployment/final-app -- python -c "import urllib.request;print(urllib.request.urlopen('http://final-app/health').read().decode())"
helm upgrade final helm/final-app -n a20-helm --set version=v2 --wait --timeout=3m
kubectl -n a20-helm exec deployment/final-app -- python -c "import urllib.request;print(urllib.request.urlopen('http://final-app/health').read().decode())"
helm history final -n a20-helm
helm rollback final 1 -n a20-helm --wait --timeout=3m
kubectl -n a20-helm exec deployment/final-app -- python -c "import urllib.request;print(urllib.request.urlopen('http://final-app/health').read().decode())"
helm uninstall final -n a20-helm
kubectl delete namespace a20-helm

```

```text
Executed 2026-10-07T14:35:21.013596+05:30
Working directory: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-20-Session-21
Script: helm-lifecycle.sh
Exit status: 0

+ source ../../.local-tools/env.sh
++ _devops_trace=0
++ case $- in
++ _devops_trace=1
++ set +x
++ unset _devops_trace
+ cd final-devops-project
+ kubectl create namespace a20-helm
namespace/a20-helm created
+ kubectl -n a20-helm create secret generic final-secret --from-file=value=/workspace/.local-tools/runtime/secret-good
secret/final-secret created
+ helm lint helm/final-app
==> Linting helm/final-app
[INFO] Chart.yaml: icon is recommended

1 chart(s) linted, 0 chart(s) failed
+ helm template final helm/final-app
+ helm install final helm/final-app -n a20-helm --wait --timeout=3m
NAME: final
LAST DEPLOYED: Wed Oct  7 09:03:27 2026
NAMESPACE: a20-helm
STATUS: deployed
REVISION: 1
DESCRIPTION: Install complete
TEST SUITE: None
+ kubectl -n a20-helm exec deployment/final-app -- python -c 'import urllib.request;print(urllib.request.urlopen('\''http://final-app/health'\'').read().decode())'
Defaulted container "app" out of: app, storage-permissions (init)
{"secret_injected":true,"status":"healthy","version":"v1"}

+ helm upgrade final helm/final-app -n a20-helm --set version=v2 --wait --timeout=3m
Release "final" has been upgraded. Happy Helming!
NAME: final
LAST DEPLOYED: Wed Oct  7 09:03:43 2026
NAMESPACE: a20-helm
STATUS: deployed
REVISION: 2
DESCRIPTION: Upgrade complete
TEST SUITE: None
+ kubectl -n a20-helm exec deployment/final-app -- python -c 'import urllib.request;print(urllib.request.urlopen('\''http://final-app/health'\'').read().decode())'
Defaulted container "app" out of: app, storage-permissions (init)
{"secret_injected":true,"status":"healthy","version":"v2"}

+ helm history final -n a20-helm
REVISION	UPDATED                 	STATUS    	CHART          	APP VERSION	DESCRIPTION     
1       	Wed Oct  7 09:03:27 2026	superseded	final-app-0.1.0	v1         	Install complete
2       	Wed Oct  7 09:03:43 2026	deployed  	final-app-0.1.0	v1         	Upgrade complete
+ helm rollback final 1 -n a20-helm --wait --timeout=3m
Rollback was a success! Happy Helming!
+ kubectl -n a20-helm exec deployment/final-app -- python -c 'import urllib.request;print(urllib.request.urlopen('\''http://final-app/health'\'').read().decode())'
Defaulted container "app" out of: app, storage-permissions (init)
{"secret_injected":true,"status":"healthy","version":"v1"}

+ helm uninstall final -n a20-helm
release "final" uninstalled
+ kubectl delete namespace a20-helm
namespace "a20-helm" deleted

```
