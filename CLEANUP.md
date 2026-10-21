# Cleanup and runtime scope

[Portfolio](README.md) · [Execution environment](EXECUTION_ENVIRONMENT.md)

## Original local exercises

The October-7 assignment application containers, Compose resources, Kubernetes namespaces/PVCs/static PV, Helm releases, controllers and port-forwards were cleaned up after evidence. Its Minikube profile and prepared Ubuntu VM were stopped. Runtime-secret files were removed, and the isolated exercise histories were preserved as verified portable bundles. That is a historical execution record.

## Separate Helpdesk cloud record

The October-16 Helpdesk evidence records authorized teardown of its EKS/VPC/ALB/workers and related resources after evidence publication. The original logs and residual checks remain with the separate capstone. They are not a teardown record for the still-unexecuted Assignment 17/18 Terraform projects.

## Follow-up on 21 October

- Assignment 15's hosted containers were ephemeral GitHub-runner work; its image remains in GHCR as required delivery evidence.
- Assignment 16's `assignment16-ci` kind cluster was deleted in the hosted job after successful two-replica/HTTP verification. Its verified image remains in GHCR.
- Assignment 17/18 AWS cleanup is recorded by each `evidence/aws-lifecycle-summary.json`, actual destroy log and post-destroy absence checks. These records apply to their explicitly approved project resources, not unrelated account resources.
- Existing host containers/services were not stopped. The existing local Helpdesk environment is outside this portfolio's cleanup scope.

User-local tools, cached providers, private state/plans, archived earlier prototypes and the stopped prepared VM remain in the parent workspace's `.local-tools/`. The AWS temporary login profile is outside the submission. Credentials and cloud state are excluded from Git. No paid-plan upgrade was performed; settled usage reporting can lag.
