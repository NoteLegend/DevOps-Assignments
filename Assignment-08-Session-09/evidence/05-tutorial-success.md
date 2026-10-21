# Executed commands and captured output

```bash
#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
minikube start -p devops-course --driver=docker --cpus=3 --memory=4096 --kubernetes-version=v1.36.0
minikube status -p devops-course
kubectl version
kubectl cluster-info
kubectl wait --for=condition=Ready nodes --all --timeout=240s
kubectl get nodes -o wide
kubectl get pods -n kube-system
kubectl create namespace a08 --dry-run=client -o yaml | kubectl apply -f -
kubectl -n a08 create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1 --dry-run=client -o yaml | kubectl apply -f -
kubectl -n a08 rollout status deployment/kubernetes-bootcamp --timeout=180s
kubectl -n a08 get deployments,pods
kubectl -n a08 describe deployment kubernetes-bootcamp
kubectl -n a08 logs deployment/kubernetes-bootcamp
kubectl -n a08 exec deployment/kubernetes-bootcamp -- env | grep -E 'HOSTNAME|KUBERNETES_SERVICE_HOST'
kubectl -n a08 expose deployment kubernetes-bootcamp --type=NodePort --port=8080 --dry-run=client -o yaml | kubectl apply -f -
../../.local-tools/vm.sh 'test ! -f /tmp/devops-a08-forward.pid || kill "$(cat /tmp/devops-a08-forward.pid)" 2>/dev/null || true'
../../.local-tools/vm.sh 'nohup kubectl -n a08 port-forward --address=0.0.0.0 svc/kubernetes-bootcamp 8080:8080 >/tmp/devops-a08-forward.log 2>&1 </dev/null & echo $! >/tmp/devops-a08-forward.pid'
curl --retry 15 --retry-all-errors --retry-delay 2 --max-time 10 -fsS http://127.0.0.1:8080
/tmp/devops-tools-venv/bin/python ../../.local-tools/evidence.py . 02-tutorial-application --url http://127.0.0.1:8080
kubectl -n a08 scale deployment kubernetes-bootcamp --replicas=4
kubectl -n a08 rollout status deployment/kubernetes-bootcamp --timeout=180s
kubectl -n a08 get pods -o wide
kubectl -n a08 set image deployment/kubernetes-bootcamp kubernetes-bootcamp=docker.io/jocatalin/kubernetes-bootcamp:v2
kubectl -n a08 rollout status deployment/kubernetes-bootcamp --timeout=180s
kubectl -n a08 get pods
kubectl -n a08 rollout history deployment/kubernetes-bootcamp
kubectl -n a08 rollout undo deployment/kubernetes-bootcamp
kubectl -n a08 rollout status deployment/kubernetes-bootcamp --timeout=180s
kubectl -n a08 get deployment kubernetes-bootcamp -o jsonpath='{.spec.template.spec.containers[0].image}{"\n"}'
kubectl -n a08 get deployment,svc -o yaml > evidence/tutorial-resources.yaml
../../.local-tools/vm.sh 'kill "$(cat /tmp/devops-a08-forward.pid)"'
kubectl delete namespace a08

```

