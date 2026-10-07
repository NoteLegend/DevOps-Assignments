## Objective

Inject configuration and a runtime-only Secret, route HTTP through a real local Ingress controller, and diagnose a Secret encoding error.

## Tasks Performed

Applied the ConfigMap and Deployment; created a Secret from a temporary file outside the submission; checked environment injection without printing its value. Enabled Minikube's ingress-nginx controller and applied host routing. Reproduced the course trailing-newline mistake and corrected the source, recreated the Secret, restarted the Deployment and verified the newline was gone.

## Tools Used

Kubernetes, Minikube, kubectl and curl in the local Ubuntu VM.

## Implementation

`manifests/` holds configuration, workload, Service and Ingress. `secret.yaml.example` is a placeholder template. Actual Secret data stays in assignment runtime storage and is removed from Kubernetes during cleanup.

## Verification

Rollout readiness, public ConfigMap value, hidden Secret-presence checks, before/after newline assertions and the Ingress host HTTP response are recorded in the transcript.

## Output / Results

The application returns the ConfigMap message through the Ingress. No Secret value appears in evidence or submission files.

## Troubleshooting / Observations

A newline introduced by `echo` survives base64 encoding; base64 is encoding, not encryption. The diagnostic checks the actual injected value for a trailing newline without displaying it. Writing without a newline and recreating the Secret fixes the value; environment injection requires replacement Pods. This reproduces the source-value error from the course's secret-base64-gotcha exercise, without claiming a database authentication test.

An Ingress defines HTTP host/path rules; an Ingress controller watches those objects and implements traffic routing. A Service alone does not interpret Ingress rules.

## Lessons Learned

Verify the bytes behind a Secret and the readiness of the controller independently from the application's manifest.
