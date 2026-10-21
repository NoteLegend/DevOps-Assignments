# Executed commands and captured output

```bash
#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
kubectl create namespace a13
kubectl -n a13 apply -f cases -f mini-project
sleep 45
kubectl -n a13 get pods -o wide
kubectl -n a13 events
for name in crashloop image-error pending container-creating config-error project-broken-pod; do kubectl -n a13 describe pod "$name" > "evidence/before-$name.txt"; cat "evidence/before-$name.txt"; done
kubectl -n a13 exec deployment/troubleshooting-app -- sh -c 'curl -fsS localhost'
kubectl -n a13 logs crashloop --previous || kubectl -n a13 logs crashloop
kubectl explain pod.spec.containers
kubectl -n a13 top pods || true
# Fix each diagnosed root cause.
kubectl -n a13 delete pod crashloop pending
kubectl -n a13 run crashloop --image=busybox:1.36 --restart=Never --command -- sleep 3600
kubectl -n a13 run pending --image=busybox:1.36 --restart=Never --command -- sleep 3600
kubectl -n a13 set image pod/image-error app=nginx:1.27
kubectl -n a13 set image pod/project-broken-pod app=nginx:1.27
kubectl -n a13 create secret generic missing-runtime-secret --from-file=demo=/workspace/.local-tools/runtime/secret-good
kubectl -n a13 create configmap missing-config --from-literal=MODE=local
kubectl -n a13 wait --for=condition=Ready pods --all --timeout=180s
kubectl -n a13 patch svc troubleshooting-service -p '{"spec":{"selector":{"app":"wrong-app"}}}'
kubectl -n a13 get pods --show-labels
kubectl -n a13 describe svc troubleshooting-service
kubectl -n a13 get endpointslices
kubectl -n a13 get endpoints troubleshooting-service
kubectl -n a13 patch svc troubleshooting-service -p '{"spec":{"selector":{"app":"troubleshooting-app"}}}'
kubectl -n a13 run client --image=busybox:1.36 --restart=Never --command -- sleep 1800
kubectl -n a13 wait --for=condition=Ready pod/client --timeout=120s
if kubectl -n a13 exec client -- nslookup nonexistent.a13.svc.cluster.local; then exit 1; else echo 'BEFORE DNS: nonexistent service name fails (expected)'; fi
kubectl -n a13 exec client -- nslookup troubleshooting-service.a13.svc.cluster.local
pod_ip=$(kubectl -n a13 get pods -l app=troubleshooting-app -o jsonpath='{.items[0].status.podIP}')
if kubectl -n a13 exec client -- wget -T 3 -qO- "http://$pod_ip:8088"; then exit 1; else echo 'BEFORE Pod networking: incorrect target port refused (expected)'; fi
kubectl -n a13 exec client -- wget -qO- "http://$pod_ip:80"
kubectl -n a13 exec client -- wget -qO- http://troubleshooting-service
kubectl -n a13 get pods -o wide
kubectl -n a13 get endpointslices
kubectl -n a13 get endpoints troubleshooting-service
for name in crashloop image-error pending container-creating config-error project-broken-pod; do kubectl -n a13 describe pod "$name" > "evidence/after-$name.txt"; done
kubectl -n a13 top pods
kubectl delete namespace a13

```

