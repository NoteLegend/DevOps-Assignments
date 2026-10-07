# Executed commands and captured output

```bash
#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
kubectl create namespace a19
git -C gitops/desired init -b main
git -C gitops/desired config user.name 'DevOps Practical'
git -C gitops/desired config user.email 'practical@example.invalid'
git -C gitops/desired add deployment.yaml
git -C gitops/desired commit -m 'Declare initial local Kubernetes workload'
../../.local-tools/vm.sh 'nohup python3 /workspace/DevOps-Assignments/Assignment-19-Session-20/gitops/reconcile.py >/tmp/devops-a19-reconcile.log 2>&1 </dev/null & echo $! >/tmp/devops-a19-reconcile.pid'
sleep 10
kubectl -n a19 rollout status deployment/gitops-web --timeout=180s
kubectl -n a19 exec deployment/gitops-web -- wget -qO- http://localhost:8080
kubectl -n a19 scale deployment/gitops-web --replicas=3
kubectl -n a19 get deploy gitops-web
sleep 10
kubectl -n a19 get deploy gitops-web -o jsonpath='{.spec.replicas}{"\n"}' | grep '^1$'
sed -i 's/gitops-v1/gitops-v2/' gitops/desired/deployment.yaml
git -C gitops/desired add deployment.yaml
git -C gitops/desired commit -m 'Declare version two in Git'
sleep 10
kubectl -n a19 rollout status deployment/gitops-web --timeout=180s
kubectl -n a19 exec deployment/gitops-web -- wget -qO- http://localhost:8080 | grep gitops-v2
../../.local-tools/vm.sh 'cat /tmp/devops-a19-reconcile.log; kill "$(cat /tmp/devops-a19-reconcile.pid)"'
git -C gitops/desired log --oneline
git -C gitops/desired remote -v
git -C gitops/desired bundle create ../history.bundle --all
git -C gitops/desired bundle verify ../history.bundle
kubectl delete namespace a19

```

```text
Executed 2026-10-07T14:23:51.236900+05:30
Working directory: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-19-Session-20
Script: gitops.sh
Exit status: 0

+ source ../../.local-tools/env.sh
++ _devops_trace=0
++ case $- in
++ _devops_trace=1
++ set +x
++ unset _devops_trace
+ kubectl create namespace a19
namespace/a19 created
+ git -C gitops/desired init -b main
Initialized empty Git repository in /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-19-Session-20/gitops/desired/.git/
+ git -C gitops/desired config user.name 'DevOps Practical'
+ git -C gitops/desired config user.email practical@example.invalid
+ git -C gitops/desired add deployment.yaml
+ git -C gitops/desired commit -m 'Declare initial local Kubernetes workload'
[main (root-commit) b742bd6] Declare initial local Kubernetes workload
 1 file changed, 40 insertions(+)
 create mode 100644 deployment.yaml
+ ../../.local-tools/vm.sh 'nohup python3 /workspace/DevOps-Assignments/Assignment-19-Session-20/gitops/reconcile.py >/tmp/devops-a19-reconcile.log 2>&1 </dev/null & echo $! >/tmp/devops-a19-reconcile.pid'
+ sleep 10
+ kubectl -n a19 rollout status deployment/gitops-web --timeout=180s
deployment "gitops-web" successfully rolled out
+ kubectl -n a19 exec deployment/gitops-web -- wget -qO- http://localhost:8080
gitops-v1
+ kubectl -n a19 scale deployment/gitops-web --replicas=3
deployment.apps/gitops-web scaled
+ kubectl -n a19 get deploy gitops-web
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
gitops-web   1/3     3            1           11s
+ sleep 10
+ kubectl -n a19 get deploy gitops-web -o 'jsonpath={.spec.replicas}{"\n"}'
+ grep '^1$'
1
+ sed -i s/gitops-v1/gitops-v2/ gitops/desired/deployment.yaml
+ git -C gitops/desired add deployment.yaml
+ git -C gitops/desired commit -m 'Declare version two in Git'
[main 464b74e] Declare version two in Git
 1 file changed, 1 insertion(+), 1 deletion(-)
+ sleep 10
+ kubectl -n a19 rollout status deployment/gitops-web --timeout=180s
Waiting for deployment "gitops-web" rollout to finish: 1 old replicas are pending termination...
Waiting for deployment "gitops-web" rollout to finish: 1 old replicas are pending termination...
deployment "gitops-web" successfully rolled out
+ kubectl -n a19 exec deployment/gitops-web -- wget -qO- http://localhost:8080
+ grep gitops-v2
gitops-v2
+ ../../.local-tools/vm.sh 'cat /tmp/devops-a19-reconcile.log; kill "$(cat /tmp/devops-a19-reconcile.pid)"'
commit=b742bd6dcc787d5cf91d3482fcab25ab7425333e exit=0 deployment.apps/gitops-web created 
commit=b742bd6dcc787d5cf91d3482fcab25ab7425333e exit=0 deployment.apps/gitops-web unchanged 
commit=b742bd6dcc787d5cf91d3482fcab25ab7425333e exit=0 deployment.apps/gitops-web unchanged 
commit=b742bd6dcc787d5cf91d3482fcab25ab7425333e exit=0 deployment.apps/gitops-web configured 
commit=b742bd6dcc787d5cf91d3482fcab25ab7425333e exit=0 deployment.apps/gitops-web unchanged 
commit=464b74ec67792d03aceb0cf96a95191d41d66d4a exit=0 deployment.apps/gitops-web configured 
commit=464b74ec67792d03aceb0cf96a95191d41d66d4a exit=0 deployment.apps/gitops-web unchanged 
+ git -C gitops/desired log --oneline
464b74e Declare version two in Git
b742bd6 Declare initial local Kubernetes workload
+ git -C gitops/desired remote -v
+ git -C gitops/desired bundle create ../history.bundle --all
+ git -C gitops/desired bundle verify ../history.bundle
../history.bundle is okay
The bundle contains these 2 refs:
464b74ec67792d03aceb0cf96a95191d41d66d4a refs/heads/main
464b74ec67792d03aceb0cf96a95191d41d66d4a HEAD
The bundle records a complete history.
The bundle uses this hash algorithm: sha1
+ kubectl delete namespace a19
namespace "a19" deleted

```
