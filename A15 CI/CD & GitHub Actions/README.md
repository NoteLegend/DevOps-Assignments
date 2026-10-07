# Assignment 15 — CI/CD & GitHub Actions

Sessions 16. [Exact PDF requirements](REQUIREMENTS.md).

## Objective

Prepare the PDF's calculator CI/CD demo and verify its build, tests, Docker image and workflows locally.

## Tasks Performed

Used the referenced 10-final-cicd-pipeline application and tests. Executed the calculator, unit tests and build script; built and ran its Docker image. Created separate CI and owner-gated delivery workflows and validated them with actionlint. Checked sensitive-file patterns locally.

## Tools Used

Python, pytest, Docker in the local Ubuntu VM and host actionlint.

## Implementation

CI's test and security jobs must succeed before build. Build uploads calculator-build. Delivery builds and publishes an image only after an owner-enabled GitHub environment gate. Workflows are prepared for this assignment as a standalone repository; in the combined submission they must be promoted to a repository-root `.github/workflows/` with paths adjusted.

## Verification

The local transcript contains actual unit-test results, calculator output, generated build artifact, workflow validation and container execution. It is local pipeline-equivalent verification, not a GitHub Actions run.

## Output / Results

`build/` holds calculator.py and the build script's timestamped information. There is no successful remote pipeline screenshot because no workflow was triggered.

## Troubleshooting / Observations

CI continuously verifies a change; CD delivers or deploys a verified artifact. A workflow contains jobs; jobs run on runners and contain steps. `needs` creates job dependencies. GitHub encrypted secrets are referenced by name, never supplied here. Artifacts retain build outputs across jobs/runs.

## External Steps Pending

BLOCKED: GitHub repository publication, actual CI/CD runs, successful Actions screenshots and registry authentication/push. Owner must publish the standalone project (or adjust combined-repository paths), configure registry secrets and a protected owner-approved-delivery environment, then manually trigger the workflows. Existing credentials were not used.

## Lessons Learned

Passing local tests and workflow validation does not prove hosted pipeline execution; those results are reported separately.

The referenced demo's regression exercise was run locally: changing addition to add one extra caused one test to fail; restoring the source made all five tests pass. The build ran only after restoration. This demonstrates the local gate without claiming a failed or successful hosted run.


## Commands Executed

The linked transcripts contain the exact executed scripts, stdout/stderr and exit status.

- [01-local-ci-build-workflow-check.md](evidence/01-local-ci-build-workflow-check.md)

## Screenshots

Command screenshots are browser views of real captured output, labeled as such; application screenshots show actual accessed pages.

![01-local-ci-build-workflow-check](screenshots/01-local-ci-build-workflow-check.png)