```text
Executed 2026-10-07T13:40:27.212384+05:30
Working directory: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-08-Session-09
Script: tutorial.sh
Exit status: 0

+ source ../../.local-tools/env.sh
++ _devops_trace=0
++ case $- in
++ _devops_trace=1
++ set +x
++ unset _devops_trace
+ minikube start -p devops-course --driver=docker --cpus=3 --memory=4096 --kubernetes-version=v1.36.0
* [devops-course] minikube v1.39.0 on Ubuntu 24.04 (kvm/amd64)
* Kubernetes 1.37.0 is now available. If you would like to upgrade, specify: --kubernetes-version=v1.37.0
* Using the docker driver based on existing profile
* Starting "devops-course" primary control-plane node in "devops-course" cluster
* Pulling base image v0.0.51 ...
* Preparing Kubernetes v1.36.0 on containerd 2.3.4 ...
* Verifying Kubernetes components...
  - Using image gcr.io/k8s-minikube/storage-provisioner:v5
* Enabled addons: default-storageclass, storage-provisioner
* Done! kubectl is now configured to use "devops-course" cluster and "default" namespace by default
+ minikube status -p devops-course
devops-course
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured

+ kubectl version
Client Version: v1.37.1
Kustomize Version: v5.8.1
Server Version: v1.36.0
+ kubectl cluster-info
Kubernetes control plane is running at https://192.168.49.2:8443
CoreDNS is running at https://192.168.49.2:8443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
+ kubectl wait --for=condition=Ready nodes --all --timeout=240s
node/devops-course condition met
+ kubectl get nodes -o wide
NAME            STATUS   ROLES           AGE   VERSION   INTERNAL-IP    EXTERNAL-IP   OS-IMAGE                         KERNEL-VERSION              CONTAINER-RUNTIME
devops-course   Ready    control-plane   11m   v1.36.0   192.168.49.2   <none>        Debian GNU/Linux 12 (bookworm)   6.8.0-142-generic (amd64)   containerd://2.3.4
+ kubectl get pods -n kube-system
NAME                                    READY   STATUS    RESTARTS   AGE
coredns-589f44dc88-7r7bm                1/1     Running   0          11m
etcd-devops-course                      1/1     Running   0          11m
kindnet-w2tvm                           1/1     Running   0          6m56s
kube-apiserver-devops-course            1/1     Running   0          11m
kube-controller-manager-devops-course   1/1     Running   0          11m
kube-proxy-qg2k5                        1/1     Running   0          11m
kube-scheduler-devops-course            1/1     Running   0          11m
storage-provisioner                     1/1     Running   0          11m
+ kubectl create namespace a08 --dry-run=client -o yaml
+ kubectl apply -f -
namespace/a08 unchanged
+ kubectl -n a08 create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1 --dry-run=client -o yaml
+ kubectl apply -f -
deployment.apps/kubernetes-bootcamp unchanged
+ kubectl -n a08 rollout status deployment/kubernetes-bootcamp --timeout=180s
deployment "kubernetes-bootcamp" successfully rolled out
+ kubectl -n a08 get deployments,pods
NAME                                  READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/kubernetes-bootcamp   1/1     1            1           11m

NAME                                      READY   STATUS    RESTARTS   AGE
pod/kubernetes-bootcamp-66d5c96cb-f2vl2   1/1     Running   0          11m
+ kubectl -n a08 describe deployment kubernetes-bootcamp
Name:                   kubernetes-bootcamp
Namespace:              a08
CreationTimestamp:      Wed, 07 Oct 2026 07:58:12 +0000
Labels:                 app=kubernetes-bootcamp
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=kubernetes-bootcamp
Replicas:               1 desired | 1 updated | 1 total | 1 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=kubernetes-bootcamp
  Containers:
   kubernetes-bootcamp:
    Image:         gcr.io/google-samples/kubernetes-bootcamp:v1
    Port:          <none>
    Host Port:     <none>
    Environment:   <none>
    Mounts:        <none>
  Volumes:         <none>
  Node-Selectors:  <none>
  Tolerations:     <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   kubernetes-bootcamp-66d5c96cb (1/1 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  11m   deployment-controller  Scaled up replica set kubernetes-bootcamp-66d5c96cb from 0 to 1
+ kubectl -n a08 logs deployment/kubernetes-bootcamp
Kubernetes Bootcamp App Started At: 2026-10-07T08:03:08.652Z | Running On:  kubernetes-bootcamp-66d5c96cb-f2vl2 

Running On: kubernetes-bootcamp-66d5c96cb-f2vl2 | Total Requests: 1 | App Uptime: 341.382 seconds | Log Time: 2026-10-07T08:08:50.034Z
Running On: kubernetes-bootcamp-66d5c96cb-f2vl2 | Total Requests: 2 | App Uptime: 341.62 seconds | Log Time: 2026-10-07T08:08:50.272Z
+ kubectl -n a08 exec deployment/kubernetes-bootcamp -- env
+ grep -E 'HOSTNAME|KUBERNETES_SERVICE_HOST'
HOSTNAME=kubernetes-bootcamp-66d5c96cb-f2vl2
KUBERNETES_SERVICE_HOST=10.96.0.1
+ kubectl -n a08 expose deployment kubernetes-bootcamp --type=NodePort --port=8080 --dry-run=client -o yaml
+ kubectl apply -f -
service/kubernetes-bootcamp unchanged
+ ../../.local-tools/vm.sh 'test ! -f /tmp/devops-a08-forward.pid || kill "$(cat /tmp/devops-a08-forward.pid)" 2>/dev/null || true'
+ ../../.local-tools/vm.sh 'nohup kubectl -n a08 port-forward --address=0.0.0.0 svc/kubernetes-bootcamp 8080:8080 >/tmp/devops-a08-forward.log 2>&1 </dev/null & echo $! >/tmp/devops-a08-forward.pid'
+ curl --retry 15 --retry-all-errors --retry-delay 2 --max-time 10 -fsS http://127.0.0.1:8080
curl: (56) Recv failure: Connection reset by peer
Hello Kubernetes bootcamp! | Running on: kubernetes-bootcamp-66d5c96cb-f2vl2 | v=1
+ /tmp/devops-tools-venv/bin/python ../../.local-tools/evidence.py . 02-tutorial-application --url http://127.0.0.1:8080
+ kubectl -n a08 scale deployment kubernetes-bootcamp --replicas=4
deployment.apps/kubernetes-bootcamp scaled
+ kubectl -n a08 rollout status deployment/kubernetes-bootcamp --timeout=180s
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 1 of 4 updated replicas are available...
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 2 of 4 updated replicas are available...
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 3 of 4 updated replicas are available...
deployment "kubernetes-bootcamp" successfully rolled out
+ kubectl -n a08 get pods -o wide
NAME                                  READY   STATUS    RESTARTS   AGE   IP           NODE            NOMINATED NODE   READINESS GATES
kubernetes-bootcamp-66d5c96cb-5nhfj   1/1     Running   0          2s    10.244.0.4   devops-course   <none>           <none>
kubernetes-bootcamp-66d5c96cb-bf52s   1/1     Running   0          2s    10.244.0.6   devops-course   <none>           <none>
kubernetes-bootcamp-66d5c96cb-f2vl2   1/1     Running   0          11m   10.244.0.3   devops-course   <none>           <none>
kubernetes-bootcamp-66d5c96cb-wkx8k   1/1     Running   0          2s    10.244.0.5   devops-course   <none>           <none>
+ kubectl -n a08 set image deployment/kubernetes-bootcamp kubernetes-bootcamp=docker.io/jocatalin/kubernetes-bootcamp:v2
deployment.apps/kubernetes-bootcamp image updated
+ kubectl -n a08 rollout status deployment/kubernetes-bootcamp --timeout=180s
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 1 out of 4 new replicas have been updated...
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 2 out of 4 new replicas have been updated...
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 2 out of 4 new replicas have been updated...
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 2 out of 4 new replicas have been updated...
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 2 out of 4 new replicas have been updated...
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 2 out of 4 new replicas have been updated...
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 3 out of 4 new replicas have been updated...
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 3 out of 4 new replicas have been updated...
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 3 out of 4 new replicas have been updated...
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 3 out of 4 new replicas have been updated...
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 1 old replicas are pending termination...
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 1 old replicas are pending termination...
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 1 old replicas are pending termination...
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 3 of 4 updated replicas are available...
deployment "kubernetes-bootcamp" successfully rolled out
+ kubectl -n a08 get pods
NAME                                   READY   STATUS        RESTARTS   AGE
kubernetes-bootcamp-66d5c96cb-5nhfj    1/1     Terminating   0          7s
kubernetes-bootcamp-66d5c96cb-bf52s    1/1     Terminating   0          7s
kubernetes-bootcamp-66d5c96cb-f2vl2    1/1     Terminating   0          11m
kubernetes-bootcamp-66d5c96cb-wkx8k    1/1     Terminating   0          7s
kubernetes-bootcamp-7c5b86fcf9-bz26b   1/1     Running       0          4s
kubernetes-bootcamp-7c5b86fcf9-j7wm8   1/1     Running       0          2s
kubernetes-bootcamp-7c5b86fcf9-xc82j   1/1     Running       0          4s
kubernetes-bootcamp-7c5b86fcf9-zgvc9   1/1     Running       0          3s
+ kubectl -n a08 rollout history deployment/kubernetes-bootcamp
deployment.apps/kubernetes-bootcamp 
REVISION  CHANGE-CAUSE
1         <none>
2         <none>

+ kubectl -n a08 rollout undo deployment/kubernetes-bootcamp
Warning: resource deployments/kubernetes-bootcamp was previously managed with 'kubectl apply'. Rolling back will not update the kubectl.kubernetes.io/last-applied-configuration annotation, which may cause unexpected behavior on future 'kubectl apply' operations. Consider using 'kubectl apply' with your previous configuration file instead.
deployment.apps/kubernetes-bootcamp rolled back
+ kubectl -n a08 rollout status deployment/kubernetes-bootcamp --timeout=180s
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 1 out of 4 new replicas have been updated...
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 2 out of 4 new replicas have been updated...
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 2 out of 4 new replicas have been updated...
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 2 out of 4 new replicas have been updated...
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 3 out of 4 new replicas have been updated...
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 3 out of 4 new replicas have been updated...
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 3 out of 4 new replicas have been updated...
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 3 out of 4 new replicas have been updated...
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 1 old replicas are pending termination...
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 1 old replicas are pending termination...
Waiting for deployment "kubernetes-bootcamp" rollout to finish: 1 old replicas are pending termination...
deployment "kubernetes-bootcamp" successfully rolled out
+ kubectl -n a08 get deployment kubernetes-bootcamp -o 'jsonpath={.spec.template.spec.containers[0].image}{"\n"}'
gcr.io/google-samples/kubernetes-bootcamp:v1
+ kubectl -n a08 get deployment,svc -o yaml
+ ../../.local-tools/vm.sh 'kill "$(cat /tmp/devops-a08-forward.pid)"'
+ kubectl delete namespace a08
namespace "a08" deleted

```
