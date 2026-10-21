# Executed commands and captured output

```bash
#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
kubectl create namespace a12-volumes
kubectl -n a12-volumes apply -f 01-kubernetes-volumes
kubectl -n a12-volumes wait --for=condition=Ready pod --all --timeout=180s
kubectl -n a12-volumes get pods,pvc
kubectl get pv,storageclass
for name in emptydir-demo hostpath-demo storage-demo; do
 kubectl -n a12-volumes exec "$name" -- sh -c 'echo actual-volume-test >/data/check.txt; cat /data/check.txt'
done
for file in 01-kubernetes-volumes/*.yaml; do
 case "$file" in *pod*|*emptydir*|*hostpath*) kubectl -n a12-volumes delete -f "$file"; kubectl -n a12-volumes apply -f "$file" ;; esac
done
kubectl -n a12-volumes wait --for=condition=Ready pod --all --timeout=180s
kubectl -n a12-volumes exec emptydir-demo -- sh -c 'test ! -f /data/check.txt && echo emptyDir-reset-after-pod-deletion'
kubectl -n a12-volumes exec hostpath-demo -- cat /data/check.txt
kubectl -n a12-volumes exec storage-demo -- cat /data/check.txt
kubectl -n a12-volumes describe pvc dynamic-pvc
kubectl delete namespace a12-volumes
kubectl delete pv student-pv

```

