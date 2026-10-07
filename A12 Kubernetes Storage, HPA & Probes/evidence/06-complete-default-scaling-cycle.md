# Executed commands and captured output

```bash
#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
kubectl apply -f mini-project
kubectl -n production-webapp rollout status deployment/web-app --timeout=180s
kubectl -n production-webapp exec deployment/web-app -- sh -c 'echo "Student: <YOUR NAME>" >/data/student.txt'
pod=$(kubectl -n production-webapp get pods -l app=web-app -o jsonpath='{.items[0].metadata.name}')
kubectl -n production-webapp delete pod "$pod"
kubectl -n production-webapp rollout status deployment/web-app --timeout=180s
kubectl -n production-webapp exec deployment/web-app -- cat /data/student.txt
kubectl -n production-webapp run load-generator --image=busybox:1.36 --restart=Never --command -- sh -c 'for i in 1 2 3 4 5 6 7 8 9 10 11 12; do (while true; do wget -qO- http://web-service >/dev/null; done) & done; wait'
for attempt in {1..40}; do
 kubectl -n production-webapp get hpa,pods
 replicas=$(kubectl -n production-webapp get deploy web-app -o jsonpath='{.spec.replicas}')
 if ((replicas > 2)); then break; fi
 sleep 10
done
test "$replicas" -gt 2
kubectl -n production-webapp delete pod load-generator --grace-period=1
for attempt in {1..55}; do
 kubectl -n production-webapp get hpa,pods
 replicas=$(kubectl -n production-webapp get deploy web-app -o jsonpath='{.spec.replicas}')
 if [[ "$replicas" = 2 ]]; then break; fi
 sleep 10
done
test "$replicas" = 2
kubectl -n production-webapp describe hpa web-app-hpa
kubectl delete namespace production-webapp

```

```text
Executed 2026-10-07T13:56:24.208735+05:30
Working directory: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-12-Session-13
Script: verify-complete-scaling-cycle.sh
Exit status: 1

+ source ../../.local-tools/env.sh
++ _devops_trace=0
++ case $- in
++ _devops_trace=1
++ set +x
++ unset _devops_trace
+ kubectl apply -f mini-project
pod/liveness-demo created
pod/readiness-demo created
pod/startup-demo created
namespace/production-webapp created
persistentvolumeclaim/web-data created
service/web-service created
Error from server (NotFound): error when creating "mini-project/deployment.yaml": namespaces "production-webapp" not found
Error from server (NotFound): error when creating "mini-project/hpa.yaml": namespaces "production-webapp" not found

```
