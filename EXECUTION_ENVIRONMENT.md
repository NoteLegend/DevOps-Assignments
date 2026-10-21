# Execution environment and evidence dates

[Portfolio](README.md) · [Reproduction guide](REPRODUCING.md)

## Review on 21 October 2026

Host Docker 29.9.1 is accessible. The prepared Ubuntu VM was not restarted. Original Linux/Docker/Minikube evidence remains labelled as VM execution; the existing host kind environment and unrelated services were preserved.

With explicit owner approval, Assignment 15 ran successful hosted calculator CI/CD and published its verified image to GHCR. Assignment 16 ran its complete hosted build/test/SAST/SCA/secret/image-scan/gate/push/deploy sequence, using an isolated kind cluster on the GitHub runner. That cluster was deleted before the successful job completed. Actual hosted run URLs, logs and screenshots are retained in each assignment.

AWS browser CLI sign-in supplied temporary credentials for account `835582727900`. The owner separately reviewed and approved the exact Assignment 17/18 create → verify → destroy plans in `us-east-1`. Their individual READMEs and lifecycle summaries record actual resource results and cleanup; no account upgrade was authorized. Plans, state, tokens and exported credentials are excluded from submission.

Assignment 20 is delivered as the existing devOps-TaskBoard repository link, per the owner's latest instruction. No duplicate capstone implementation is submitted.

## Original October-7 execution record

Source PDF: `../DevOps Homework.pdf` (54 pages). Workspace: `/home/rushixd/Wurk/Scaler/DevOps`. Submission contains exactly 20 assignment directories; Sessions 1–2 are combined.

## Host and VM

Host Docker's root:docker socket was not accessible to this user's groups, and passwordless sudo was unavailable. The pre-existing Docker daemon/configuration was left alone. A rootless attempt encountered unavailable TUN support for the running host kernel. Required privileged Linux/Docker/Kubernetes tasks therefore used the single prepared Ubuntu 24.04 VM, not an additional VM.

All assignment source/evidence remains in this host workspace and is shared to the VM at `/workspace`. The VM uses local SSH on 127.0.0.1:2222 and local-only forwarded application ports. Docker's host-network examples refer to that VM's network, as labeled in the assignment READMEs.

Workspace adapters in `../.local-tools/bin/` forward Docker, Minikube, kubectl and Helm commands to that VM. Executed verification scripts refer to those machine-specific adapters/runtime helpers; they require this original workspace. Application source, Dockerfiles, manifests, charts and Terraform configuration can also be used with native tools. The command transcripts retain the exact commands actually run.

## Installed/downloaded tooling

Host user-local tools: Playwright/Chromium, PDF/image readers, actionlint, Bandit, pip-audit, pytest, Gitleaks, Trivy and Terraform. Locally extracted QEMU runs the VM. Minikube, kubectl and Helm were downloaded and installed into the VM. Ubuntu packages include Docker/buildx/Compose, Git, network utilities and ShellCheck. Detailed observed versions are recorded in the final runtime inventory and assignment transcripts.

## Original external-access record

The October-7 practical records preceded the later approved hosted/cloud follow-up. Public course repositories, official downloads, chart indexes, advisory databases and base container images were retrieved anonymously. The October-21 hosted/AWS actions are identified above and in the assignment-specific evidence.

An earlier attempt to clone the PDF's obsolete/mistyped public Kubernetes URL returned Authentication failed through the default Git helper path; no credential was supplied or deliberate sign-in performed. Subsequent public clones disabled interactive prompts. It caused no repository change or publication.

The PDF's external publication and real hosted/cloud execution requirements are identified per assignment. Local evidence is labeled separately. Private VM SSH/runtime secrets remain outside the submission and are never committed.
