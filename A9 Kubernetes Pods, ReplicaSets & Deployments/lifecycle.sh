#!/usr/bin/env bash
set -euxo pipefail
source ../../.local-tools/env.sh
kubectl create namespace a09-lifecycle
for file in pod-lifecycle/*.yaml; do kubectl -n a09-lifecycle apply -f "$file"; done
sleep 45
for file in pod-lifecycle/*.yaml; do
 name=$(sed -n 's/^  name: //p' "$file" | head -1)
 kubectl -n a09-lifecycle get pod "$name" -o wide
 kubectl -n a09-lifecycle describe pod "$name" > "evidence/$name-details.txt"
 cat "evidence/$name-details.txt"
 kubectl -n a09-lifecycle logs "$name" --all-containers=true || true
done
for name in lifecycle-running lifecycle-readiness lifecycle-startup lifecycle-init lifecycle-multi-container lifecycle-termination; do kubectl -n a09-lifecycle wait --for=condition=Ready "pod/$name" --timeout=120s; done
kubectl -n a09-lifecycle get pods
kubectl -n a09-lifecycle get pod lifecycle-succeeded -o jsonpath='{.status.phase}{"\n"}' | grep Succeeded
kubectl -n a09-lifecycle get pod lifecycle-failed -o jsonpath='{.status.phase}{"\n"}' | grep Failed
kubectl -n a09-lifecycle get pod lifecycle-pending -o jsonpath='{.status.phase}{"\n"}' | grep Pending
kubectl -n a09-lifecycle get pod lifecycle-liveness -o jsonpath='{.status.containerStatuses[0].restartCount}{"\n"}'
# Show actual termination cleanup before namespace cleanup.
kubectl -n a09-lifecycle logs -f lifecycle-termination > evidence/termination-log.txt & log_pid=$!
kubectl -n a09-lifecycle delete pod lifecycle-termination
wait "$log_pid" || true
cat evidence/termination-log.txt
kubectl -n a09-lifecycle get events --sort-by=.metadata.creationTimestamp
