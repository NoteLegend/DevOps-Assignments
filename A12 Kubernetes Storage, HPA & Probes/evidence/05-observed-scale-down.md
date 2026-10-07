# Executed commands and captured output

```bash
#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
for attempt in {1..45}; do
 kubectl -n production-webapp get hpa,pods
 replicas=$(kubectl -n production-webapp get deploy web-app -o jsonpath='{.spec.replicas}')
 if [[ "$replicas" = 2 ]]; then break; fi
 sleep 10
done
test "$replicas" = 2
kubectl -n production-webapp exec deployment/web-app -- cat /data/student.txt
kubectl -n production-webapp describe hpa web-app-hpa

```

```text
Executed 2026-10-07T13:55:37.958244+05:30
Working directory: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-12-Session-13
Script: observe-scale-down.sh
Exit status: 1

+ source ../../.local-tools/env.sh
++ _devops_trace=0
++ case $- in
++ _devops_trace=1
++ set +x
++ unset _devops_trace
+ for attempt in {1..45}
+ kubectl -n production-webapp get hpa,pods
No resources found in production-webapp namespace.
++ kubectl -n production-webapp get deploy web-app -o 'jsonpath={.spec.replicas}'
Error from server (NotFound): namespaces "production-webapp" not found
+ replicas=

```
