# Cleanup and runtime scope

[Portfolio](README.md) · [Execution environment](EXECUTION_ENVIRONMENT.md)

## Original local exercises

The October-7 assignment application containers, Compose resources, Kubernetes namespaces/PVCs/static PV, Helm releases, controllers and port-forwards were cleaned up after evidence. Its Minikube profile and prepared Ubuntu VM were stopped. Runtime-secret files were removed, and the isolated exercise histories were preserved as verified portable bundles. That is a historical execution record.

## Separate Helpdesk cloud record

The October-16 Helpdesk evidence records authorized teardown of its EKS/VPC/ALB/workers and related resources after evidence publication. The original logs and residual checks remain with the separate capstone. They are not a teardown record for the still-unexecuted Assignment 17/18 Terraform projects.

## Review on 21 October

The pre-existing local `taskboard-local-control-plane` kind container was observed running. It was left untouched. No assignment services were started/stopped for this documentation review, and no AWS login or cloud-state operation was performed. Existing local application data and unrelated services were preserved.

User-local tools, reference checkouts and the prepared stopped VM remain outside the submission in the parent workspace’s `.local-tools/`. Real secret/runtime files, caches and nested Git metadata are excluded from the public assignment files. Current AWS billing or KMS deletion state was not re-queried; use the dated Helpdesk records rather than assuming a fresh account-wide cleanup check.
