# 11 · Kubernetes Ingress, ConfigMaps & Secrets

**Session 12** · **Local practical work verified**

[Portfolio](../README.md) · [Exact requirements](REQUIREMENTS.md) · [Submission readiness](../SUBMISSION_READINESS.md)

> Inject configuration and a runtime Secret, route traffic through Ingress, and diagnose the referenced Secret newline/encoding problem.

| Assignment record | Details |
| --- | --- |
| PDF source | DevOps Homework.pdf · pages 20, 21, 22 |
| Student | Rushi Jadhav · 10144 |
| Evidence | Successful transcripts: 1 · actual screenshots: 3 |
| Execution environment | Original local host / Ubuntu VM as identified in the transcripts |
| Review | 21 October 2026; historical output is retained unchanged |

## Requirement coverage

| PDF requirement | Implementation / document | Demonstrated behavior |
| --- | --- | --- |
| ConfigMap | [manifests/](manifests/) | Store configuration, inject it into the Pod and verify the observed value. |
| Secret template and runtime injection | [secret.yaml.example](secret.yaml.example) | Submit a placeholder template; verify runtime injection without printing the temporary value. |
| Ingress routing | [manifests/](manifests/) | Actual ingress-nginx routing through the application Service. |
| Troubleshooting | [evidence/01-config-secret-ingress-troubleshooting.md](evidence/01-config-secret-ingress-troubleshooting.md) | Before/after newline check, corrected Secret source and restarted workload. |

## Commands and verification

Key commands are shown below. The evidence records contain the complete executed scripts, exact resource names, output and exit status.

```bash
kubectl get configmaps
kubectl get ingress
kubectl describe ingress <ingress-name>
```

[Reproduction and tooling](../REPRODUCING.md) explains the original VM adapters, native-tool use and portable Git bundles. Full executed scripts and stdout/stderr are linked below.

## Observed result

The application received its ConfigMap/Secret and was accessed through the configured local Ingress. The original trailing newline was detected; the corrected runtime value no longer contained it.

## Troubleshooting and observations

Ingress declares HTTP routing; an Ingress controller implements it. The Secret demonstration checks the actual encoding mistake and does not claim a separate PostgreSQL authentication test.

## Secret handling and routing

A newline introduced by `echo` survives base64 encoding. Base64 is an encoding, not encryption; putting an actual Secret value into Git makes it recoverable from repository history. Only the placeholder YAML is submitted, while the demonstration creates the real temporary value at runtime.

The diagnostic inspected the injected value without printing it. Writing the value without a newline, recreating the Secret and replacing the environment-consuming Pods removed the trailing newline. This reproduces the source-value error; it does not claim a separate database authentication test.

Ingress declares HTTP host/path rules. The ingress-nginx controller watches those rules and implements routing to the Service. Other examples of controllers include Traefik and cloud load-balancer controllers; a Service alone does not interpret Ingress rules.

## Submission status

**COMPLETE.** The required practical work is documented and verified by the retained evidence. Publish the revised files and supply the final repository URL to submit.

## Execution evidence

- [01 config secret ingress troubleshooting](evidence/01-config-secret-ingress-troubleshooting.md) — successful execution

## Screenshots

Actual application pages and explicitly labelled views of captured command output. Full text records preserve output omitted from an image.

<details>
<summary>Open the screenshot gallery (3 images)</summary>

![01 config secret ingress troubleshooting](screenshots/01-config-secret-ingress-troubleshooting.png)

![after secret newline](screenshots/after-secret-newline.png)

![before secret newline](screenshots/before-secret-newline.png)

</details>
