# 10 · Kubernetes Networking & Services

**Session 11** · **Local practical work verified**

[Portfolio](../README.md) · [Exact requirements](REQUIREMENTS.md) · [Submission readiness](../SUBMISSION_READINESS.md)

> Deploy all five Service types, verify DNS and HTTP access, and document workload-controller comparisons, FQDNs and CoreDNS.

| Assignment record | Details |
| --- | --- |
| PDF source | DevOps Homework.pdf · pages 16, 17, 18, 19 |
| Student | Rushi Jadhav · 10144 |
| Evidence | Successful transcripts: 1 · actual screenshots: 1 |
| Execution environment | Original local host / Ubuntu VM as identified in the transcripts |
| Review | 21 October 2026; historical output is retained unchanged |

## Requirement coverage

| PDF requirement | Implementation / document | Demonstrated behavior |
| --- | --- | --- |
| Five Service types | [manifests/](manifests/) | ClusterIP, NodePort, local-tunnel LoadBalancer, ExternalName and Headless all deployed and checked. |
| Object comparisons | [README.md](README.md) | Deployment/ReplicaSet, Deployment/DaemonSet/StatefulSet, and ReplicaSet/Service. |
| FQDN document | [fqdn/README.md](fqdn/README.md) | Namespace-qualified Service names and Pod-to-Service examples. |
| CoreDNS document | [coredns/README.md](coredns/README.md) | Configuration, discovery, query resolution and troubleshooting. |

## Commands and verification

Key commands are shown below. The evidence records contain the complete executed scripts, exact resource names, output and exit status.

```bash
kubectl get services
kubectl get endpointslices
kubectl -n kube-system get configmap coredns -o yaml
```

[Reproduction and tooling](../REPRODUCING.md) explains the original VM adapters, native-tool use and portable Git bundles. Full executed scripts and stdout/stderr are linked below.

## Observed result

Server-side dry-run accepted the manifests and real DNS/HTTP checks succeeded for all five types. The LoadBalancer result used a local Minikube tunnel rather than a cloud load balancer.

## Troubleshooting and observations

Headless DNS resolves endpoint addresses, so clients must use the listening Pod port. ExternalName provides a CNAME rather than proxy endpoints.

## Submission status

**COMPLETE.** The required practical work is documented and verified by the retained evidence. Publish the revised files and supply the final repository URL to submit.

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

## Execution evidence

- [01 all service types](evidence/01-all-service-types.md) — successful execution

## Screenshots

Actual application pages and explicitly labelled views of captured command output. Full text records preserve output omitted from an image.

<details>
<summary>Open the screenshot gallery (1 images)</summary>

![01 all service types](screenshots/01-all-service-types.png)

</details>
