# Final submission audit

The PDF mapping was checked against all 54 pages and referenced course exercises. Exactly 20 assignment folders exist: Sessions 1–2 combined, then Sessions 3–21 individually. [Requirement coverage](REQUIREMENT_COVERAGE.md) maps every practical requirement to files/evidence or an explicit external blocker.

**15 assignments are locally COMPLETE; 5 are externally BLOCKED (15, 16, 17, 18, 20).** All five blocked assignments have their permitted local work executed and verified. Publication-only requirements elsewhere are explicitly owner-deferred.

The automated [audit report](AUDIT.json) checks every assignment README, all embedded PNGs and relative Markdown links, Bash/Python/YAML/JSON syntax, required named deliverables, successful execution transcripts and final statuses. Real Docker builds/runs, Kubernetes apply/HTTP/persistence/HPA/fault repairs, Helm install/upgrade/rollback/uninstall, and local monitoring/GitOps are captured in assignment evidence. Terraform init/fmt/check/validate succeeded for all three projects; no cloud plan/apply/state inspection/destroy was performed. Workflows passed actionlint locally; no hosted execution is claimed.

Command screenshots display actual captured stdout/stderr in a clearly labeled browser view. Application and monitoring screenshots show actual local pages; representative pages were visually inspected and all PNGs decoded successfully. Failed attempts remain documented alongside successful retries. There are no fabricated hosted/cloud results.

Gitleaks scanned the submission source and all four local Git histories with redaction and zero findings. Generated scanner-report evidence is excluded from Gitleaks signatures because public image signing-key fingerprints caused false positives; independent checks covered all text files for private-key/AWS-key/cookie patterns and exact temporary runtime secrets plus their base64 encodings. Those values were also checked against all archived Git patches; zero matches were found.

No GitHub login or hosted workflow trigger, registry login/publication, Git push, remote repository modification, remote Kubernetes deployment or cloud resource creation was performed in the resumed execution. The earlier obsolete-URL clone failure is disclosed in [execution environment](EXECUTION_ENVIRONMENT.md). External stages await owner action; existing credentials were not treated as authorization.

Submission caches and nested Git metadata were cleaned up after portable bundles were verified. All assignment workloads, the local cluster and VM are stopped; see [cleanup](CLEANUP.md). The pre-existing host Docker service was not modified.

Before personal submission, replace [identity placeholders](IDENTITY.md). Genuine hosted CI/registry and AWS evidence must be added only after those separately approved stages run. Local browser pages were captured automatically; no additional local browser verification is pending.

## Captured final secret-scan output

```text

    ○
    │╲
    │ ○
    ○ ░
    ░    gitleaks

2:54PM INF scanned ~387344 bytes (387.34 KB) in 85.7ms
2:54PM INF no leaks found
```

Actual temporary-value comparison summary (values omitted):

```json
{
  "checked_runtime_files": [
    "mysql.env",
    "secret-good",
    "secret-bad"
  ],
  "temporary_secrets_checked": 3,
  "raw_and_base64_matches": 0,
  "archived_histories_checked": 4
}
```
