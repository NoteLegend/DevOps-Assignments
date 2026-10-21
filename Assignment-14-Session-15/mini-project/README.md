# Helm Mini Project · Notes Chart

[Assignment 14](../README.md) · [Chart defaults](notes-chart/values.yaml) · [Production overrides](notes-chart/values-prod.yaml)

> Package a configurable Nginx application and prove release changes through actual running behavior.

| Component | Purpose |
| --- | --- |
| Chart.yaml | Chart metadata |
| values.yaml / values-prod.yaml | Development and production settings |
| Deployment template | Application image, replicas and configuration injection |
| ConfigMap template | Environment-specific values |
| Service template | Stable access to selected Pods |

## Recorded lifecycle

The [full executed transcript](../evidence/01-helm-install-upgrade-rollback.md) covers chart lint/render, install, status/get/list, production upgrade, a second bad-image upgrade, inspection of the unhealthy Pods, rollback to revision 2, successful HTTP/configuration verification and uninstall. Actual screenshots are embedded in [the assignment gallery](../README.md#screenshots).

A deployed Helm revision alone is insufficient evidence of healthy Pods. The bad-image update was diagnosed from workload state and corrected by rollback; the restored application response was verified before cleanup.
