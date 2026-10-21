# Final submission audit — 21 October 2026

[Portfolio](README.md) · [Submission checklist](SUBMISSION_READINESS.md) · [Machine-readable checks](AUDIT.json)

## Outcome

**20 assignments accounted for; no required stage remains pending under the approved delivery scope.** Assignments 01–19 have practical implementation and retained execution/evidence. Assignment 20 is submitted as the existing [devOps-TaskBoard repository link](Assignment-20-Session-21/README.md), as explicitly requested by the owner.

The authoritative 54-page Homework PDF was reread and mapped to exactly 20 folders: Sessions 1–2 combined, then Sessions 3–21. Original exercises remain dated; the October-21 follow-up actually completed Assignment 15/16 hosted delivery and Assignment 17/18 AWS lifecycles.

## Checks performed

| Check | Actual result |
| --- | --- |
| Folder/session map | Exactly 20 canonical folders; correct combined Assignment 01 |
| Required files and documentation | Present; link-only capstone is an explicit owner-directed delivery exception |
| Markdown links | 540 local links checked; zero broken targets or linked-but-ignored files |
| Screenshots | 92 valid PNGs; assignment screenshots embedded with relative paths |
| Source/configuration syntax | 80 YAML, 14 Python and 39 Bash files checked |
| Root workflows | Three executable entry points; actionlint passed |
| README visualization review | 32 Mermaid diagrams parsed and rendered with Mermaid 11.12.0; representative desktop layouts inspected |
| Calculator CI / CD | Real successful runs [39584561631](https://github.com/NoteLegend/DevOps-Assignments/actions/runs/39584561631) / [39584567670](https://github.com/NoteLegend/DevOps-Assignments/actions/runs/39584567670); artifacts and GHCR push retained |
| Full DevSecOps delivery | Real successful run [39584880376](https://github.com/NoteLegend/DevOps-Assignments/actions/runs/39584880376); tests, four scanner categories, strict gate, GHCR and two Ready Kubernetes replicas/HTTP health |
| Scanned artifact identity | Built and published image IDs match; same image loaded into the runner-local kind cluster |
| S3 Terraform exercise | 2 resources created, inspected and destroyed; bucket not found afterward; state empty |
| EC2/S3 Terraform exercise | 6 resources created, inspected and destroyed; EC2 checks OK before teardown; VPC/bucket absent, instance terminated and EBS root disk absent afterward |
| Credential audit | Gitleaks working-tree and full reachable-history scans passed with redaction; zero findings |
| Runtime isolation | Only assignment-owned temporary resources cleaned; no replacement host Docker or new VM |

## Evidence integrity and cleanup

The GitHub pages are actual successful-run screenshots; downloaded logs/artifacts preserve real step output. AWS screenshots are browser captures of saved actual CLI transcripts, explicitly labelled in the READMEs. No AWS console dashboard or hosted result was fabricated. Failed first attempts and expected post-destroy not-found responses remain distinguishable from successful verification.

Terraform plans/state, exported temporary credentials, runtime files and provider caches remain outside the submission. Account `835582727900` retained its Free plan; no upgrade was performed. Both exact resource lifecycles were explicitly approved before apply and finished within the approved 30-minute lifetime. Settled AWS usage reporting can lag; zero cash charges are not inferred from unchanged credit displays.

The earlier Assignment-20 Flask prototype and an intermediate source snapshot were preserved outside the submission when the owner requested the existing capstone link only. Its old source/evidence also remains recoverable in earlier portfolio commits. No duplicate capstone source or presentation deliverable is included in the final assignment folders.

## Reproduction limits

Original VM/Minikube transcripts retain their environment labels; their historical helper scripts require the workspace adapters described in [REPRODUCING.md](REPRODUCING.md). New hosted runs and cloud evidence identify their own revisions and dates. A dated clean security scan is not a promise about future advisory databases. The static checker validates deliverables and retained proof; it does not create resources or rerun all workloads.
