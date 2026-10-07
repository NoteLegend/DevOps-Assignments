# Executed commands and captured output

```bash
#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
minikube -p devops-course addons enable metrics-server
kubectl -n kube-system rollout status deployment/metrics-server --timeout=180s
kubectl create namespace a12
kubectl -n a12 apply -f hpa
kubectl -n a12 rollout status deployment/hpa-demo --timeout=180s
kubectl -n a12 get hpa,pods
kubectl -n a12 run load-generator --image=busybox:1.36 --restart=Never --command -- sh -c 'for i in 1 2 3 4 5 6 7 8; do (while true; do wget -qO- http://hpa-demo-service >/dev/null; done) & done; wait'
for attempt in {1..36}; do
 kubectl -n a12 get hpa
 kubectl -n a12 top pods || true
 replicas=$(kubectl -n a12 get deploy hpa-demo -o jsonpath='{.spec.replicas}')
 if ((replicas > 1)); then break; fi
 sleep 10
done
test "$replicas" -gt 1
kubectl -n a12 describe hpa hpa-demo
kubectl -n a12 get pods -o wide
kubectl -n a12 delete pod load-generator
kubectl apply -f mini-project/namespace.yaml -f mini-project/pvc.yaml -f mini-project/deployment.yaml -f mini-project/service.yaml -f mini-project/hpa.yaml
kubectl -n production-webapp rollout status deployment/web-app --timeout=180s
kubectl -n production-webapp get pvc,hpa,pods
pod=$(kubectl -n production-webapp get pods -l app=web-app -o jsonpath='{.items[0].metadata.name}')
kubectl -n production-webapp exec "$pod" -- sh -c 'echo "DevOps practical persistence check" >/data/student.txt'
kubectl -n production-webapp exec "$pod" -- cat /data/student.txt
kubectl -n production-webapp delete pod "$pod"
kubectl -n production-webapp rollout status deployment/web-app --timeout=180s
kubectl -n production-webapp exec deployment/web-app -- cat /data/student.txt
kubectl -n production-webapp exec deployment/web-app -- curl -fsS localhost
kubectl -n production-webapp run load-generator --image=busybox:1.36 --restart=Never --command -- sh -c 'for i in 1 2 3 4 5 6 7 8 9 10 11 12; do (while true; do wget -qO- http://web-service >/dev/null; done) & done; wait'
for attempt in {1..36}; do
 kubectl -n production-webapp get hpa
 kubectl -n production-webapp top pods || true
 replicas=$(kubectl -n production-webapp get deploy web-app -o jsonpath='{.spec.replicas}')
 if ((replicas > 2)); then break; fi
 sleep 10
done
test "$replicas" -gt 2
kubectl -n production-webapp describe hpa web-app-hpa
kubectl -n production-webapp delete pod load-generator
kubectl -n production-webapp get deployment web-app -o jsonpath='{.spec.template.spec.containers[0].startupProbe}{"\n"}{.spec.template.spec.containers[0].readinessProbe}{"\n"}{.spec.template.spec.containers[0].livenessProbe}{"\n"}'
kubectl delete namespace a12 production-webapp

```

