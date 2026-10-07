#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
kubectl create namespace a10
kubectl -n a10 apply --dry-run=server -f manifests
kubectl -n a10 apply -f manifests
kubectl -n a10 rollout status deployment/web --timeout=180s
kubectl -n a10 run client --image=busybox:1.36 --restart=Never --command -- sleep 1800
kubectl -n a10 wait --for=condition=Ready pod/client --timeout=120s
for name in clusterip nodeport loadbalancer externalname headless; do
 kubectl -n a10 get svc "$name" -o wide
 kubectl -n a10 describe svc "$name"
 kubectl -n a10 exec client -- nslookup "$name.a10.svc.cluster.local"
 port=80; if [[ "$name" = headless ]]; then port=8080; fi
 kubectl -n a10 exec client -- wget -qO- "http://$name:$port"
done
node_ip=$(minikube -p devops-course ip)
../../.local-tools/vm.sh "curl -fsS http://$node_ip:30080"
../../.local-tools/vm.sh 'nohup minikube -p devops-course tunnel --cleanup=true >/tmp/devops-tunnel.log 2>&1 </dev/null & echo $! >/tmp/devops-tunnel.pid'
for attempt in {1..30}; do
 lb_ip=$(kubectl -n a10 get svc loadbalancer -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
 if [[ -n "$lb_ip" ]]; then break; fi
 sleep 2
done
test -n "$lb_ip"
../../.local-tools/vm.sh "curl -fsS http://$lb_ip"
kubectl -n a10 get svc
kubectl -n a10 get endpointslices
kubectl -n kube-system get configmap coredns -o yaml
kubectl -n kube-system logs -l k8s-app=kube-dns --tail=8
../../.local-tools/vm.sh 'kill "$(cat /tmp/devops-tunnel.pid)"'
kubectl delete namespace a10
