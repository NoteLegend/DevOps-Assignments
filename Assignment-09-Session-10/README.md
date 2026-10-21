# 09 · Kubernetes Pods, ReplicaSets & Deployments

**Session 10** · **Local practical work verified**

[Portfolio](../README.md) · [Exact requirements](REQUIREMENTS.md) · [Submission readiness](../SUBMISSION_READINESS.md)

> Implement all four requested deployment strategies and demonstrate every supplied Pod lifecycle example.

| Assignment record | Details |
| --- | --- |
| PDF source | DevOps Homework.pdf · pages 13, 14, 15 |
| Student | Rushi Jadhav · 10144 |
| Evidence | Successful transcripts: 2 · actual screenshots: 14 |
| Execution environment | Original local host / Ubuntu VM as identified in the transcripts |
| Review | 21 October 2026; historical output is retained unchanged |

## Requirement coverage

| PDF requirement | Implementation / document | Demonstrated behavior |
| --- | --- | --- |
| Rolling update | [strategies/](strategies/) | Observe old/new replica changes during an application update. |
| Blue-green and canary | [strategies/](strategies/) | Switch active Service selection; sample traffic across stable/canary Pods. |
| Recreate | [strategies/](strategies/) | Observe old Pods terminating before replacement Pods start. |
| All twelve lifecycle examples | [pod-lifecycle/](pod-lifecycle/) | Apply each YAML, record status/details, explain the observation and embed screenshots. |

## Commands and verification

Key commands are shown below. The evidence records contain the complete executed scripts, exact resource names, output and exit status.

```bash
kubectl get pods -o wide
kubectl describe pod <pod-name>
kubectl rollout status deployment/<deployment-name>
```

[Reproduction and tooling](../REPRODUCING.md) explains the original VM adapters, native-tool use and portable Git bundles. Full executed scripts and stdout/stderr are linked below.

## Observed result

All four strategies and all twelve lifecycle cases were executed. The canary sample recorded 14 canary and 86 stable responses out of 100 requests; this is a measured sample, not an exact traffic guarantee.

## Troubleshooting and observations

Service selection determines which replicas receive traffic; rollout settings determine replacement behavior. Pod phase and container waiting/restart conditions describe different aspects of lifecycle.

## Observed lifecycle cases

| Course YAML | Observation | Captured output |
| --- | --- | --- |
| [01-running.yaml](pod-lifecycle/01-running.yaml) | Long-running container reached Running/Ready. | [Actual details](evidence/lifecycle-running-details.txt) |
| [02-pending.yaml](pod-lifecycle/02-pending.yaml) | 9Gi request could not schedule on the 4Gi node; Pod stayed Pending. | [Actual details](evidence/lifecycle-pending-details.txt) |
| [03-succeeded.yaml](pod-lifecycle/03-succeeded.yaml) | Finite command completed successfully; phase Succeeded (Completed display). | [Actual details](evidence/lifecycle-succeeded-details.txt) |
| [04-failed.yaml](pod-lifecycle/04-failed.yaml) | Finite command exited unsuccessfully; phase Failed (Error display). | [Actual details](evidence/lifecycle-failed-details.txt) |
| [05-crashloopbackoff.yaml](pod-lifecycle/05-crashloopbackoff.yaml) | Repeated exit 1 caused restarts and CrashLoopBackOff delay. | [Actual details](evidence/lifecycle-crashloop-details.txt) |
| [06-imagepullbackoff.yaml](pod-lifecycle/06-imagepullbackoff.yaml) | Nonexistent image produced image-pull errors and retry backoff. | [Actual details](evidence/lifecycle-image-error-details.txt) |
| [07-readiness.yaml](pod-lifecycle/07-readiness.yaml) | Readiness failure prevented the running Pod from being ready for Service traffic. | [Actual details](evidence/lifecycle-readiness-details.txt) |
| [08-liveness.yaml](pod-lifecycle/08-liveness.yaml) | Removal of the health file failed liveness and caused container restarts. | [Actual details](evidence/lifecycle-liveness-details.txt) |
| [09-startup.yaml](pod-lifecycle/09-startup.yaml) | A 30-second startup delay was tolerated before normal health checks. | [Actual details](evidence/lifecycle-startup-details.txt) |
| [10-init-container.yaml](pod-lifecycle/10-init-container.yaml) | Init work completed before the main container could start. | [Actual details](evidence/lifecycle-init-details.txt) |
| [11-multi-container.yaml](pod-lifecycle/11-multi-container.yaml) | Application and sidecar both contributed to Pod readiness. | [Actual details](evidence/lifecycle-multi-container-details.txt) |
| [12-termination.yaml](pod-lifecycle/12-termination.yaml) | The SIGTERM trap performed cleanup during graceful termination. | [Actual details](evidence/lifecycle-termination-details.txt) |

Pod phase, container waiting/restart state and readiness are separate signals. The screenshot gallery below includes the individual cases.

## Submission status

**COMPLETE.** The required practical work is documented and verified by the retained evidence. Publish the revised files and supply the final repository URL to submit.

## Execution evidence

- [01 deployment strategies](evidence/01-deployment-strategies.md) — successful execution
- [02 all pod lifecycle cases](evidence/02-all-pod-lifecycle-cases.md) — successful execution

## Screenshots

Actual application pages and explicitly labelled views of captured command output. Full text records preserve output omitted from an image.

<details>
<summary>Open the screenshot gallery (14 images)</summary>

![01 deployment strategies](screenshots/01-deployment-strategies.png)

![02 all pod lifecycle cases](screenshots/02-all-pod-lifecycle-cases.png)

![lifecycle crashloop details](screenshots/lifecycle-crashloop-details.png)

![lifecycle failed details](screenshots/lifecycle-failed-details.png)

![lifecycle image error details](screenshots/lifecycle-image-error-details.png)

![lifecycle init details](screenshots/lifecycle-init-details.png)

![lifecycle liveness details](screenshots/lifecycle-liveness-details.png)

![lifecycle multi container details](screenshots/lifecycle-multi-container-details.png)

![lifecycle pending details](screenshots/lifecycle-pending-details.png)

![lifecycle readiness details](screenshots/lifecycle-readiness-details.png)

![lifecycle running details](screenshots/lifecycle-running-details.png)

![lifecycle startup details](screenshots/lifecycle-startup-details.png)

![lifecycle succeeded details](screenshots/lifecycle-succeeded-details.png)

![lifecycle termination details](screenshots/lifecycle-termination-details.png)

</details>