```text
Executed 2026-10-07T14:09:19.648185+05:30
Working directory: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-13-Session-14
Script: verify.sh
Exit status: 0

+ source ../../.local-tools/env.sh
++ _devops_trace=0
++ case $- in
++ _devops_trace=1
++ set +x
++ unset _devops_trace
+ kubectl create namespace a13
namespace/a13 created
+ kubectl -n a13 apply -f cases -f mini-project
pod/config-error created
pod/container-creating created
pod/crashloop created
pod/image-error created
pod/pending created
pod/project-broken-pod created
deployment.apps/troubleshooting-app created
service/troubleshooting-service created
+ sleep 45
+ kubectl -n a13 get pods -o wide
NAME                                   READY   STATUS                       RESTARTS      AGE   IP            NODE            NOMINATED NODE   READINESS GATES
config-error                           0/1     CreateContainerConfigError   0             46s   10.244.0.88   devops-course   <none>           <none>
container-creating                     0/1     ContainerCreating            0             46s   <none>        devops-course   <none>           <none>
crashloop                              0/1     Error                        3 (30s ago)   46s   10.244.0.89   devops-course   <none>           <none>
image-error                            0/1     ErrImagePull                 0             46s   10.244.0.91   devops-course   <none>           <none>
pending                                0/1     Pending                      0             46s   <none>        <none>          <none>           <none>
project-broken-pod                     0/1     ImagePullBackOff             0             46s   10.244.0.90   devops-course   <none>           <none>
troubleshooting-app-5b97965b56-74jhg   1/1     Running                      0             46s   10.244.0.92   devops-course   <none>           <none>
troubleshooting-app-5b97965b56-8ln9v   1/1     Running                      0             45s   10.244.0.93   devops-course   <none>           <none>
+ kubectl -n a13 events
LAST SEEN           TYPE      REASON              OBJECT                                      MESSAGE
46s                 Warning   FailedScheduling    Pod/pending                                 0/1 nodes are available: 1 node(s) didn't match Pod's node affinity/selector. no new claims to deallocate, preemption: 0/1 nodes are available: 1 Preemption is not helpful for scheduling.
46s                 Normal    ScalingReplicaSet   Deployment/troubleshooting-app              Scaled up replica set troubleshooting-app-5b97965b56 from 0 to 2
46s                 Normal    Scheduled           Pod/container-creating                      Successfully assigned a13/container-creating to devops-course
46s                 Normal    Scheduled           Pod/crashloop                               Successfully assigned a13/crashloop to devops-course
46s                 Normal    Scheduled           Pod/config-error                            Successfully assigned a13/config-error to devops-course
46s                 Normal    Scheduled           Pod/project-broken-pod                      Successfully assigned a13/project-broken-pod to devops-course
46s                 Normal    Scheduled           Pod/image-error                             Successfully assigned a13/image-error to devops-course
45s                 Normal    SuccessfulCreate    ReplicaSet/troubleshooting-app-5b97965b56   Created pod: troubleshooting-app-5b97965b56-8ln9v
45s                 Normal    SuccessfulCreate    ReplicaSet/troubleshooting-app-5b97965b56   Created pod: troubleshooting-app-5b97965b56-74jhg
45s                 Normal    Scheduled           Pod/troubleshooting-app-5b97965b56-8ln9v    Successfully assigned a13/troubleshooting-app-5b97965b56-8ln9v to devops-course
45s                 Normal    Scheduled           Pod/troubleshooting-app-5b97965b56-74jhg    Successfully assigned a13/troubleshooting-app-5b97965b56-74jhg to devops-course
44s                 Normal    Pulled              Pod/troubleshooting-app-5b97965b56-74jhg    Container image "nginx:1.27" already present on machine and can be accessed by the pod
44s                 Normal    Pulled              Pod/troubleshooting-app-5b97965b56-8ln9v    Container image "nginx:1.27" already present on machine and can be accessed by the pod
43s                 Normal    Started             Pod/troubleshooting-app-5b97965b56-8ln9v    Container started
43s                 Normal    Started             Pod/troubleshooting-app-5b97965b56-74jhg    Container started
43s                 Normal    Created             Pod/troubleshooting-app-5b97965b56-74jhg    Container created
43s                 Normal    Created             Pod/troubleshooting-app-5b97965b56-8ln9v    Container created
24s (x2 over 44s)   Normal    Pulling             Pod/image-error                             Pulling image "nginx:this-tag-does-not-exist"
24s (x2 over 42s)   Warning   Failed              Pod/project-broken-pod                      Failed to pull image "nginx:this-tag-does-not-exist": rpc error: code = NotFound desc = failed to pull and unpack image "docker.io/library/nginx:this-tag-does-not-exist": failed to resolve reference "docker.io/library/nginx:this-tag-does-not-exist": docker.io/library/nginx:this-tag-does-not-exist: not found
24s (x2 over 42s)   Warning   Failed              Pod/project-broken-pod                      Error: ErrImagePull
22s (x2 over 40s)   Warning   Failed              Pod/image-error                             Failed to pull image "nginx:this-tag-does-not-exist": rpc error: code = NotFound desc = failed to pull and unpack image "docker.io/library/nginx:this-tag-does-not-exist": failed to resolve reference "docker.io/library/nginx:this-tag-does-not-exist": docker.io/library/nginx:this-tag-does-not-exist: not found
22s (x2 over 40s)   Warning   Failed              Pod/image-error                             Error: ErrImagePull
14s (x7 over 46s)   Warning   FailedMount         Pod/container-creating                      MountVolume.SetUp failed for volume "missing" : secret "missing-runtime-secret" not found
13s (x2 over 42s)   Normal    BackOff             Pod/project-broken-pod                      Back-off pulling image "nginx:this-tag-does-not-exist"
13s (x2 over 42s)   Warning   Failed              Pod/project-broken-pod                      Error: ImagePullBackOff
8s (x2 over 40s)    Warning   Failed              Pod/image-error                             Error: ImagePullBackOff
8s (x2 over 40s)    Normal    BackOff             Pod/image-error                             Back-off pulling image "nginx:this-tag-does-not-exist"
6s (x5 over 45s)    Warning   Failed              Pod/config-error                            Error: configmap "missing-config" not found
6s (x5 over 45s)    Normal    Pulled              Pod/config-error                            Container image "busybox:1.36" already present on machine and can be accessed by the pod
1s (x4 over 45s)    Normal    Pulled              Pod/crashloop                               Container image "busybox:1.36" already present on machine and can be accessed by the pod
1s (x4 over 44s)    Normal    Created             Pod/crashloop                               Container created
1s (x4 over 44s)    Normal    Started             Pod/crashloop                               Container started
1s (x3 over 44s)    Normal    Pulling             Pod/project-broken-pod                      Pulling image "nginx:this-tag-does-not-exist"
0s (x3 over 42s)    Warning   BackOff             Pod/crashloop                               Back-off restarting failed container app in pod crashloop_a13(a27e23a4-92f5-4386-ac9e-966b64e86f08)
+ for name in crashloop image-error pending container-creating config-error project-broken-pod
+ kubectl -n a13 describe pod crashloop
+ cat evidence/before-crashloop.txt
Name:             crashloop
Namespace:        a13
Priority:         0
Service Account:  default
Node:             devops-course/192.168.49.2
Start Time:       Wed, 07 Oct 2026 08:37:18 +0000
Labels:           <none>
Annotations:      <none>
Status:           Running
IP:               10.244.0.89
IPs:
  IP:  10.244.0.89
Containers:
  app:
    Container ID:  containerd://7771080387f85b493651fccfd559075ed31c30d4a0789e44ba9ecb867b169a99
    Image:         busybox:1.36
    Image ID:      sha256:b116e155074440ffd9e449559433feb4cd2341eb3554b1da1c638c976e56451d
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      echo deliberate-crash; exit 1
    State:          Terminated
      Reason:       Error
      Exit Code:    1
      Started:      Wed, 07 Oct 2026 08:38:03 +0000
      Finished:     Wed, 07 Oct 2026 08:38:03 +0000
    Last State:     Terminated
      Reason:       Error
      Exit Code:    1
      Started:      Wed, 07 Oct 2026 08:37:34 +0000
      Finished:     Wed, 07 Oct 2026 08:37:34 +0000
    Ready:          False
    Restart Count:  3
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-6qpgs (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       False 
  ContainersReady             False 
  PodScheduled                True 
Volumes:
  kube-api-access-6qpgs:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    Optional:                false
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason     Age               From               Message
  ----     ------     ----              ----               -------
  Normal   Scheduled  47s               default-scheduler  Successfully assigned a13/crashloop to devops-course
  Normal   Pulled     2s (x4 over 46s)  kubelet            spec.containers{app}: Container image "busybox:1.36" already present on machine and can be accessed by the pod
  Normal   Created    2s (x4 over 45s)  kubelet            spec.containers{app}: Container created
  Normal   Started    2s (x4 over 45s)  kubelet            spec.containers{app}: Container started
  Warning  BackOff    1s (x3 over 43s)  kubelet            spec.containers{app}: Back-off restarting failed container app in pod crashloop_a13(a27e23a4-92f5-4386-ac9e-966b64e86f08)
+ for name in crashloop image-error pending container-creating config-error project-broken-pod
+ kubectl -n a13 describe pod image-error
+ cat evidence/before-image-error.txt
Name:             image-error
Namespace:        a13
Priority:         0
Service Account:  default
Node:             devops-course/192.168.49.2
Start Time:       Wed, 07 Oct 2026 08:37:18 +0000
Labels:           <none>
Annotations:      <none>
Status:           Pending
IP:               10.244.0.91
IPs:
  IP:  10.244.0.91
Containers:
  app:
    Container ID:  
    Image:         nginx:this-tag-does-not-exist
    Image ID:      
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      sleep 3600
    State:          Waiting
      Reason:       ErrImagePull
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-jg94d (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       False 
  ContainersReady             False 
  PodScheduled                True 
Volumes:
  kube-api-access-jg94d:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    Optional:                false
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason     Age                From               Message
  ----     ------     ----               ----               -------
  Normal   Scheduled  47s                default-scheduler  Successfully assigned a13/image-error to devops-course
  Normal   Pulling    25s (x2 over 45s)  kubelet            spec.containers{app}: Pulling image "nginx:this-tag-does-not-exist"
  Warning  Failed     23s (x2 over 41s)  kubelet            spec.containers{app}: Failed to pull image "nginx:this-tag-does-not-exist": rpc error: code = NotFound desc = failed to pull and unpack image "docker.io/library/nginx:this-tag-does-not-exist": failed to resolve reference "docker.io/library/nginx:this-tag-does-not-exist": docker.io/library/nginx:this-tag-does-not-exist: not found
  Warning  Failed     23s (x2 over 41s)  kubelet            spec.containers{app}: Error: ErrImagePull
  Normal   BackOff    9s (x2 over 41s)   kubelet            spec.containers{app}: Back-off pulling image "nginx:this-tag-does-not-exist"
  Warning  Failed     9s (x2 over 41s)   kubelet            spec.containers{app}: Error: ImagePullBackOff
+ for name in crashloop image-error pending container-creating config-error project-broken-pod
+ kubectl -n a13 describe pod pending
+ cat evidence/before-pending.txt
Name:             pending
Namespace:        a13
Priority:         0
Service Account:  default
Node:             <none>
Labels:           <none>
Annotations:      <none>
Status:           Pending
IP:               
IPs:              <none>
Containers:
  app:
    Image:      busybox:1.36
    Port:       <none>
    Host Port:  <none>
    Command:
      sh
      -c
      sleep 3600
    Environment:  <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-gmpf4 (ro)
Conditions:
  Type           Status
  PodScheduled   False 
Volumes:
  kube-api-access-gmpf4:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    Optional:                false
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              assignment-node=nonexistent
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason            Age   From               Message
  ----     ------            ----  ----               -------
  Warning  FailedScheduling  47s   default-scheduler  0/1 nodes are available: 1 node(s) didn't match Pod's node affinity/selector. no new claims to deallocate, preemption: 0/1 nodes are available: 1 Preemption is not helpful for scheduling.
+ for name in crashloop image-error pending container-creating config-error project-broken-pod
+ kubectl -n a13 describe pod container-creating
+ cat evidence/before-container-creating.txt
Name:             container-creating
Namespace:        a13
Priority:         0
Service Account:  default
Node:             devops-course/192.168.49.2
Start Time:       Wed, 07 Oct 2026 08:37:18 +0000
Labels:           <none>
Annotations:      <none>
Status:           Pending
IP:               
IPs:              <none>
Containers:
  app:
    Container ID:  
    Image:         busybox:1.36
    Image ID:      
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      sleep 3600
    State:          Waiting
      Reason:       ContainerCreating
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /secret from missing (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-8bmzb (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   False 
  Initialized                 True 
  Ready                       False 
  ContainersReady             False 
  PodScheduled                True 
Volumes:
  missing:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  missing-runtime-secret
    Optional:    false
  kube-api-access-8bmzb:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    Optional:                false
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason       Age                From               Message
  ----     ------       ----               ----               -------
  Normal   Scheduled    48s                default-scheduler  Successfully assigned a13/container-creating to devops-course
  Warning  FailedMount  16s (x7 over 48s)  kubelet            MountVolume.SetUp failed for volume "missing" : secret "missing-runtime-secret" not found
+ for name in crashloop image-error pending container-creating config-error project-broken-pod
+ kubectl -n a13 describe pod config-error
+ cat evidence/before-config-error.txt
Name:             config-error
Namespace:        a13
Priority:         0
Service Account:  default
Node:             devops-course/192.168.49.2
Start Time:       Wed, 07 Oct 2026 08:37:18 +0000
Labels:           <none>
Annotations:      <none>
Status:           Pending
IP:               10.244.0.88
IPs:
  IP:  10.244.0.88
Containers:
  app:
    Container ID:  
    Image:         busybox:1.36
    Image ID:      
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      sleep 3600
    State:          Waiting
      Reason:       CreateContainerConfigError
    Ready:          False
    Restart Count:  0
    Environment:
      APP_MODE:  <set to the key 'MODE' of config map 'missing-config'>  Optional: false
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-wz7xt (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       False 
  ContainersReady             False 
  PodScheduled                True 
Volumes:
  kube-api-access-wz7xt:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    Optional:                false
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason     Age               From               Message
  ----     ------     ----              ----               -------
  Normal   Scheduled  48s               default-scheduler  Successfully assigned a13/config-error to devops-course
  Normal   Pulled     8s (x5 over 47s)  kubelet            spec.containers{app}: Container image "busybox:1.36" already present on machine and can be accessed by the pod
  Warning  Failed     8s (x5 over 47s)  kubelet            spec.containers{app}: Error: configmap "missing-config" not found
+ for name in crashloop image-error pending container-creating config-error project-broken-pod
+ kubectl -n a13 describe pod project-broken-pod
+ cat evidence/before-project-broken-pod.txt
Name:             project-broken-pod
Namespace:        a13
Priority:         0
Service Account:  default
Node:             devops-course/192.168.49.2
Start Time:       Wed, 07 Oct 2026 08:37:18 +0000
Labels:           <none>
Annotations:      <none>
Status:           Pending
IP:               10.244.0.90
IPs:
  IP:  10.244.0.90
Containers:
  app:
    Container ID:   
    Image:          nginx:this-tag-does-not-exist
    Image ID:       
    Port:           <none>
    Host Port:      <none>
    State:          Waiting
      Reason:       ImagePullBackOff
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-gsx2c (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       False 
  ContainersReady             False 
  PodScheduled                True 
Volumes:
  kube-api-access-gsx2c:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    Optional:                false
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason     Age                From               Message
  ----     ------     ----               ----               -------
  Normal   Scheduled  48s                default-scheduler  Successfully assigned a13/project-broken-pod to devops-course
  Normal   BackOff    15s (x2 over 44s)  kubelet            spec.containers{app}: Back-off pulling image "nginx:this-tag-does-not-exist"
  Warning  Failed     15s (x2 over 44s)  kubelet            spec.containers{app}: Error: ImagePullBackOff
  Normal   Pulling    3s (x3 over 46s)   kubelet            spec.containers{app}: Pulling image "nginx:this-tag-does-not-exist"
  Warning  Failed     1s (x3 over 44s)   kubelet            spec.containers{app}: Failed to pull image "nginx:this-tag-does-not-exist": rpc error: code = NotFound desc = failed to pull and unpack image "docker.io/library/nginx:this-tag-does-not-exist": failed to resolve reference "docker.io/library/nginx:this-tag-does-not-exist": docker.io/library/nginx:this-tag-does-not-exist: not found
  Warning  Failed     1s (x3 over 44s)   kubelet            spec.containers{app}: Error: ErrImagePull
+ kubectl -n a13 exec deployment/troubleshooting-app -- sh -c 'curl -fsS localhost'
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
+ kubectl -n a13 logs crashloop --previous
unable to retrieve container logs for containerd://becfed97f98b9f7118c4a189877de888f705d028c059d4b0df5a58814bd8cb6c+ kubectl explain pod.spec.containers
KIND:       Pod
VERSION:    v1

FIELD: containers <[]Container>


DESCRIPTION:
    List of containers belonging to the pod. Containers cannot currently be
    added or removed. There must be at least one container in a Pod. Cannot be
    updated.
    A single application container that you want to run within a pod.
    
FIELDS:
  args	<[]string>
    Arguments to the entrypoint. The container image's CMD is used if this is
    not provided. Variable references $(VAR_NAME) are expanded using the
    container's environment. If a variable cannot be resolved, the reference in
    the input string will be unchanged. Double $$ are reduced to a single $,
    which allows for escaping the $(VAR_NAME) syntax: i.e. "$$(VAR_NAME)" will
    produce the string literal "$(VAR_NAME)". Escaped references will never be
    expanded, regardless of whether the variable exists or not. Cannot be
    updated. More info:
    https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell

  command	<[]string>
    Entrypoint array. Not executed within a shell. The container image's
    ENTRYPOINT is used if this is not provided. Variable references $(VAR_NAME)
    are expanded using the container's environment. If a variable cannot be
    resolved, the reference in the input string will be unchanged. Double $$ are
    reduced to a single $, which allows for escaping the $(VAR_NAME) syntax:
    i.e. "$$(VAR_NAME)" will produce the string literal "$(VAR_NAME)". Escaped
    references will never be expanded, regardless of whether the variable exists
    or not. Cannot be updated. More info:
    https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell

  env	<[]EnvVar>
    List of environment variables to set in the container. Cannot be updated.

  envFrom	<[]EnvFromSource>
    List of sources to populate environment variables in the container. The keys
    defined within a source may consist of any printable ASCII characters except
    '='. When a key exists in multiple sources, the value associated with the
    last source will take precedence. Values defined by an Env with a duplicate
    key will take precedence. Cannot be updated.

  image	<string>
    Container image name. More info:
    https://kubernetes.io/docs/concepts/containers/images This field is optional
    to allow higher level config management to default or override container
    images in workload controllers like Deployments and StatefulSets.

  imagePullPolicy	<string>
  enum: Always, IfNotPresent, Never
    Image pull policy. One of Always, Never, IfNotPresent. Defaults to Always if
    :latest tag is specified, or IfNotPresent otherwise. Cannot be updated. More
    info: https://kubernetes.io/docs/concepts/containers/images#updating-images
    
    Possible enum values:
     - `"Always"` means that kubelet always attempts to pull the latest image.
    Container will fail If the pull fails.
     - `"IfNotPresent"` means that kubelet pulls if the image isn't present on
    disk. Container will fail if the image isn't present and the pull fails.
     - `"Never"` means that kubelet never pulls an image, but only uses a local
    image. Container will fail if the image isn't present

  lifecycle	<Lifecycle>
    Actions that the management system should take in response to container
    lifecycle events. Cannot be updated.

  livenessProbe	<Probe>
    Periodic probe of container liveness. Container will be restarted if the
    probe fails. Cannot be updated. More info:
    https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes

  name	<string> -required-
    Name of the container specified as a DNS_LABEL. Each container in a pod must
    have a unique name (DNS_LABEL). Cannot be updated.

  ports	<[]ContainerPort>
    List of ports to expose from the container. Not specifying a port here DOES
    NOT prevent that port from being exposed. Any port which is listening on the
    default "0.0.0.0" address inside a container will be accessible from the
    network. Modifying this array with strategic merge patch may corrupt the
    data. For more information See
    https://github.com/kubernetes/kubernetes/issues/108255. Cannot be updated.

  readinessProbe	<Probe>
    Periodic probe of container service readiness. Container will be removed
    from service endpoints if the probe fails. Cannot be updated. More info:
    https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes

  resizePolicy	<[]ContainerResizePolicy>
    Resources resize policy for the container. This field cannot be set on
    ephemeral containers.

  resources	<ResourceRequirements>
    Compute Resources required by this container. Cannot be updated. More info:
    https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/

  restartPolicy	<string>
    RestartPolicy defines the restart behavior of individual containers in a
    pod. This overrides the pod-level restart policy. When this field is not
    specified, the restart behavior is defined by the Pod's restart policy and
    the container type. Additionally, setting the RestartPolicy as "Always" for
    the init container will have the following effect: this init container will
    be continually restarted on exit until all regular containers have
    terminated. Once all regular containers have completed, all init containers
    with restartPolicy "Always" will be shut down. This lifecycle differs from
    normal init containers and is often referred to as a "sidecar" container.
    Although this init container still starts in the init container sequence, it
    does not wait for the container to complete before proceeding to the next
    init container. Instead, the next init container starts immediately after
    this init container is started, or after any startupProbe has successfully
    completed.

  restartPolicyRules	<[]ContainerRestartRule>
    Represents a list of rules to be checked to determine if the container
    should be restarted on exit. The rules are evaluated in order. Once a rule
    matches a container exit condition, the remaining rules are ignored. If no
    rule matches the container exit condition, the Container-level restart
    policy determines the whether the container is restarted or not. Constraints
    on the rules: - At most 20 rules are allowed. - Rules can have the same
    action. - Identical rules are not forbidden in validations. When rules are
    specified, container MUST set RestartPolicy explicitly even it if matches
    the Pod's RestartPolicy.

  securityContext	<SecurityContext>
    SecurityContext defines the security options the container should be run
    with. If set, the fields of SecurityContext override the equivalent fields
    of PodSecurityContext. More info:
    https://kubernetes.io/docs/tasks/configure-pod-container/security-context/

  startupProbe	<Probe>
    StartupProbe indicates that the Pod has successfully initialized. If
    specified, no other probes are executed until this completes successfully.
    If this probe fails, the Pod will be restarted, just as if the livenessProbe
    failed. This can be used to provide different probe parameters at the
    beginning of a Pod's lifecycle, when it might take a long time to load data
    or warm a cache, than during steady-state operation. This cannot be updated.
    More info:
    https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes

  stdin	<boolean>
    Whether this container should allocate a buffer for stdin in the container
    runtime. If this is not set, reads from stdin in the container will always
    result in EOF. Default is false.

  stdinOnce	<boolean>
    Whether the container runtime should close the stdin channel after it has
    been opened by a single attach. When stdin is true the stdin stream will
    remain open across multiple attach sessions. If stdinOnce is set to true,
    stdin is opened on container start, is empty until the first client attaches
    to stdin, and then remains open and accepts data until the client
    disconnects, at which time stdin is closed and remains closed until the
    container is restarted. If this flag is false, a container processes that
    reads from stdin will never receive an EOF. Default is false

  terminationMessagePath	<string>
    Optional: Path at which the file to which the container's termination
    message will be written is mounted into the container's filesystem. Message
    written is intended to be brief final status, such as an assertion failure
    message. Will be truncated by the node if greater than 4096 bytes. The total
    message length across all containers will be limited to 12kb. Defaults to
    /dev/termination-log. Cannot be updated.

  terminationMessagePolicy	<string>
  enum: FallbackToLogsOnError, File
    Indicate how the termination message should be populated. File will use the
    contents of terminationMessagePath to populate the container status message
    on both success and failure. FallbackToLogsOnError will use the last chunk
    of container log output if the termination message file is empty and the
    container exited with an error. The log output is limited to 2048 bytes or
    80 lines, whichever is smaller. Defaults to File. Cannot be updated.
    
    Possible enum values:
     - `"FallbackToLogsOnError"` will read the most recent contents of the
    container logs for the container status message when the container exits
    with an error and the terminationMessagePath has no contents.
     - `"File"` is the default behavior and will set the container status
    message to the contents of the container's terminationMessagePath when the
    container exits.

  tty	<boolean>
    Whether this container should allocate a TTY for itself, also requires
    'stdin' to be true. Default is false.

  volumeDevices	<[]VolumeDevice>
    volumeDevices is the list of block devices to be used by the container.

  volumeMounts	<[]VolumeMount>
    Pod volumes to mount into the container's filesystem. Cannot be updated.

  workingDir	<string>
    Container's working directory. If not specified, the container runtime's
    default will be used, which might be configured in the container image.
    Cannot be updated.


+ kubectl -n a13 top pods
error: metrics not available yet
+ true
+ kubectl -n a13 delete pod crashloop pending
pod "crashloop" deleted from a13 namespace
pod "pending" deleted from a13 namespace
+ kubectl -n a13 run crashloop --image=busybox:1.36 --restart=Never --command -- sleep 3600
pod/crashloop created
+ kubectl -n a13 run pending --image=busybox:1.36 --restart=Never --command -- sleep 3600
pod/pending created
+ kubectl -n a13 set image pod/image-error app=nginx:1.27
pod/image-error image updated
+ kubectl -n a13 set image pod/project-broken-pod app=nginx:1.27
pod/project-broken-pod image updated
+ kubectl -n a13 create secret generic missing-runtime-secret --from-file=demo=/workspace/.local-tools/runtime/secret-good
secret/missing-runtime-secret created
+ kubectl -n a13 create configmap missing-config --from-literal=MODE=local
configmap/missing-config created
+ kubectl -n a13 wait --for=condition=Ready pods --all --timeout=180s
pod/config-error condition met
pod/container-creating condition met
pod/crashloop condition met
pod/image-error condition met
pod/pending condition met
pod/project-broken-pod condition met
pod/troubleshooting-app-5b97965b56-74jhg condition met
pod/troubleshooting-app-5b97965b56-8ln9v condition met
+ kubectl -n a13 patch svc troubleshooting-service -p '{"spec":{"selector":{"app":"wrong-app"}}}'
service/troubleshooting-service patched
+ kubectl -n a13 get pods --show-labels
NAME                                   READY   STATUS    RESTARTS   AGE   LABELS
config-error                           1/1     Running   0          69s   <none>
container-creating                     1/1     Running   0          69s   <none>
crashloop                              1/1     Running   0          18s   run=crashloop
image-error                            1/1     Running   0          69s   <none>
pending                                1/1     Running   0          18s   run=pending
project-broken-pod                     1/1     Running   0          69s   <none>
troubleshooting-app-5b97965b56-74jhg   1/1     Running   0          69s   app=troubleshooting-app,pod-template-hash=5b97965b56
troubleshooting-app-5b97965b56-8ln9v   1/1     Running   0          68s   app=troubleshooting-app,pod-template-hash=5b97965b56
+ kubectl -n a13 describe svc troubleshooting-service
Name:                     troubleshooting-service
Namespace:                a13
Labels:                   <none>
Annotations:              <none>
Selector:                 app=wrong-app
Type:                     ClusterIP
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.104.181.47
IPs:                      10.104.181.47
Port:                     <unset>  80/TCP
TargetPort:               80/TCP
Endpoints:                
Session Affinity:         None
Internal Traffic Policy:  Cluster
Events:                   <none>
+ kubectl -n a13 get endpointslices
NAME                            ADDRESSTYPE   PORTS     ENDPOINTS   AGE
troubleshooting-service-7lqqk   IPv4          <unset>   <unset>     68s
+ kubectl -n a13 get endpoints troubleshooting-service
Warning: v1 Endpoints is deprecated in v1.33+; use discovery.k8s.io/v1 EndpointSlice
NAME                      ENDPOINTS   AGE
troubleshooting-service   <none>      69s
+ kubectl -n a13 patch svc troubleshooting-service -p '{"spec":{"selector":{"app":"troubleshooting-app"}}}'
service/troubleshooting-service patched
+ kubectl -n a13 run client --image=busybox:1.36 --restart=Never --command -- sleep 1800
pod/client created
+ kubectl -n a13 wait --for=condition=Ready pod/client --timeout=120s
pod/client condition met
+ kubectl -n a13 exec client -- nslookup nonexistent.a13.svc.cluster.local
Server:		10.96.0.10
Address:	10.96.0.10:53

** server can't find nonexistent.a13.svc.cluster.local: NXDOMAIN

** server can't find nonexistent.a13.svc.cluster.local: NXDOMAIN

command terminated with exit code 1
+ echo 'BEFORE DNS: nonexistent service name fails (expected)'
BEFORE DNS: nonexistent service name fails (expected)
+ kubectl -n a13 exec client -- nslookup troubleshooting-service.a13.svc.cluster.local
Server:		10.96.0.10
Address:	10.96.0.10:53

Name:	troubleshooting-service.a13.svc.cluster.local
Address: 10.104.181.47


++ kubectl -n a13 get pods -l app=troubleshooting-app -o 'jsonpath={.items[0].status.podIP}'
+ pod_ip=10.244.0.92
+ kubectl -n a13 exec client -- wget -T 3 -qO- http://10.244.0.92:8088
wget: can't connect to remote host (10.244.0.92): Connection refused
command terminated with exit code 1
+ echo 'BEFORE Pod networking: incorrect target port refused (expected)'
BEFORE Pod networking: incorrect target port refused (expected)
+ kubectl -n a13 exec client -- wget -qO- http://10.244.0.92:80
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
+ kubectl -n a13 exec client -- wget -qO- http://troubleshooting-service
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
+ kubectl -n a13 get pods -o wide
NAME                                   READY   STATUS    RESTARTS   AGE   IP            NODE            NOMINATED NODE   READINESS GATES
client                                 1/1     Running   0          4s    10.244.0.97   devops-course   <none>           <none>
config-error                           1/1     Running   0          74s   10.244.0.88   devops-course   <none>           <none>
container-creating                     1/1     Running   0          74s   10.244.0.96   devops-course   <none>           <none>
crashloop                              1/1     Running   0          23s   10.244.0.94   devops-course   <none>           <none>
image-error                            1/1     Running   0          74s   10.244.0.91   devops-course   <none>           <none>
pending                                1/1     Running   0          23s   10.244.0.95   devops-course   <none>           <none>
project-broken-pod                     1/1     Running   0          74s   10.244.0.90   devops-course   <none>           <none>
troubleshooting-app-5b97965b56-74jhg   1/1     Running   0          74s   10.244.0.92   devops-course   <none>           <none>
troubleshooting-app-5b97965b56-8ln9v   1/1     Running   0          73s   10.244.0.93   devops-course   <none>           <none>
+ kubectl -n a13 get endpointslices
NAME                            ADDRESSTYPE   PORTS   ENDPOINTS                 AGE
troubleshooting-service-7lqqk   IPv4          80      10.244.0.93,10.244.0.92   73s
+ kubectl -n a13 get endpoints troubleshooting-service
Warning: v1 Endpoints is deprecated in v1.33+; use discovery.k8s.io/v1 EndpointSlice
NAME                      ENDPOINTS                       AGE
troubleshooting-service   10.244.0.92:80,10.244.0.93:80   74s
+ for name in crashloop image-error pending container-creating config-error project-broken-pod
+ kubectl -n a13 describe pod crashloop
+ for name in crashloop image-error pending container-creating config-error project-broken-pod
+ kubectl -n a13 describe pod image-error
+ for name in crashloop image-error pending container-creating config-error project-broken-pod
+ kubectl -n a13 describe pod pending
+ for name in crashloop image-error pending container-creating config-error project-broken-pod
+ kubectl -n a13 describe pod container-creating
+ for name in crashloop image-error pending container-creating config-error project-broken-pod
+ kubectl -n a13 describe pod config-error
+ for name in crashloop image-error pending container-creating config-error project-broken-pod
+ kubectl -n a13 describe pod project-broken-pod
+ kubectl -n a13 top pods
NAME                                   CPU(cores)   MEMORY(bytes)   
crashloop                              2m           0Mi             
image-error                            2m           0Mi             
pending                                2m           0Mi             
project-broken-pod                     5m           4Mi             
troubleshooting-app-5b97965b56-74jhg   1m           6Mi             
troubleshooting-app-5b97965b56-8ln9v   2m           4Mi             
+ kubectl delete namespace a13
namespace "a13" deleted

```
