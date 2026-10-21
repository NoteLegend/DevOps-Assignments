# Reproducing and reviewing the work

[Portfolio](README.md) · [Execution environment](EXECUTION_ENVIRONMENT.md) · [Actual tool versions](TOOL_INVENTORY.md)

## Evidence and current execution

Most course execution records were captured on October 7 using host tools and the prepared Ubuntu VM, with the workspace shared as `/workspace`. Later Release Helpdesk records identify their own local kind or real AWS environment. The README refresh reviews retained outputs and source; it does not assert that all workloads were rerun today.

Actual execution transcripts contain the complete scripts, output and exit status. Browser views of that output are labelled explicitly; application images show real pages. Intentional failures and unsuccessful attempts remain alongside successful retries.

## Original workspace helpers

Historical verification scripts source `../../.local-tools/env.sh` and some use VM-only paths such as `/workspace` or `/tmp/devops-tools-venv`. Those are environment-specific reproduction helpers outside this submission, not universal setup commands for a fresh clone. The downloaded PDF/browser tooling and private runtime values are not included in the repository.

Use the portable application files, Dockerfiles, Compose files, Kubernetes manifests, Helm charts and Terraform configuration with native tools on another machine. Supply local secrets at runtime. Inspect the full script before rerunning a fault-injection or cleanup sequence. Do not aim any example at a remote context without separate approval.

## Workflow layout

The repository-root `.github/workflows` files are prepared for the combined submission and were linted locally. Nested workflow files remain standalone-project templates. A workflow file’s existence or a local lint result is not a real hosted run.

## Git history

[Portable Git bundles](LOCAL_GIT_HISTORY.md) preserve the isolated branch/cherry-pick/GitOps histories. Their original nested `.git` metadata is kept outside the submission to avoid accidental submodule entries. Restore a bundle into a separate local directory before inspecting/replaying its history. A GitOps controller needs an initialized desired-state repository; the working YAML records the final demonstrated version.

## Static submission check

`verify_submission.py` checks the assignment count/mapping, required deliverables, README/evidence/image links, syntax and final status consistency without contacting AWS, GitHub or Kubernetes. Run:

```bash
python verify_submission.py
```

PyYAML and Pillow enable additional YAML/image checks when available. Workflow lint and Terraform validation results are recorded separately. This static check does not replace the practical execution evidence.
