# 12 · Kubernetes Storage, HPA & Probes

**Session 13** · **Local practical work verified**

[Portfolio](../README.md) · [Exact requirements](REQUIREMENTS.md) · [Submission readiness](../SUBMISSION_READINESS.md)

> Compare Kubernetes volume lifetimes, measure CPU-driven autoscaling and complete the persistent web mini project with all three probe types.

| Assignment record | Details |
| --- | --- |
| PDF source | DevOps Homework.pdf · pages 23, 24, 25 |
| Student | Rushi Jadhav · 10144 |
| Evidence | Successful transcripts: 5 · actual screenshots: 6 |
| Execution environment | Original local host / Ubuntu VM as identified in the transcripts |
| Review | 21 October 2026; historical output is retained unchanged |

## Requirement coverage

| PDF requirement | Implementation / document | Demonstrated behavior |
| --- | --- | --- |
| Required volume documentation | [01-kubernetes-volumes/README.md](01-kubernetes-volumes/README.md) | emptyDir, hostPath, PV, PVC, StorageClass and dynamic provisioning. |
| HPA exercise and load generator | [hpa/hpa.yml](hpa/hpa.yml) | Actual CPU load, get hpa/pods, top pods and describe hpa. |
| Persistent mini project | [mini-project/](mini-project/) | PVC-backed content survives Pod replacement; startup/readiness/liveness probes inspected. |
| Default recovery behavior | [evidence/07-complete-default-scaling-cycle-retry.md](evidence/07-complete-default-scaling-cycle-retry.md) | Observed scale-up and return to two replicas using default stabilization. |

## Commands and verification

Key commands are shown below. The evidence records contain the complete executed scripts, exact resource names, output and exit status.

```bash
kubectl get hpa
kubectl get pods
kubectl top pods
kubectl describe hpa
```

[Reproduction and tooling](../REPRODUCING.md) explains the original VM adapters, native-tool use and portable Git bundles. Full executed scripts and stdout/stderr are linked below.

## Observed result

Volume lifetime/persistence checks succeeded. Real load caused scaling, and the repeated mini-project cycle recorded the default scale-down stabilization and return to two replicas.

## Troubleshooting and observations

A single-node ReadWriteOnce demonstration does not establish multi-node storage portability. Historical persistence evidence includes `Student: <YOUR NAME>`; it is a recorded test marker, not a claimed identity. The actual student details are in the portfolio identity file.

## Probe responsibilities

| Probe | Purpose in the mini project |
| --- | --- |
| Startup | Allows application initialization before ordinary health enforcement |
| Readiness | Controls eligibility to receive Service traffic |
| Liveness | Restarts a container whose health check fails |

The successful final cycle records all three configurations plus a stored marker surviving Pod replacement. Failed early downscale/namespace attempts remain linked separately from that successful cycle.

## Submission status

**COMPLETE.** The required practical work is documented and verified by the retained evidence. Publish the revised files and supply the final repository URL to submit.

## Execution evidence

- [01 volume lifetimes](evidence/01-volume-lifetimes.md) — successful execution
- [02 hpa probes persistence](evidence/02-hpa-probes-persistence.md) — successful execution
- [03 service and identity placeholder](evidence/03-service-and-identity-placeholder.md) — successful execution
- [05 observed scale down](evidence/05-observed-scale-down.md) — retained earlier attempt / diagnosis; use the successful retry for completion
- [06 complete default scaling cycle](evidence/06-complete-default-scaling-cycle.md) — retained earlier attempt / diagnosis; use the successful retry for completion
- [07 complete default scaling cycle retry](evidence/07-complete-default-scaling-cycle-retry.md) — successful execution
- [08 probe examples and owned cleanup](evidence/08-probe-examples-and-owned-cleanup.md) — successful execution

## Screenshots

Actual application pages and explicitly labelled views of captured command output. Full text records preserve output omitted from an image.

<details>
<summary>Open the screenshot gallery (6 images)</summary>

![01 volume lifetimes](screenshots/01-volume-lifetimes.png)

![02 hpa probes persistence](screenshots/02-hpa-probes-persistence.png)

![03 service and identity placeholder](screenshots/03-service-and-identity-placeholder.png)

![04 mini project page](screenshots/04-mini-project-page.png)

![07 complete default scaling cycle retry](screenshots/07-complete-default-scaling-cycle-retry.png)

![08 probe examples and owned cleanup](screenshots/08-probe-examples-and-owned-cleanup.png)

</details>
