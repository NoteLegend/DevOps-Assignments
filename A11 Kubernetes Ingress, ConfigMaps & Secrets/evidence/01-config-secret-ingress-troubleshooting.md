# Executed commands and captured output

```bash
#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
minikube -p devops-course addons enable ingress
kubectl -n ingress-nginx rollout status deployment/ingress-nginx-controller --timeout=240s
kubectl create namespace a11
python3 - <<'PYGEN'
from pathlib import Path
import secrets
r=Path('../../.local-tools/runtime');v=secrets.token_hex(24);(r/'secret-good').write_text(v);(r/'secret-bad').write_text(v+'\n')
for p in [r/'secret-good',r/'secret-bad']:p.chmod(0o600)
PYGEN
kubectl -n a11 create secret generic db-secret --from-file=password=/workspace/.local-tools/runtime/secret-bad
kubectl -n a11 apply -f manifests
kubectl -n a11 rollout status deployment/config-demo --timeout=180s
kubectl -n a11 exec deployment/config-demo -- sh -c 'echo "ConfigMap value: $VERSION"; if [ -n "$DB_PASSWORD" ]; then echo "Secret injected: PASS (value hidden)"; fi'
# Course troubleshooting case: the trailing newline in a base64 source.
kubectl -n a11 exec deployment/config-demo -- sh -c 'case "$DB_PASSWORD" in *"
") echo "BEFORE: trailing newline detected" ;; *) exit 1 ;; esac'
kubectl -n a11 delete secret db-secret
kubectl -n a11 create secret generic db-secret --from-file=password=/workspace/.local-tools/runtime/secret-good
kubectl -n a11 rollout restart deployment/config-demo
kubectl -n a11 rollout status deployment/config-demo --timeout=180s
kubectl -n a11 exec deployment/config-demo -- sh -c 'case "$DB_PASSWORD" in *"
") exit 1 ;; *) echo "AFTER: Secret value is nonempty with no trailing newline" ;; esac'
node_ip=$(minikube -p devops-course ip)
../../.local-tools/vm.sh "curl -fsS -H 'Host: course.local' http://$node_ip"
kubectl -n a11 get deployment,svc,ingress,configmap
kubectl -n a11 describe ingress config-demo
kubectl delete namespace a11

```

```text
Executed 2026-10-07T13:47:40.182605+05:30
Working directory: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-11-Session-12
Script: verify.sh
Exit status: 0

+ source ../../.local-tools/env.sh
++ _devops_trace=0
++ case $- in
++ _devops_trace=1
++ set +x
++ unset _devops_trace
+ minikube -p devops-course addons enable ingress
* ingress is an addon maintained by Kubernetes. For any concerns contact minikube on GitHub.
You can view the list of minikube maintainers at: https://github.com/kubernetes/minikube/blob/master/OWNERS
  - Using image registry.k8s.io/ingress-nginx/controller:v1.15.1
  - Using image registry.k8s.io/ingress-nginx/kube-webhook-certgen:v1.6.9
  - Using image registry.k8s.io/ingress-nginx/kube-webhook-certgen:v1.6.9
* Verifying ingress addon...
* The 'ingress' addon is enabled
+ kubectl -n ingress-nginx rollout status deployment/ingress-nginx-controller --timeout=240s
Waiting for deployment "ingress-nginx-controller" rollout to finish: 0 of 1 updated replicas are available...
deployment "ingress-nginx-controller" successfully rolled out
+ kubectl create namespace a11
namespace/a11 created
+ python3 -
+ kubectl -n a11 create secret generic db-secret --from-file=password=/workspace/.local-tools/runtime/secret-bad
secret/db-secret created
+ kubectl -n a11 apply -f manifests
configmap/app-config created
deployment.apps/config-demo created
ingress.networking.k8s.io/config-demo created
service/config-demo created
+ kubectl -n a11 rollout status deployment/config-demo --timeout=180s
Waiting for deployment "config-demo" rollout to finish: 0 of 2 updated replicas are available...
Waiting for deployment "config-demo" rollout to finish: 1 of 2 updated replicas are available...
deployment "config-demo" successfully rolled out
+ kubectl -n a11 exec deployment/config-demo -- sh -c 'echo "ConfigMap value: $VERSION"; if [ -n "$DB_PASSWORD" ]; then echo "Secret injected: PASS (value hidden)"; fi'
ConfigMap value: Hello from ConfigMap
Secret injected: PASS (value hidden)
+ kubectl -n a11 exec deployment/config-demo -- sh -c $'case "$DB_PASSWORD" in *"\n") echo "BEFORE: trailing newline detected" ;; *) exit 1 ;; esac'
BEFORE: trailing newline detected
+ kubectl -n a11 delete secret db-secret
secret "db-secret" deleted from a11 namespace
+ kubectl -n a11 create secret generic db-secret --from-file=password=/workspace/.local-tools/runtime/secret-good
secret/db-secret created
+ kubectl -n a11 rollout restart deployment/config-demo
deployment.apps/config-demo restarted
+ kubectl -n a11 rollout status deployment/config-demo --timeout=180s
Waiting for deployment "config-demo" rollout to finish: 1 out of 2 new replicas have been updated...
Waiting for deployment "config-demo" rollout to finish: 1 out of 2 new replicas have been updated...
Waiting for deployment "config-demo" rollout to finish: 1 out of 2 new replicas have been updated...
Waiting for deployment "config-demo" rollout to finish: 1 old replicas are pending termination...
Waiting for deployment "config-demo" rollout to finish: 1 old replicas are pending termination...
deployment "config-demo" successfully rolled out
+ kubectl -n a11 exec deployment/config-demo -- sh -c $'case "$DB_PASSWORD" in *"\n") exit 1 ;; *) echo "AFTER: Secret value is nonempty with no trailing newline" ;; esac'
AFTER: Secret value is nonempty with no trailing newline
++ minikube -p devops-course ip
+ node_ip=192.168.49.2
+ ../../.local-tools/vm.sh 'curl -fsS -H '\''Host: course.local'\'' http://192.168.49.2'
Hello from ConfigMap
+ kubectl -n a11 get deployment,svc,ingress,configmap
NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/config-demo   2/2     2            2           22s

NAME                  TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
service/config-demo   ClusterIP   10.96.82.147   <none>        80/TCP    22s

NAME                                    CLASS   HOSTS          ADDRESS   PORTS   AGE
ingress.networking.k8s.io/config-demo   nginx   course.local             80      22s

NAME                         DATA   AGE
configmap/app-config         2      22s
configmap/kube-root-ca.crt   1      23s
+ kubectl -n a11 describe ingress config-demo
Name:             config-demo
Labels:           <none>
Namespace:        a11
Address:          
Ingress Class:    nginx
Default backend:  <default>
Rules:
  Host          Path  Backends
  ----          ----  --------
  course.local  
                /   config-demo:80 (10.244.0.57:8080,10.244.0.58:8080)
Annotations:    <none>
Events:
  Type    Reason  Age   From                      Message
  ----    ------  ----  ----                      -------
  Normal  Sync    22s   nginx-ingress-controller  Scheduled for sync
+ kubectl delete namespace a11
namespace "a11" deleted

```
