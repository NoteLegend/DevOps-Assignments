# Execution environment and evidence dates

[Portfolio](README.md) · [Reproduction guide](REPRODUCING.md)

## Review on 21 October 2026

Host Docker is now accessible and reported server version 29.9.1 in a read-only local version check. The pre-existing taskboard-local-control-plane kind container was observed running and left untouched. No workload, cloud resource, credential session, registry or hosted workflow was changed for this review. The original records below describe the October-7 execution environment and are not a statement of current host limitations. Later Helpdesk local/AWS records describe their own environments.

## Original October-7 execution record

Source PDF: `../DevOps Homework.pdf` (54 pages). Workspace: `/home/rushixd/Wurk/Scaler/DevOps`. Submission contains exactly 20 assignment directories; Sessions 1–2 are combined.

## Host and VM

Host Docker's root:docker socket was not accessible to this user's groups, and passwordless sudo was unavailable. The pre-existing Docker daemon/configuration was left alone. A rootless attempt encountered unavailable TUN support for the running host kernel. Required privileged Linux/Docker/Kubernetes tasks therefore used the single prepared Ubuntu 24.04 VM, not an additional VM.

All assignment source/evidence remains in this host workspace and is shared to the VM at `/workspace`. The VM uses local SSH on 127.0.0.1:2222 and local-only forwarded application ports. Docker's host-network examples refer to that VM's network, as labeled in the assignment READMEs.

Workspace adapters in `../.local-tools/bin/` forward Docker, Minikube, kubectl and Helm commands to that VM. Executed verification scripts refer to those machine-specific adapters/runtime helpers; they require this original workspace. Application source, Dockerfiles, manifests, charts and Terraform configuration can also be used with native tools. The command transcripts retain the exact commands actually run.

## Installed/downloaded tooling

Host user-local tools: Playwright/Chromium, PDF/image readers, actionlint, Bandit, pip-audit, pytest, Gitleaks, Trivy and Terraform. Locally extracted QEMU runs the VM. Minikube, kubectl and Helm were downloaded and installed into the VM. Ubuntu packages include Docker/buildx/Compose, Git, network utilities and ShellCheck. Detailed observed versions are recorded in the final runtime inventory and assignment transcripts.

## External actions

No GitHub login, registry login, image publication, hosted workflow trigger or cloud provisioning was performed during resumed work. External credentials were not used. Public course repositories, official downloads, chart indexes, advisory databases and container images were retrieved anonymously.

An earlier attempt to clone the PDF's obsolete/mistyped public Kubernetes URL returned Authentication failed through the default Git helper path; no credential was supplied or deliberate sign-in performed. Subsequent public clones disabled interactive prompts. It caused no repository change or publication.

The PDF's external publication and real hosted/cloud execution requirements are identified per assignment. Local evidence is labeled separately. Private VM SSH/runtime secrets remain outside the submission and are never committed.
