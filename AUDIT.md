# Submission audit · 21 October 2026

[Portfolio](README.md) · [Exact remaining work](SUBMISSION_READINESS.md) · [Machine-readable checks](AUDIT.json)

## Outcome

**15 assignments have verified practical evidence. Assignments 15, 16, 17, 18 and 20 still have mandatory gaps.** The submission must not be described as 20/20 finished until those stages are executed and verified.

The full 54-page Homework PDF was reread. Sessions 1–2 are combined in Assignment 01, followed by Sessions 3–21 individually. The current source, retained execution records and the later Helpdesk cloud evidence were reviewed. This is a source/evidence audit, not a claim of a fresh cloud deployment or rerun of every workload.

## Checks performed

| Check | Result |
| --- | --- |
| Exact 20-folder assignment/session map | PASS |
| Required named deliverables / all assignment READMEs | PASS |
| Course Markdown/image/file links | PASS; see current JSON counts |
| Course screenshots | 102 PNGs decoded; all embedded in assignment READMEs |
| YAML / Python / Bash syntax | 94 YAML, 17 Python and 52 Bash files checked |
| Prepared combined-repository workflows | Four manual entry points; actionlint PASS; none triggered |
| Original evidence, requirement text and Git bundles | 313 byte comparisons; no changes |
| Original application/configuration source | 212 byte comparisons; no changes |
| Separate Helpdesk Markdown links | 363 checked; no broken local targets |
| Separate Helpdesk capture manifest | 49 recorded hashes match; no capture changed |
| Current submission source secret scan | Gitleaks PASS; zero findings with redaction enabled |
| Visual documentation review | Portfolio, Docker assignment and Helpdesk README previews inspected locally |

Generated scanner evidence is excluded from Gitleaks signatures to avoid known public signing-key fingerprint false positives. The static audit additionally checks all readable files for private-key/AWS-key/cookie patterns. Original generated evidence is preserved, not silently removed or relabelled.

## What was repaired

All canonical assignment folders and mapping links were restored, including the accidental nested Hello World/CI folders. Each assignment now has a requirement table, dated observations, actual evidence links, collapsible image gallery and honest remaining scope. Required DNS, volume, Helm, AWS-service and Terraform project READMEs were refreshed. Identity instructions now use the supplied Rushi Jadhav / 10144 details.

The portfolio index/status/coverage and Helpdesk handover were reconciled. The separate EKS deployment and teardown are recognized, while missing SAST/GitOps integration and the unperformed S3/EC2 exercises remain explicit. The technical work and final repository submission are the only handover gates documented here.

## Scope and limitations

Original practice output remains dated and unchanged. The old VM-based helper scripts are environment-specific; [reproduction notes](REPRODUCING.md) explain native-tool use and Git-bundle restoration. Successful historical scans are not a promise that future advisory databases will return the same result.

The pre-existing local kind container was observed and left untouched. No new workload, external login, Git push, registry publication, hosted CI execution or AWS operation was performed during this review. The existing public GitHub portfolio and recorded successful Helpdesk run were inspected anonymously. Revised local files are not yet published.

Current cloud billing/resources were not re-queried. Use the dated Helpdesk records as historical evidence, not as a new AWS account-wide inventory. The remaining checklist identifies the precise access/approval needed before any future external stage.