```text
Executed 2026-10-07T13:55:18.739147+05:30
Working directory: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-12-Session-13
Script: verify.sh
Exit status: 0

+ source ../../.local-tools/env.sh
++ _devops_trace=0
++ case $- in
++ _devops_trace=1
++ set +x
++ unset _devops_trace
+ minikube -p devops-course addons enable metrics-server
* metrics-server is an addon maintained by Kubernetes. For any concerns contact minikube on GitHub.
You can view the list of minikube maintainers at: https://github.com/kubernetes/minikube/blob/master/OWNERS
  - Using image registry.k8s.io/metrics-server/metrics-server:v0.9.0
* The 'metrics-server' addon is enabled
+ kubectl -n kube-system rollout status deployment/metrics-server --timeout=180s
Waiting for deployment "metrics-server" rollout to finish: 0 of 1 updated replicas are available...
deployment "metrics-server" successfully rolled out
+ kubectl create namespace a12
namespace/a12 created
+ kubectl -n a12 apply -f hpa
deployment.apps/hpa-demo created
horizontalpodautoscaler.autoscaling/hpa-demo created
service/hpa-demo-service created
+ kubectl -n a12 rollout status deployment/hpa-demo --timeout=180s
Waiting for deployment "hpa-demo" rollout to finish: 0 of 1 updated replicas are available...
deployment "hpa-demo" successfully rolled out
+ kubectl -n a12 get hpa,pods
NAME                                           REFERENCE             TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
horizontalpodautoscaler.autoscaling/hpa-demo   Deployment/hpa-demo   cpu: <unknown>/50%   1         5         0          1s

NAME                            READY   STATUS    RESTARTS   AGE
pod/hpa-demo-6949d84d5b-gq8gs   1/1     Running   0          1s
+ kubectl -n a12 run load-generator --image=busybox:1.36 --restart=Never --command -- sh -c 'for i in 1 2 3 4 5 6 7 8; do (while true; do wget -qO- http://hpa-demo-service >/dev/null; done) & done; wait'
pod/load-generator created
+ for attempt in {1..36}
+ kubectl -n a12 get hpa
NAME       REFERENCE             TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
hpa-demo   Deployment/hpa-demo   cpu: <unknown>/50%   1         5         0          2s
+ kubectl -n a12 top pods
error: metrics not available yet
+ true
++ kubectl -n a12 get deploy hpa-demo -o 'jsonpath={.spec.replicas}'
+ replicas=1
+ (( replicas > 1 ))
+ sleep 10
+ for attempt in {1..36}
+ kubectl -n a12 get hpa
NAME       REFERENCE             TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
hpa-demo   Deployment/hpa-demo   cpu: <unknown>/50%   1         5         0          14s
+ kubectl -n a12 top pods
error: metrics not available yet
+ true
++ kubectl -n a12 get deploy hpa-demo -o 'jsonpath={.spec.replicas}'
+ replicas=1
+ (( replicas > 1 ))
+ sleep 10
+ for attempt in {1..36}
+ kubectl -n a12 get hpa
NAME       REFERENCE             TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
hpa-demo   Deployment/hpa-demo   cpu: <unknown>/50%   1         5         1          25s
+ kubectl -n a12 top pods
error: metrics not available yet
+ true
++ kubectl -n a12 get deploy hpa-demo -o 'jsonpath={.spec.replicas}'
+ replicas=1
+ (( replicas > 1 ))
+ sleep 10
+ for attempt in {1..36}
+ kubectl -n a12 get hpa
NAME       REFERENCE             TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
hpa-demo   Deployment/hpa-demo   cpu: <unknown>/50%   1         5         1          36s
+ kubectl -n a12 top pods
error: metrics not available yet
+ true
++ kubectl -n a12 get deploy hpa-demo -o 'jsonpath={.spec.replicas}'
+ replicas=1
+ (( replicas > 1 ))
+ sleep 10
+ for attempt in {1..36}
+ kubectl -n a12 get hpa
NAME       REFERENCE             TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
hpa-demo   Deployment/hpa-demo   cpu: <unknown>/50%   1         5         1          48s
+ kubectl -n a12 top pods
error: metrics not available yet
+ true
++ kubectl -n a12 get deploy hpa-demo -o 'jsonpath={.spec.replicas}'
+ replicas=1
+ (( replicas > 1 ))
+ sleep 10
+ for attempt in {1..36}
+ kubectl -n a12 get hpa
NAME       REFERENCE             TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
hpa-demo   Deployment/hpa-demo   cpu: <unknown>/50%   1         5         1          59s
+ kubectl -n a12 top pods
NAME                        CPU(cores)   MEMORY(bytes)   
hpa-demo-6949d84d5b-gq8gs   187m         4Mi             
load-generator              2425m        7Mi             
++ kubectl -n a12 get deploy hpa-demo -o 'jsonpath={.spec.replicas}'
+ replicas=1
+ (( replicas > 1 ))
+ sleep 10
+ for attempt in {1..36}
+ kubectl -n a12 get hpa
NAME       REFERENCE             TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
hpa-demo   Deployment/hpa-demo   cpu: <unknown>/50%   1         5         1          70s
+ kubectl -n a12 top pods
NAME                        CPU(cores)   MEMORY(bytes)   
hpa-demo-6949d84d5b-gq8gs   187m         4Mi             
load-generator              2425m        7Mi             
++ kubectl -n a12 get deploy hpa-demo -o 'jsonpath={.spec.replicas}'
+ replicas=1
+ (( replicas > 1 ))
+ sleep 10
+ for attempt in {1..36}
+ kubectl -n a12 get hpa
NAME       REFERENCE             TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
hpa-demo   Deployment/hpa-demo   cpu: <unknown>/50%   1         5         1          82s
+ kubectl -n a12 top pods
NAME                        CPU(cores)   MEMORY(bytes)   
hpa-demo-6949d84d5b-gq8gs   187m         4Mi             
load-generator              2425m        7Mi             
++ kubectl -n a12 get deploy hpa-demo -o 'jsonpath={.spec.replicas}'
+ replicas=1
+ (( replicas > 1 ))
+ sleep 10
+ for attempt in {1..36}
+ kubectl -n a12 get hpa
NAME       REFERENCE             TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
hpa-demo   Deployment/hpa-demo   cpu: <unknown>/50%   1         5         1          93s
+ kubectl -n a12 top pods
NAME                        CPU(cores)   MEMORY(bytes)   
hpa-demo-6949d84d5b-gq8gs   187m         4Mi             
load-generator              2425m        7Mi             
++ kubectl -n a12 get deploy hpa-demo -o 'jsonpath={.spec.replicas}'
+ replicas=1
+ (( replicas > 1 ))
+ sleep 10
+ for attempt in {1..36}
+ kubectl -n a12 get hpa
NAME       REFERENCE             TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
hpa-demo   Deployment/hpa-demo   cpu: <unknown>/50%   1         5         1          104s
+ kubectl -n a12 top pods
NAME                        CPU(cores)   MEMORY(bytes)   
hpa-demo-6949d84d5b-gq8gs   187m         4Mi             
load-generator              2425m        7Mi             
++ kubectl -n a12 get deploy hpa-demo -o 'jsonpath={.spec.replicas}'
+ replicas=1
+ (( replicas > 1 ))
+ sleep 10
+ for attempt in {1..36}
+ kubectl -n a12 get hpa
NAME       REFERENCE             TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
hpa-demo   Deployment/hpa-demo   cpu: <unknown>/50%   1         5         1          116s
+ kubectl -n a12 top pods
NAME                        CPU(cores)   MEMORY(bytes)   
hpa-demo-6949d84d5b-gq8gs   173m         5Mi             
load-generator              2641m        9Mi             
++ kubectl -n a12 get deploy hpa-demo -o 'jsonpath={.spec.replicas}'
+ replicas=1
+ (( replicas > 1 ))
+ sleep 10
+ for attempt in {1..36}
+ kubectl -n a12 get hpa
NAME       REFERENCE             TARGETS         MINPODS   MAXPODS   REPLICAS   AGE
hpa-demo   Deployment/hpa-demo   cpu: 173%/50%   1         5         1          2m7s
+ kubectl -n a12 top pods
NAME                        CPU(cores)   MEMORY(bytes)   
hpa-demo-6949d84d5b-gq8gs   173m         5Mi             
load-generator              2641m        9Mi             
++ kubectl -n a12 get deploy hpa-demo -o 'jsonpath={.spec.replicas}'
+ replicas=4
+ (( replicas > 1 ))
+ break
+ test 4 -gt 1
+ kubectl -n a12 describe hpa hpa-demo
Name:                                                  hpa-demo
Namespace:                                             a12
Labels:                                                <none>
Annotations:                                           <none>
CreationTimestamp:                                     Wed, 07 Oct 2026 08:19:35 +0000
Reference:                                             Deployment/hpa-demo
Metrics:                                               ( current / target )
  resource cpu on pods  (as a percentage of request):  173% (173m) / 50%
Min replicas:                                          1
Max replicas:                                          5
Deployment pods:                                       1 current / 4 desired
Conditions:
  Type            Status  Reason              Message
  ----            ------  ------              -------
  AbleToScale     True    SucceededRescale    the HPA controller was able to update the target scale to 4
  ScalingActive   True    ValidMetricFound    the HPA was able to successfully calculate a replica count from cpu resource utilization (percentage of request)
  ScalingLimited  False   DesiredWithinRange  the desired count is within the acceptable range
Events:
  Type     Reason                        Age                 From                       Message
  ----     ------                        ----                ----                       -------
  Warning  FailedGetResourceMetric       83s (x3 over 113s)  horizontal-pod-autoscaler  failed to get cpu utilization: unable to get metrics for resource cpu: no metrics returned from resource metrics API
  Warning  FailedComputeMetricsReplicas  83s (x3 over 113s)  horizontal-pod-autoscaler  invalid metrics (1 invalid out of 1), first error is: failed to get cpu resource metric value: failed to get cpu utilization: unable to get metrics for resource cpu: no metrics returned from resource metrics API
  Warning  FailedGetResourceMetric       23s (x4 over 68s)   horizontal-pod-autoscaler  failed to get cpu utilization: did not receive metrics for targeted pods (pods might be unready)
  Warning  FailedComputeMetricsReplicas  23s (x4 over 68s)   horizontal-pod-autoscaler  invalid metrics (1 invalid out of 1), first error is: failed to get cpu resource metric value: failed to get cpu utilization: did not receive metrics for targeted pods (pods might be unready)
  Normal   SuccessfulRescale             8s                  horizontal-pod-autoscaler  New size: 4; reason: cpu resource utilization (percentage of request) above target
+ kubectl -n a12 get pods -o wide
NAME                        READY   STATUS    RESTARTS   AGE    IP            NODE            NOMINATED NODE   READINESS GATES
hpa-demo-6949d84d5b-5fks9   1/1     Running   0          9s     10.244.0.69   devops-course   <none>           <none>
hpa-demo-6949d84d5b-gc47x   1/1     Running   0          9s     10.244.0.68   devops-course   <none>           <none>
hpa-demo-6949d84d5b-gq8gs   1/1     Running   0          2m9s   10.244.0.66   devops-course   <none>           <none>
hpa-demo-6949d84d5b-htw9k   1/1     Running   0          9s     10.244.0.70   devops-course   <none>           <none>
load-generator              1/1     Running   0          2m7s   10.244.0.67   devops-course   <none>           <none>
+ kubectl -n a12 delete pod load-generator
pod "load-generator" deleted from a12 namespace
+ kubectl apply -f mini-project/namespace.yaml -f mini-project/pvc.yaml -f mini-project/deployment.yaml -f mini-project/service.yaml -f mini-project/hpa.yaml
namespace/production-webapp created
persistentvolumeclaim/web-data created
deployment.apps/web-app created
service/web-service created
horizontalpodautoscaler.autoscaling/web-app-hpa created
+ kubectl -n production-webapp rollout status deployment/web-app --timeout=180s
Waiting for deployment "web-app" rollout to finish: 0 of 2 updated replicas are available...
Waiting for deployment "web-app" rollout to finish: 1 of 2 updated replicas are available...
deployment "web-app" successfully rolled out
+ kubectl -n production-webapp get pvc,hpa,pods
NAME                             STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
persistentvolumeclaim/web-data   Bound    pvc-ba3314b3-363c-48d5-8e00-9d0c15eaab6d   500Mi      RWO            standard       <unset>                 10s

NAME                                              REFERENCE            TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
horizontalpodautoscaler.autoscaling/web-app-hpa   Deployment/web-app   cpu: <unknown>/50%   2         5         0          10s

NAME                          READY   STATUS    RESTARTS   AGE
pod/web-app-97976c695-9wk2p   1/1     Running   0          10s
pod/web-app-97976c695-wdmxr   1/1     Running   0          10s
++ kubectl -n production-webapp get pods -l app=web-app -o 'jsonpath={.items[0].metadata.name}'
+ pod=web-app-97976c695-9wk2p
+ kubectl -n production-webapp exec web-app-97976c695-9wk2p -- sh -c 'echo "DevOps practical persistence check" >/data/student.txt'
+ kubectl -n production-webapp exec web-app-97976c695-9wk2p -- cat /data/student.txt
DevOps practical persistence check
+ kubectl -n production-webapp delete pod web-app-97976c695-9wk2p
pod "web-app-97976c695-9wk2p" deleted from production-webapp namespace
+ kubectl -n production-webapp rollout status deployment/web-app --timeout=180s
Waiting for deployment "web-app" rollout to finish: 1 of 2 updated replicas are available...
deployment "web-app" successfully rolled out
+ kubectl -n production-webapp exec deployment/web-app -- cat /data/student.txt
DevOps practical persistence check
+ kubectl -n production-webapp exec deployment/web-app -- curl -fsS localhost
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
+ kubectl -n production-webapp run load-generator --image=busybox:1.36 --restart=Never --command -- sh -c 'for i in 1 2 3 4 5 6 7 8 9 10 11 12; do (while true; do wget -qO- http://web-service >/dev/null; done) & done; wait'
pod/load-generator created
+ for attempt in {1..36}
+ kubectl -n production-webapp get hpa
NAME          REFERENCE            TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
web-app-hpa   Deployment/web-app   cpu: <unknown>/50%   2         5         2          22s
+ kubectl -n production-webapp top pods
error: metrics not available yet
+ true
++ kubectl -n production-webapp get deploy web-app -o 'jsonpath={.spec.replicas}'
+ replicas=2
+ (( replicas > 2 ))
+ sleep 10
+ for attempt in {1..36}
+ kubectl -n production-webapp get hpa
NAME          REFERENCE            TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
web-app-hpa   Deployment/web-app   cpu: <unknown>/50%   2         5         2          33s
+ kubectl -n production-webapp top pods
error: metrics not available yet
+ true
++ kubectl -n production-webapp get deploy web-app -o 'jsonpath={.spec.replicas}'
+ replicas=2
+ (( replicas > 2 ))
+ sleep 10
+ for attempt in {1..36}
+ kubectl -n production-webapp get hpa
NAME          REFERENCE            TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
web-app-hpa   Deployment/web-app   cpu: <unknown>/50%   2         5         2          45s
+ kubectl -n production-webapp top pods
error: metrics not available yet
+ true
++ kubectl -n production-webapp get deploy web-app -o 'jsonpath={.spec.replicas}'
+ replicas=2
+ (( replicas > 2 ))
+ sleep 10
+ for attempt in {1..36}
+ kubectl -n production-webapp get hpa
NAME          REFERENCE            TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
web-app-hpa   Deployment/web-app   cpu: <unknown>/50%   2         5         2          56s
+ kubectl -n production-webapp top pods
error: metrics not available yet
+ true
++ kubectl -n production-webapp get deploy web-app -o 'jsonpath={.spec.replicas}'
+ replicas=2
+ (( replicas > 2 ))
+ sleep 10
+ for attempt in {1..36}
+ kubectl -n production-webapp get hpa
NAME          REFERENCE            TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
web-app-hpa   Deployment/web-app   cpu: <unknown>/50%   2         5         2          67s
+ kubectl -n production-webapp top pods
NAME                      CPU(cores)   MEMORY(bytes)   
load-generator            2556m        7Mi             
web-app-97976c695-2h8fk   91m          4Mi             
web-app-97976c695-wdmxr   83m          4Mi             
++ kubectl -n production-webapp get deploy web-app -o 'jsonpath={.spec.replicas}'
+ replicas=2
+ (( replicas > 2 ))
+ sleep 10
+ for attempt in {1..36}
+ kubectl -n production-webapp get hpa
NAME          REFERENCE            TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
web-app-hpa   Deployment/web-app   cpu: <unknown>/50%   2         5         2          79s
+ kubectl -n production-webapp top pods
NAME                      CPU(cores)   MEMORY(bytes)   
load-generator            2556m        7Mi             
web-app-97976c695-2h8fk   91m          4Mi             
web-app-97976c695-wdmxr   83m          4Mi             
++ kubectl -n production-webapp get deploy web-app -o 'jsonpath={.spec.replicas}'
+ replicas=2
+ (( replicas > 2 ))
+ sleep 10
+ for attempt in {1..36}
+ kubectl -n production-webapp get hpa
NAME          REFERENCE            TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
web-app-hpa   Deployment/web-app   cpu: <unknown>/50%   2         5         2          90s
+ kubectl -n production-webapp top pods
NAME                      CPU(cores)   MEMORY(bytes)   
load-generator            2556m        7Mi             
web-app-97976c695-2h8fk   91m          4Mi             
web-app-97976c695-wdmxr   83m          4Mi             
++ kubectl -n production-webapp get deploy web-app -o 'jsonpath={.spec.replicas}'
+ replicas=2
+ (( replicas > 2 ))
+ sleep 10
+ for attempt in {1..36}
+ kubectl -n production-webapp get hpa
NAME          REFERENCE            TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
web-app-hpa   Deployment/web-app   cpu: <unknown>/50%   2         5         2          101s
+ kubectl -n production-webapp top pods
NAME                      CPU(cores)   MEMORY(bytes)   
load-generator            2556m        7Mi             
web-app-97976c695-2h8fk   91m          4Mi             
web-app-97976c695-wdmxr   83m          4Mi             
++ kubectl -n production-webapp get deploy web-app -o 'jsonpath={.spec.replicas}'
+ replicas=2
+ (( replicas > 2 ))
+ sleep 10
+ for attempt in {1..36}
+ kubectl -n production-webapp get hpa
NAME          REFERENCE            TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
web-app-hpa   Deployment/web-app   cpu: <unknown>/50%   2         5         2          113s
+ kubectl -n production-webapp top pods
NAME                      CPU(cores)   MEMORY(bytes)   
load-generator            2556m        7Mi             
web-app-97976c695-2h8fk   91m          4Mi             
web-app-97976c695-wdmxr   83m          4Mi             
++ kubectl -n production-webapp get deploy web-app -o 'jsonpath={.spec.replicas}'
+ replicas=2
+ (( replicas > 2 ))
+ sleep 10
+ for attempt in {1..36}
+ kubectl -n production-webapp get hpa
NAME          REFERENCE            TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
web-app-hpa   Deployment/web-app   cpu: <unknown>/50%   2         5         2          2m4s
+ kubectl -n production-webapp top pods
NAME                      CPU(cores)   MEMORY(bytes)   
load-generator            2556m        7Mi             
web-app-97976c695-2h8fk   91m          4Mi             
web-app-97976c695-wdmxr   83m          4Mi             
++ kubectl -n production-webapp get deploy web-app -o 'jsonpath={.spec.replicas}'
+ replicas=2
+ (( replicas > 2 ))
+ sleep 10
+ for attempt in {1..36}
+ kubectl -n production-webapp get hpa
NAME          REFERENCE            TARGETS         MINPODS   MAXPODS   REPLICAS   AGE
web-app-hpa   Deployment/web-app   cpu: 110%/50%   2         5         2          2m16s
+ kubectl -n production-webapp top pods
NAME                      CPU(cores)   MEMORY(bytes)   
load-generator            2546m        8Mi             
web-app-97976c695-2h8fk   111m         4Mi             
web-app-97976c695-wdmxr   110m         4Mi             
++ kubectl -n production-webapp get deploy web-app -o 'jsonpath={.spec.replicas}'
+ replicas=4
+ (( replicas > 2 ))
+ break
+ test 4 -gt 2
+ kubectl -n production-webapp describe hpa web-app-hpa
Name:                                                  web-app-hpa
Namespace:                                             production-webapp
Labels:                                                <none>
Annotations:                                           <none>
CreationTimestamp:                                     Wed, 07 Oct 2026 08:22:16 +0000
Reference:                                             Deployment/web-app
Metrics:                                               ( current / target )
  resource cpu on pods  (as a percentage of request):  110% (110m) / 50%
Min replicas:                                          2
Max replicas:                                          5
Deployment pods:                                       2 current / 4 desired
Conditions:
  Type            Status  Reason            Message
  ----            ------  ------            -------
  AbleToScale     True    SucceededRescale  the HPA controller was able to update the target scale to 4
  ScalingActive   True    ValidMetricFound  the HPA was able to successfully calculate a replica count from cpu resource utilization (percentage of request)
  ScalingLimited  True    ScaleUpLimit      the desired replica count is increasing faster than the maximum scale rate
Events:
  Type     Reason                        Age                 From                       Message
  ----     ------                        ----                ----                       -------
  Warning  FailedGetResourceMetric       77s (x4 over 2m2s)  horizontal-pod-autoscaler  failed to get cpu utilization: unable to get metrics for resource cpu: no metrics returned from resource metrics API
  Warning  FailedComputeMetricsReplicas  77s (x4 over 2m2s)  horizontal-pod-autoscaler  invalid metrics (1 invalid out of 1), first error is: failed to get cpu resource metric value: failed to get cpu utilization: unable to get metrics for resource cpu: no metrics returned from resource metrics API
  Warning  FailedGetResourceMetric       17s (x4 over 62s)   horizontal-pod-autoscaler  failed to get cpu utilization: did not receive metrics for targeted pods (pods might be unready)
  Warning  FailedComputeMetricsReplicas  17s (x4 over 62s)   horizontal-pod-autoscaler  invalid metrics (1 invalid out of 1), first error is: failed to get cpu resource metric value: failed to get cpu utilization: did not receive metrics for targeted pods (pods might be unready)
  Normal   SuccessfulRescale             2s                  horizontal-pod-autoscaler  New size: 4; reason: cpu resource utilization (percentage of request) above target
+ kubectl -n production-webapp delete pod load-generator
pod "load-generator" deleted from production-webapp namespace
+ kubectl -n production-webapp get deployment web-app -o 'jsonpath={.spec.template.spec.containers[0].startupProbe}{"\n"}{.spec.template.spec.containers[0].readinessProbe}{"\n"}{.spec.template.spec.containers[0].livenessProbe}{"\n"}'
{"failureThreshold":30,"httpGet":{"path":"/","port":80,"scheme":"HTTP"},"periodSeconds":2,"successThreshold":1,"timeoutSeconds":1}
{"failureThreshold":2,"httpGet":{"path":"/","port":80,"scheme":"HTTP"},"initialDelaySeconds":5,"periodSeconds":5,"successThreshold":1,"timeoutSeconds":2}
{"failureThreshold":3,"httpGet":{"path":"/","port":80,"scheme":"HTTP"},"initialDelaySeconds":5,"periodSeconds":5,"successThreshold":1,"timeoutSeconds":2}
+ kubectl delete namespace a12 production-webapp
namespace "a12" deleted
namespace "production-webapp" deleted

```
