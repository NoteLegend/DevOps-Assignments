# 16 · Complete CI/CD & DevSecOps

**Session 17** · **Complete · full hosted security-gated delivery verified**

[Portfolio](../README.md) · [Exact requirements](REQUIREMENTS.md) · [Submission readiness](../SUBMISSION_READINESS.md)

> Build a security-gated application pipeline with real local tests, four scanner categories, Docker execution and Kubernetes deployment.

| Assignment record | Details |
| --- | --- |
| PDF source | DevOps Homework.pdf · pages 35, 36, 37 |
| Student | Rushi Jadhav · 10144 |
| Evidence | Successful local/hosted records: 6 · actual screenshots: 8 |
| Execution environment | Original Ubuntu VM; new GitHub-hosted Ubuntu runner and isolated kind cluster |
| Review | 21 October 2026; historical output is retained unchanged |

## Requirement coverage

| PDF requirement | Implementation / document | Demonstrated behavior |
| --- | --- | --- |
| Application build and tests | [application/](application/) | Three application tests and compile validation. |
| SAST / SCA / secret scanning | [security/](security/) | Bandit, pip-audit and Gitleaks with actual retained reports. |
| Container scanning and gate | [security/gate.sh](security/gate.sh) | Trivy rejects all HIGH/CRITICAL findings, including unfixed findings. |
| Kubernetes and artifact integrity | [kubernetes/](kubernetes/) | Real local two-replica deployment; saved/loaded scanned image IDs are identical. |
| Hosted pipeline preparation | [.github/workflows/](.github/workflows/) | Repository-root manual workflow executed successfully; all security, publication and Kubernetes verification stages passed. |

## Commands and verification

Key commands are shown below. The evidence records contain the complete executed scripts, exact resource names, output and exit status.

```bash
python -m pytest -v
bandit -r application -c security/bandit.yaml
pip-audit -r requirements.txt
docker build -t devops-a16-app:local .
```

[Reproduction and tooling](../REPRODUCING.md) explains the original VM adapters, native-tool use and portable Git bundles. Full executed scripts and stdout/stderr are linked below.

## Observed result

Recorded final local scans: Bandit 0, dependency advisories 0, source-secret findings 0 and image HIGH/CRITICAL 0. Seven lower-severity image entries remain in the full dated report. The initial Debian scan and repair are retained.

## Troubleshooting and observations

The initial image had 44 HIGH/CRITICAL findings. Changing the runtime and rerunning the strict gate produced the recorded clean high-severity result; no unfixed-finding bypass is claimed.

## Security stages and retained reports

| Stage | Tool / gate | Actual report |
| --- | --- | --- |
| Source analysis | Bandit | [SAST report](evidence/sast.json) |
| Dependency analysis | pip-audit | [SCA report](evidence/sca.json) |
| Secret detection | Gitleaks with redaction | [Secret report](evidence/secrets.json) |
| Image analysis | Trivy; all HIGH/CRITICAL findings fail | [Full image report](evidence/image-scan.json) |

Generated image metadata initially matched two public signing-key fingerprints during secret scanning. Those redacted false positives were retained; generated evidence is separated from the source scan rather than being presented as an actual leaked runtime credential.

## Hosted execution — 21 October 2026

```mermaid
flowchart LR
  A[Compile / build] --> B[Unit tests] --> C[Bandit SAST]
  C --> D[pip-audit SCA] --> E[Gitleaks secrets]
  E --> F[Docker build] --> G[Trivy HIGH / CRITICAL gate]
  G --> H[GHCR push] --> I[Runner-local Kubernetes]
  I --> J[2 Ready replicas / HTTP health] --> K[Cluster cleanup]
```

The successful run used commit `ab2fbb4e5b4a59f12e99ae39df26cbafb571726f` and published `ghcr.io/notelegend/devops-assignments-devsecops:ab2fbb4e5b4a59f12e99ae39df26cbafb571726f`. Bandit, pip-audit, Gitleaks and the strict image gate passed. The built and published Docker image IDs are identical in the [downloaded evidence](evidence/hosted-devsecops/); this is the same image loaded into kind and used by the verified Deployment.

```bash
gh workflow run assignment-16-devsecops.yml --repo NoteLegend/DevOps-Assignments
gh run view 39584880376 --repo NoteLegend/DevOps-Assignments --log
gh run download 39584880376 --repo NoteLegend/DevOps-Assignments \
  --name devsecops-execution-evidence --dir evidence/hosted-devsecops
```

The first hosted attempt passed scans and image publication but failed when `kubectl set image` also encountered a Service in a combined manifest. Deployment and Service were separated, the local image patch was checked, and the complete rerun passed. The [original failure record](evidence/hosted-devsecops/initial-deployment-failure.json) is retained; it is not labelled successful. No AWS or remote Kubernetes cluster was used.

## Submission status

**COMPLETE.** [Run 39584880376](https://github.com/NoteLegend/DevOps-Assignments/actions/runs/39584880376) passed the complete ordered flow for this application. Its SHA-tagged image was pushed to GHCR, loaded into the runner’s isolated kind cluster and verified with two Ready replicas plus a real `/health` response. The assignment-owned cluster was deleted at the end of the run.

## Execution evidence

- [01 local devsecops pipeline](evidence/01-local-devsecops-pipeline.md) — successful execution
- [02 smaller runtime security verification](evidence/02-smaller-runtime-security-verification.md) — retained earlier attempt / diagnosis; use the successful retry for completion
- [03 alpine source scans and deployment](evidence/03-alpine-source-scans-and-deployment.md) — successful execution
- [04 strict high critical gate](evidence/04-strict-high-critical-gate.md) — successful execution
- [05 actual alpine runtime page](evidence/05-actual-alpine-runtime-page.md) — successful execution
- [06 shared image artifact identity](evidence/06-shared-image-artifact-identity.md) — successful execution

- [Successful hosted DevSecOps pipeline](evidence/07-hosted-devsecops.md) — complete real log and run/step record
- [Downloaded scanner, image identity, Kubernetes and HTTP results](evidence/hosted-devsecops/)

## Screenshots

Actual application pages and explicitly labelled views of captured command output. Full text records preserve output omitted from an image.

<details>
<summary>Open the screenshot gallery (8 images)</summary>

![01 local devsecops pipeline](screenshots/01-local-devsecops-pipeline.png)

![02 smaller runtime security verification](screenshots/02-smaller-runtime-security-verification.png)

![03 alpine source scans and deployment](screenshots/03-alpine-source-scans-and-deployment.png)

![04 strict high critical gate](screenshots/04-strict-high-critical-gate.png)

![05 actual alpine runtime page](screenshots/05-actual-alpine-runtime-page.png)

![06 actual application page](screenshots/06-actual-application-page.png)

![06 shared image artifact identity](screenshots/06-shared-image-artifact-identity.png)

![Successful hosted build, security gates, GHCR and Kubernetes verification](screenshots/07-hosted-devsecops.png)

</details>
