## Objective

Investigate actual Kubernetes failures with status, descriptions, logs, events, exec, explain and metrics, then repair and verify them.

## Tasks Performed

Ran the troubleshooting mini project plus isolated CrashLoopBackOff, image pull, scheduling, missing Secret-volume and missing ConfigMap cases. Captured each before state, repaired its root cause and waited for readiness. Demonstrated and fixed a Service selector mismatch, incorrect DNS name and incorrect Pod port.

## Tools Used

Kubernetes, kubectl, Minikube and metrics-server in the local Ubuntu VM.

## Implementation

`cases/` contains intentional faults; `mini-project/` contains the course workload. `verify.sh` records the diagnostic sequence and actual fixes. These broken examples are teaching inputs, not production manifests.

## Verification

All repaired Pods became Ready. Correct Service endpoints, DNS answers and successful Pod/Service HTTP responses are recorded. Per-case before/after descriptions and CPU/memory readings support the conclusions.

## Troubleshooting / Observations

| Failure | Evidence / root cause | Fix |
| --- | --- | --- |
| CrashLoopBackOff | Previous logs and exit 1 | Replace faulty command with long-running process |
| ErrImagePull / ImagePullBackOff | Invalid image/tag in events | Select existing nginx:1.27 |
| Pending | Unsatisfiable node selector | Recreate with valid scheduling requirements |
| ContainerCreating | Volume cannot mount missing Secret | Create runtime Secret without printing data |
| CreateContainerConfigError | Missing ConfigMap | Create expected configuration |
| Empty Service endpoints | Selector differs from Pod labels | Restore matching selector |
| DNS failure | Name references nonexistent Service | Use actual Service FQDN |
| Pod networking failure | Client uses unopened port | Use listening container port 80 |

The DNS and Pod-port examples diagnose application addressing; they do not claim a CNI outage. The separate cluster CNI repair is documented in Assignment 08.

## Output / Results

The fixed mini project serves Nginx over its Service. Deliberately broken resources are removed with the assignment namespace after evidence.

## Lessons Learned

Start with observed status/events, distinguish DNS from routing and readiness, and verify the application response after a successful rollout.

## Mini-project answers

The broken Pod displayed ErrImagePull and then ImagePullBackOff. Events reported failure to find/pull its nonexistent image tag. `kubectl describe pod project-broken-pod` exposed that reason; replacing the tag with the available nginx:1.27 image made it Ready.

| Problem | What I saw | Diagnostic command | Root cause | Fix |
| --- | --- | --- | --- | --- |
| Broken Pod | Image pull errors | describe pod | Invalid tag | Use nginx:1.27 |
| Service | Empty selected endpoints | describe service, get pods --show-labels | wrong-app selector | Match troubleshooting-app labels |
| Image problem | ErrImagePull/backoff events | events, describe pod | Requested image does not exist | Use verified image |

`get` summarizes current object state; `describe` adds details, conditions and events. Logs expose application output; exec runs diagnostics inside the container. CrashLoopBackOff is increasing delay between repeated container failures. ImagePullBackOff is retry delay after image retrieval failure. Pending can indicate scheduling constraints or insufficient resources. A Service can lack ready endpoints when labels do not match, Pods are unready or target configuration is wrong. Selectors choose Pod labels. Kubernetes DNS resolves Service and supported Pod names so clients do not depend on changing Pod IPs.
