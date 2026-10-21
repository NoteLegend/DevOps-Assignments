# 13 · Kubernetes Troubleshooting

**Session 14** · **Local practical work verified**

[Portfolio](../README.md) · [Exact requirements](REQUIREMENTS.md) · [Submission readiness](../SUBMISSION_READINESS.md)

> Diagnose and repair actual Kubernetes failures using status, events, logs, exec, object explanations and metrics.

| Assignment record | Details |
| --- | --- |
| PDF source | DevOps Homework.pdf · pages 26, 27, 28 |
| Student | Rushi Jadhav · 10144 |
| Evidence | Successful transcripts: 1 · actual screenshots: 13 |
| Execution environment | Original local host / Ubuntu VM as identified in the transcripts |
| Review | 21 October 2026; historical output is retained unchanged |

## Requirement coverage

| PDF requirement | Implementation / document | Demonstrated behavior |
| --- | --- | --- |
| All requested diagnostic commands | [verify.sh](verify.sh) | get, describe, logs, exec, events, explain, top and wide output. |
| Container and scheduling failures | [cases/](cases/) | CrashLoopBackOff, ErrImagePull/ImagePullBackOff, Pending, ContainerCreating and configuration errors. |
| Service / DNS / Pod addressing | [evidence/01-troubleshooting-before-and-after.md](evidence/01-troubleshooting-before-and-after.md) | Wrong selector, wrong DNS name and unopened client port repaired and tested. |
| Course mini project | [mini-project/](mini-project/) | Problem, investigation, cause, correction and successful verification documented. |

## Commands and verification

Key commands are shown below. The evidence records contain the complete executed scripts, exact resource names, output and exit status.

```bash
kubectl get pods -o wide
kubectl describe pod <pod-name>
kubectl logs <pod-name> --previous
kubectl events
kubectl explain pod.spec
kubectl top pods
```

[Reproduction and tooling](../REPRODUCING.md) explains the original VM adapters, native-tool use and portable Git bundles. Full executed scripts and stdout/stderr are linked below.

## Observed result

All repaired Pods became Ready; corrected Services had usable endpoints, and DNS/HTTP checks succeeded. Before/after descriptions and screenshots are retained per failure.

## Troubleshooting and observations

Treat DNS failure, selector mismatch and wrong destination port as separate causes. Pod networking in this exercise concerns application addressing; it does not assert a CNI outage.

## Diagnosed causes and fixes

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

## Mini-project answers

The broken Pod displayed ErrImagePull and then ImagePullBackOff. Events reported failure to find/pull its nonexistent image tag. `kubectl describe pod project-broken-pod` exposed that reason; replacing the tag with the available nginx:1.27 image made it Ready.

| Problem | What I saw | Diagnostic command | Root cause | Fix |
| --- | --- | --- | --- | --- |
| Broken Pod | Image pull errors | describe pod | Invalid tag | Use nginx:1.27 |
| Service | Empty selected endpoints | describe service, get pods --show-labels | wrong-app selector | Match troubleshooting-app labels |
| Image problem | ErrImagePull/backoff events | events, describe pod | Requested image does not exist | Use verified image |

`get` summarizes current object state; `describe` adds details, conditions and events. Logs expose application output; exec runs diagnostics inside the container. CrashLoopBackOff is increasing delay between repeated container failures. ImagePullBackOff is retry delay after image retrieval failure. Pending can indicate scheduling constraints or insufficient resources. A Service can lack ready endpoints when labels do not match, Pods are unready or target configuration is wrong. Selectors choose Pod labels. Kubernetes DNS resolves Service and supported Pod names so clients do not depend on changing Pod IPs.

## Submission status

**COMPLETE.** The required practical work is documented and verified by the retained evidence. Publish the revised files and supply the final repository URL to submit.

## Execution evidence

- [01 troubleshooting before and after](evidence/01-troubleshooting-before-and-after.md) — successful execution

## Screenshots

Actual application pages and explicitly labelled views of captured command output. Full text records preserve output omitted from an image.

<details>
<summary>Open the screenshot gallery (13 images)</summary>

![01 troubleshooting before and after](screenshots/01-troubleshooting-before-and-after.png)

![after config error](screenshots/after-config-error.png)

![after container creating](screenshots/after-container-creating.png)

![after crashloop](screenshots/after-crashloop.png)

![after image error](screenshots/after-image-error.png)

![after pending](screenshots/after-pending.png)

![after project broken pod](screenshots/after-project-broken-pod.png)

![before config error](screenshots/before-config-error.png)

![before container creating](screenshots/before-container-creating.png)

![before crashloop](screenshots/before-crashloop.png)

![before image error](screenshots/before-image-error.png)

![before pending](screenshots/before-pending.png)

![before project broken pod](screenshots/before-project-broken-pod.png)

</details>
