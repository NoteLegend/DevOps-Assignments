# Assignment 10 — Kubernetes Networking & Services

Sessions 11. [Exact PDF requirements](REQUIREMENTS.md).

## Objective

Apply and verify ClusterIP, NodePort, LoadBalancer, ExternalName and Headless Services; explain workload objects and cluster DNS.

## Tasks Performed

Created a real two-replica workload and client Pod. Resolved all five Service names and accessed each type. Used Minikube's local tunnel for the LoadBalancer IP. Inspected EndpointSlices and CoreDNS configuration/logs.

## Tools Used

Kubernetes 1.36.0, kubectl 1.37.1, Minikube 1.39.0; execution was in the local Ubuntu VM.

## Implementation

`manifests/` has the application and all Service definitions. `fqdn/README.md` documents DNS names and `coredns/README.md` documents actual cluster DNS inspection.

## Verification

Server-side dry-run accepted every manifest. Pods became Ready; DNS and HTTP checks succeeded. NodePort and tunnel-backed LoadBalancer were reached from the VM. Full results are in the transcript.

## Output / Results

| Service | Routing | Demonstrated access |
| --- | --- | --- |
| ClusterIP | Stable internal virtual IP | Client Pod HTTP |
| NodePort | ClusterIP plus node port 30080 | VM to Minikube node |
| LoadBalancer | Local tunnel provided external IP | VM HTTP to assigned IP |
| ExternalName | DNS CNAME to another service | CNAME resolution and HTTP |
| Headless | Pod addresses without virtual IP | DNS Pod IPs and HTTP on 8080 |

## Troubleshooting / Observations

Headless DNS returns Pod addresses, so the HTTP client uses the container port 8080 rather than relying on Service port translation. ExternalName is a DNS alias and supplies no proxy/endpoints itself. The Minikube LoadBalancer is local, not a cloud load balancer.

| Object | Purpose / ownership |
| --- | --- |
| Pod | One scheduled unit of one or more containers sharing network/storage |
| ReplicaSet | Maintains matching Pod replica count |
| Deployment | Manages ReplicaSets and rolling/versioned updates |
| StatefulSet | Stable Pod identity/ordering and per-Pod persistent claims |
| DaemonSet | Runs a Pod on each eligible node |
| Job | Runs finite work to completion |
| CronJob | Schedules Jobs |
| Namespace | Scopes names and access for namespaced resources |

Object comparison is documentation, as requested; the exercise deploys only objects needed to test Services.

## Lessons Learned

Services decouple client addresses from replaceable Pods, but selectors and target ports must match actual workloads. DNS resolution and successful application traffic are separate checks.

Sources: [Services](https://kubernetes.io/docs/concepts/services-networking/service/), [controllers](https://kubernetes.io/docs/concepts/workloads/controllers/).


## Required object comparisons

| Aspect | Deployment | ReplicaSet |
| --- | --- | --- |
| Purpose | Declarative releases and update history | Maintain the desired number of matching Pods |
| Pod management | Creates/manages ReplicaSets, which manage Pods | Creates replacement Pods when its count is too low |
| Scaling | Sets desired replicas and distributes them to managed ReplicaSets | Adjusts the replica count of one Pod template |
| Rolling updates | Moves replicas from old to new ReplicaSet with surge/unavailability limits | Has no Deployment-style rolling release/history mechanism |
| Relationship | Owns ReplicaSets for each template revision | Usually owned by a Deployment; its owner controls releases |

| Aspect | Deployment | DaemonSet | StatefulSet |
| --- | --- | --- | --- |
| Use case / example | Interchangeable web/API replicas, such as this bootcamp app | Per-node agents, such as log collectors or node-exporter | Stateful replicas, such as a database requiring stable identity |
| Pod creation | ReplicaSets create replaceable Pods | Controller places one Pod on each eligible node | Controller creates Pods with stable ordinal names |
| Scaling | Change replicas or use HPA | Follows eligible node count and placement rules | Change replicas; creation/deletion can be ordered |
| Networking | Replaceable Pod addresses, normally behind a Service | Node-associated Pod addresses; host networking is optional | Stable DNS identities typically use a headless Service |
| Storage | Can mount claims but supplies no per-replica identity | Host/node storage is common for agents | volumeClaimTemplates provide distinct persistent claims per replica |

ReplicaSet keeps the selected replica count; a Service supplies discovery and a stable access point. A Service remains useful when replacement Pods receive new IPs. For ordinary selector-based Services, matching ready Pods appear in EndpointSlices, and traffic to the Service address is routed to those endpoints and target ports. ExternalName is a DNS alias; a headless Service returns endpoint addresses instead of the usual virtual IP.

Documentation sources: [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/), [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/), [StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/), [Service](https://kubernetes.io/docs/concepts/services-networking/service/).


## Commands Executed

The linked transcripts contain the exact executed scripts, stdout/stderr and exit status.

- [01-all-service-types.md](evidence/01-all-service-types.md)

## Screenshots

Command screenshots are browser views of real captured output, labeled as such; application screenshots show actual accessed pages.

![01-all-service-types](screenshots/01-all-service-types.png)
