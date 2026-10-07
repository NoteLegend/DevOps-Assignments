# Final local cleanup

Assignment-owned application containers, Compose services/networks/volumes, Kubernetes workload namespaces/PVCs/static PV, Helm releases, GitOps controllers, proxies, tunnels and port-forwards were cleaned up after evidence capture. The assignment Minikube profile was stopped; the single prepared Ubuntu VM was shut down. No assignment-owned service is currently running. The pre-existing host Docker installation/service was left untouched.

The final host checks found no VM PID and none of its forwarded ports listening. Actual checks follow.

```text
devops-course gcr.io/k8s-minikube/kicbase:v0.0.51 Up About an hour
NAME              STATUS   AGE
default           Active   83m
ingress-nginx     Active   66m
kube-node-lease   Active   83m
kube-public       Active   83m
kube-system       Active   83m
* Stopping node "devops-course"  ...
* Powering off "devops-course" via SSH ...
* 1 node stopped.
```

```json
{
  "checked_at": "2026-10-07T14:53:24.107578+05:30",
  "assignment_vm_running": false,
  "pid_file_present": false,
  "forwarded_ports_listening": {
    "2222": false,
    "8080": false,
    "8081": false,
    "8082": false,
    "8083": false,
    "8084": false,
    "8085": false,
    "8086": false,
    "8088": false,
    "8090": false,
    "8091": false,
    "8092": false,
    "9090": false,
    "3000": false
  }
}
```

Three temporary runtime-secret files were checked against submission text/history and removed from the workspace runtime directory. Submission caches, Python bytecode and downloaded Terraform provider directories were removed; provider lock files and actual build/test evidence remain. Four isolated `.git` directories were archived outside the submission, with verified portable history bundles retained inside it.

No further service cleanup is needed. Downloaded tools, public reference checkouts, the stopped VM disk and caches remain in `../.local-tools/` for reproducibility; the runtime directory occupies approximately 16 GB. They are outside the submission and are not part of the proposed Git publication. Removing that runtime later would remove the reusable VM; preserve any tooling/history you want first. No unrelated files were deleted.
