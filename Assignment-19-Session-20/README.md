# 19 · Monitoring, Observability & GitOps

**Session 20** · **Local practical work verified**

[Portfolio](../README.md) · [Exact requirements](REQUIREMENTS.md) · [Submission readiness](../SUBMISSION_READINESS.md)

> Demonstrate real metrics, logs and alerts, explain observability, and reconcile Kubernetes from committed local Git state.

| Assignment record | Details |
| --- | --- |
| PDF source | DevOps Homework.pdf · pages 47, 48 |
| Student | Rushi Jadhav · 10144 |
| Evidence | Successful transcripts: 2 · actual screenshots: 5 |
| Execution environment | Original local host / Ubuntu VM as identified in the transcripts |
| Review | 21 October 2026; historical output is retained unchanged |

## Requirement coverage

| PDF requirement | Implementation / document | Demonstrated behavior |
| --- | --- | --- |
| Monitoring demo | [monitoring/](monitoring/) | Application health/request metrics and VM CPU/memory via Prometheus and node-exporter. |
| Actual alert and recovery | [evidence/04-monitoring-content-type-fix-and-verification.md](evidence/04-monitoring-content-type-fix-and-verification.md) | Target outage produces a firing alert; restored target clears it. |
| Observability documentation | [observability.md](observability.md) | Metrics/logs/traces, tools and Kubernetes diagnosis. |
| GitOps demonstration | [gitops/](gitops/) | Five-second reconciliation corrects manual drift and deploys a newly committed version. |

## Commands and verification

Key commands are shown below. The evidence records contain the complete executed scripts, exact resource names, output and exit status.

```bash
curl -fsS http://127.0.0.1:9090/api/v1/alerts
git log --oneline
kubectl get deployments
```

[Reproduction and tooling](../REPRODUCING.md) explains the original VM adapters, native-tool use and portable Git bundles. Full executed scripts and stdout/stderr are linked below.

## Observed result

Real targets became UP, metrics queries returned data, the induced outage fired an alert and recovery cleared it. Local Git drift correction and a committed version change were observed; the Git bundle preserves the history.

## Troubleshooting and observations

Prometheus required the correct metrics Content-Type. Trace IDs in request logs are useful correlation, but this exercise does not claim a distributed trace collector.

## GitOps workflow demonstrated

The controller reads the Deployment committed on local Git `main` every five seconds and applies that desired state. Uncommitted file edits are not its source. The exercise changed live replicas manually and observed correction; a new commit then promoted the real application version. No GitHub repository or cloud cluster was required for this PDF exercise.

The desired state is declarative, versioned and repeatedly reconciled. A successful one-time apply is not the same behavior as continuous reconciliation. The separate final project omits replicas from Git where HPA owns that field.

## Submission status

**COMPLETE.** The required practical work is documented and verified by the retained evidence. Publish the revised files and supply the final repository URL to submit.

## Execution evidence

- [01 monitoring health alert and recovery](evidence/01-monitoring-health-alert-and-recovery.md) — retained earlier attempt / diagnosis; use the successful retry for completion
- [04 monitoring content type fix and verification](evidence/04-monitoring-content-type-fix-and-verification.md) — successful execution
- [05 local gitops reconciliation](evidence/05-local-gitops-reconciliation.md) — successful execution

## Screenshots

Actual application pages and explicitly labelled views of captured command output. Full text records preserve output omitted from an image.

<details>
<summary>Open the screenshot gallery (5 images)</summary>

![01 monitoring health alert and recovery](screenshots/01-monitoring-health-alert-and-recovery.png)

![02 prometheus targets](screenshots/02-prometheus-targets.png)

![03 prometheus alert](screenshots/03-prometheus-alert.png)

![04 monitoring content type fix and verification](screenshots/04-monitoring-content-type-fix-and-verification.png)

![05 local gitops reconciliation](screenshots/05-local-gitops-reconciliation.png)

</details>
