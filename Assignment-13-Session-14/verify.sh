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
