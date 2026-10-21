# Executed commands and captured output

```bash
#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
for image in busybox:1.36 nginx:1.27 nginx:1.24 nginx:1.25 gcr.io/google-samples/kubernetes-bootcamp:v1 jocatalin/kubernetes-bootcamp:v2; do
 docker pull "$image"
 minikube -p devops-course image load "$image"
done
kubectl wait --for=condition=Ready nodes --all --timeout=180s
kubectl get pods -n kube-system

```

```text
Executed 2026-10-07T13:34:09.254705+05:30
Working directory: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-08-Session-09
Script: preload-images.sh
Exit status: 0

+ source ../../.local-tools/env.sh
++ _devops_trace=0
++ case $- in
++ _devops_trace=1
++ set +x
++ unset _devops_trace
+ for image in busybox:1.36 nginx:1.27 nginx:1.24 nginx:1.25 gcr.io/google-samples/kubernetes-bootcamp:v1 jocatalin/kubernetes-bootcamp:v2
+ docker pull busybox:1.36
1.36: Pulling from library/busybox
034d6572bf28: Pulling fs layer
034d6572bf28: Download complete
034d6572bf28: Pull complete
5108bc06b83a: Download complete
Digest: sha256:73aaf090f3d85aa34ee199857f03fa3a95c8ede2ffd4cc2cdb5b94e566b11662
Status: Downloaded newer image for busybox:1.36
docker.io/library/busybox:1.36
+ minikube -p devops-course image load busybox:1.36
+ for image in busybox:1.36 nginx:1.27 nginx:1.24 nginx:1.25 gcr.io/google-samples/kubernetes-bootcamp:v1 jocatalin/kubernetes-bootcamp:v2
+ docker pull nginx:1.27
1.27: Pulling from library/nginx
32e44235e1d5: Pulling fs layer
d2a7ba8dbfee: Pulling fs layer
56b81cfa547d: Pulling fs layer
dad67da3f26b: Pulling fs layer
3b00567da964: Pulling fs layer
979e6233a40a: Pulling fs layer
1bc5dc8b475d: Pulling fs layer
32e44235e1d5: Download complete
d2a7ba8dbfee: Download complete
1bc5dc8b475d: Download complete
56b81cfa547d: Download complete
979e6233a40a: Download complete
c117e190f2b5: Download complete
46c98da93395: Download complete
dad67da3f26b: Download complete
dad67da3f26b: Pull complete
3b00567da964: Download complete
3b00567da964: Pull complete
56b81cfa547d: Pull complete
1bc5dc8b475d: Pull complete
979e6233a40a: Pull complete
d2a7ba8dbfee: Pull complete
32e44235e1d5: Pull complete
Digest: sha256:6784fb0834aa7dbbe12e3d7471e69c290df3e6ba810dc38b34ae33d3c1c05f7d
Status: Downloaded newer image for nginx:1.27
docker.io/library/nginx:1.27
+ minikube -p devops-course image load nginx:1.27
+ for image in busybox:1.36 nginx:1.27 nginx:1.24 nginx:1.25 gcr.io/google-samples/kubernetes-bootcamp:v1 jocatalin/kubernetes-bootcamp:v2
+ docker pull nginx:1.24
1.24: Pulling from library/nginx
5ac1ebd8aebe: Pulling fs layer
6989106bacf0: Pulling fs layer
cb49393af980: Pulling fs layer
c00d1142b331: Pulling fs layer
04e7578caeaa: Pulling fs layer
57a1056ea484: Pulling fs layer
c00d1142b331: Download complete
6989106bacf0: Download complete
cb49393af980: Download complete
5ac1ebd8aebe: Download complete
54247e67c145: Download complete
2f39813903ff: Download complete
57a1056ea484: Download complete
04e7578caeaa: Download complete
04e7578caeaa: Pull complete
57a1056ea484: Pull complete
6989106bacf0: Pull complete
c00d1142b331: Pull complete
cb49393af980: Pull complete
5ac1ebd8aebe: Pull complete
Digest: sha256:f6daac2445b0ce70e64d77442ccf62839f3f1b4c24bf6746a857eff014e798c8
Status: Downloaded newer image for nginx:1.24
docker.io/library/nginx:1.24
+ minikube -p devops-course image load nginx:1.24
+ for image in busybox:1.36 nginx:1.27 nginx:1.24 nginx:1.25 gcr.io/google-samples/kubernetes-bootcamp:v1 jocatalin/kubernetes-bootcamp:v2
+ docker pull nginx:1.25
1.25: Pulling from library/nginx
64e88cf7effa: Download complete
de3b062c0af7: Pulling fs layer
971bb7f4fb12: Pulling fs layer
09f376ebb190: Pulling fs layer
45337c09cd57: Pulling fs layer
999643392fb7: Pulling fs layer
a11fc495bafd: Pulling fs layer
933cc8470577: Pulling fs layer
3b67ebbfa825: Download complete
933cc8470577: Download complete
de3b062c0af7: Download complete
971bb7f4fb12: Download complete
999643392fb7: Download complete
45337c09cd57: Download complete
09f376ebb190: Download complete
09f376ebb190: Pull complete
a11fc495bafd: Download complete
a11fc495bafd: Pull complete
933cc8470577: Pull complete
999643392fb7: Pull complete
971bb7f4fb12: Pull complete
45337c09cd57: Pull complete
de3b062c0af7: Pull complete
Digest: sha256:a484819eb60211f5299034ac80f6a681b06f89e65866ce91f356ed7c72af059c
Status: Downloaded newer image for nginx:1.25
docker.io/library/nginx:1.25
+ minikube -p devops-course image load nginx:1.25
+ for image in busybox:1.36 nginx:1.27 nginx:1.24 nginx:1.25 gcr.io/google-samples/kubernetes-bootcamp:v1 jocatalin/kubernetes-bootcamp:v2
+ docker pull gcr.io/google-samples/kubernetes-bootcamp:v1
v1: Pulling from google-samples/kubernetes-bootcamp
dfa9e924f957: Pulling fs layer
5c90d4a2d1a8: Pulling fs layer
ab30c63719b1: Pulling fs layer
d4fe0dc68927: Pulling fs layer
29d0bc1e8c52: Pulling fs layer
dfa9e924f957: Download complete
29d0bc1e8c52: Download complete
d4fe0dc68927: Download complete
ab30c63719b1: Download complete
5c90d4a2d1a8: Download complete
5c90d4a2d1a8: Pull complete
ab30c63719b1: Pull complete
29d0bc1e8c52: Pull complete
d4fe0dc68927: Pull complete
dfa9e924f957: Pull complete
Digest: sha256:0d6b8ee63bb57c5f5b6156f446b3bc3b3c143d233037f3a2f00e279c8fcc64af
Status: Downloaded newer image for gcr.io/google-samples/kubernetes-bootcamp:v1
gcr.io/google-samples/kubernetes-bootcamp:v1
+ minikube -p devops-course image load gcr.io/google-samples/kubernetes-bootcamp:v1
+ for image in busybox:1.36 nginx:1.27 nginx:1.24 nginx:1.25 gcr.io/google-samples/kubernetes-bootcamp:v1 jocatalin/kubernetes-bootcamp:v2
+ docker pull jocatalin/kubernetes-bootcamp:v2
v2: Pulling from jocatalin/kubernetes-bootcamp
8cbcd299f923: Pulling fs layer
8cbcd299f923: Download complete
8cbcd299f923: Pull complete
Digest: sha256:fb1a3ced00cecfc1f83f18ab5cd14199e30adc1b49aa4244f5d65ad3f5feb2a5
Status: Downloaded newer image for jocatalin/kubernetes-bootcamp:v2
docker.io/jocatalin/kubernetes-bootcamp:v2
+ minikube -p devops-course image load jocatalin/kubernetes-bootcamp:v2
+ kubectl wait --for=condition=Ready nodes --all --timeout=180s
node/devops-course condition met
+ kubectl get pods -n kube-system
NAME                                    READY   STATUS    RESTARTS   AGE
coredns-589f44dc88-7r7bm                1/1     Running   0          5m57s
etcd-devops-course                      1/1     Running   0          6m3s
kindnet-w2tvm                           1/1     Running   0          103s
kube-apiserver-devops-course            1/1     Running   0          6m3s
kube-controller-manager-devops-course   1/1     Running   0          6m3s
kube-proxy-qg2k5                        1/1     Running   0          5m58s
kube-scheduler-devops-course            1/1     Running   0          6m3s
storage-provisioner                     1/1     Running   0          6m1s

```