```text
Executed 2026-10-07T13:47:54.336472+05:30
Working directory: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-12-Session-13
Script: volumes.sh
Exit status: 0

+ source ../../.local-tools/env.sh
++ _devops_trace=0
++ case $- in
++ _devops_trace=1
++ set +x
++ unset _devops_trace
+ kubectl create namespace a12-volumes
namespace/a12-volumes created
+ kubectl -n a12-volumes apply -f 01-kubernetes-volumes
pod/emptydir-demo created
pod/hostpath-demo created
pod/storage-demo created
persistentvolume/student-pv created
persistentvolumeclaim/student-pvc created
persistentvolumeclaim/dynamic-pvc created
+ kubectl -n a12-volumes wait --for=condition=Ready pod --all --timeout=180s
pod/emptydir-demo condition met
pod/hostpath-demo condition met
pod/storage-demo condition met
+ kubectl -n a12-volumes get pods,pvc
NAME                READY   STATUS    RESTARTS   AGE
pod/emptydir-demo   1/1     Running   0          2s
pod/hostpath-demo   1/1     Running   0          2s
pod/storage-demo    1/1     Running   0          2s

NAME                                STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
persistentvolumeclaim/dynamic-pvc   Bound    pvc-c9e33004-d7e8-4f77-a1e7-e64af3b61f61   500Mi      RWO            standard       <unset>                 2s
persistentvolumeclaim/student-pvc   Bound    student-pv                                 1Gi        RWO                           <unset>                 2s
+ kubectl get pv,storageclass
NAME                                                        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                     STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
persistentvolume/pvc-c9e33004-d7e8-4f77-a1e7-e64af3b61f61   500Mi      RWO            Delete           Bound    a12-volumes/dynamic-pvc   standard       <unset>                          3s
persistentvolume/student-pv                                 1Gi        RWO            Retain           Bound    a12-volumes/student-pvc                  <unset>                          3s

NAME                                             PROVISIONER                RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
storageclass.storage.k8s.io/standard (default)   k8s.io/minikube-hostpath   Delete          Immediate           false                  19m
+ for name in emptydir-demo hostpath-demo storage-demo
+ kubectl -n a12-volumes exec emptydir-demo -- sh -c 'echo actual-volume-test >/data/check.txt; cat /data/check.txt'
actual-volume-test
+ for name in emptydir-demo hostpath-demo storage-demo
+ kubectl -n a12-volumes exec hostpath-demo -- sh -c 'echo actual-volume-test >/data/check.txt; cat /data/check.txt'
actual-volume-test
+ for name in emptydir-demo hostpath-demo storage-demo
+ kubectl -n a12-volumes exec storage-demo -- sh -c 'echo actual-volume-test >/data/check.txt; cat /data/check.txt'
actual-volume-test
+ for file in 01-kubernetes-volumes/*.yaml
+ case "$file" in
+ kubectl -n a12-volumes delete -f 01-kubernetes-volumes/01-volumes-emptydir-pod.yaml
pod "emptydir-demo" deleted from a12-volumes namespace
+ kubectl -n a12-volumes apply -f 01-kubernetes-volumes/01-volumes-emptydir-pod.yaml
pod/emptydir-demo created
+ for file in 01-kubernetes-volumes/*.yaml
+ case "$file" in
+ kubectl -n a12-volumes delete -f 01-kubernetes-volumes/01-volumes-hostpath-pod.yaml
pod "hostpath-demo" deleted from a12-volumes namespace
+ kubectl -n a12-volumes apply -f 01-kubernetes-volumes/01-volumes-hostpath-pod.yaml
pod/hostpath-demo created
+ for file in 01-kubernetes-volumes/*.yaml
+ case "$file" in
+ kubectl -n a12-volumes delete -f 01-kubernetes-volumes/02-persistent-storage-pod.yaml
pod "storage-demo" deleted from a12-volumes namespace
+ kubectl -n a12-volumes apply -f 01-kubernetes-volumes/02-persistent-storage-pod.yaml
pod/storage-demo created
+ for file in 01-kubernetes-volumes/*.yaml
+ case "$file" in
+ for file in 01-kubernetes-volumes/*.yaml
+ case "$file" in
+ for file in 01-kubernetes-volumes/*.yaml
+ case "$file" in
+ kubectl -n a12-volumes wait --for=condition=Ready pod --all --timeout=180s
pod/emptydir-demo condition met
pod/hostpath-demo condition met
pod/storage-demo condition met
+ kubectl -n a12-volumes exec emptydir-demo -- sh -c 'test ! -f /data/check.txt && echo emptyDir-reset-after-pod-deletion'
emptyDir-reset-after-pod-deletion
+ kubectl -n a12-volumes exec hostpath-demo -- cat /data/check.txt
actual-volume-test
+ kubectl -n a12-volumes exec storage-demo -- cat /data/check.txt
actual-volume-test
+ kubectl -n a12-volumes describe pvc dynamic-pvc
Name:          dynamic-pvc
Namespace:     a12-volumes
StorageClass:  standard
Status:        Bound
Volume:        pvc-c9e33004-d7e8-4f77-a1e7-e64af3b61f61
Labels:        <none>
Annotations:   pv.kubernetes.io/bind-completed: yes
               pv.kubernetes.io/bound-by-controller: yes
               volume.beta.kubernetes.io/storage-provisioner: k8s.io/minikube-hostpath
               volume.kubernetes.io/storage-provisioner: k8s.io/minikube-hostpath
Finalizers:    [kubernetes.io/pvc-protection]
Capacity:      500Mi
Access Modes:  RWO
VolumeMode:    Filesystem
Used By:       <none>
Events:
  Type    Reason                 Age   From                                                                         Message
  ----    ------                 ----  ----                                                                         -------
  Normal  ExternalProvisioning   13s   persistentvolume-controller                                                  Waiting for a volume to be created either by the external provisioner 'k8s.io/minikube-hostpath' or manually by the system administrator. If volume creation is delayed, please verify that the provisioner is running and correctly registered.
  Normal  Provisioning           13s   k8s.io/minikube-hostpath_devops-course_035f85de-a441-4aba-ada4-afc00ca442f0  External provisioner is provisioning volume for claim "a12-volumes/dynamic-pvc"
  Normal  ProvisioningSucceeded  13s   k8s.io/minikube-hostpath_devops-course_035f85de-a441-4aba-ada4-afc00ca442f0  Successfully provisioned volume pvc-c9e33004-d7e8-4f77-a1e7-e64af3b61f61
+ kubectl delete namespace a12-volumes
namespace "a12-volumes" deleted
+ kubectl delete pv student-pv
persistentvolume "student-pv" deleted

```
