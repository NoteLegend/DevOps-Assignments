## Objective

Practice Helm's full release lifecycle and complete the notes-chart mini project.

## Tasks Performed

Created and rendered a chart, linted it, added/searched the public Prometheus chart repository, installed the notes app, inspected list/status/get, upgraded to production values, introduced a bad image upgrade, inspected history and rolled back to the working revision. Verified the rollback and uninstalled the release.

## Tools Used

Helm 4.3.0, Kubernetes and kubectl in the local Ubuntu VM.

## Implementation

`demo-chart/` is produced by actual `helm create`. `mini-project/notes-chart/` packages Deployment, ConfigMap and Service using the course's dev/prod values. Rendered manifests are retained as evidence.

## Verification

Lint and template succeeded; installed/updated Pods were checked over HTTP and their ConfigMap environment was inspected. Release history records revisions; rollback restores the working image and ready replicas. Uninstall/list/get confirm resource cleanup.

## Troubleshooting / Observations

The bad image upgrade intentionally omits `--wait`, so a recorded deployed release status alone does not establish healthy Pods. Pod state and events show the image failure. Rollback to revision 2 creates a new revision with the known working configuration.

`create` scaffolds, `lint` checks chart structure, `template` renders, `install` creates a release, `upgrade` changes it, `history` lists revisions, `rollback` restores one, `get` inspects release data and `uninstall` removes it. Repository add/update/search discovers packages; it does not install or publish one.

## Output / Results

Actual revisions, images, replica counts and environment values are retained in the transcript; no hosted Helm service was used.

## Lessons Learned

Keep chart defaults and environment overrides distinct; verify workload readiness and HTTP behavior after each release operation.
