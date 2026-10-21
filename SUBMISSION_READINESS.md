# Final submission readiness

**Reviewed against all 54 PDF pages on 21 October 2026.**  
**Practical work verified: 15 assignments. Mandatory stages pending: 5 assignments.**

[Portfolio](README.md) · [Per-assignment status](ASSIGNMENT_STATUS.md) · [Audit results](AUDIT.md)

## What is already complete

Assignments **01–14 and 19** contain the requested implementation, successful recorded commands, useful screenshots and README documentation. Sessions 1 and 2 are together in Assignment 01; the submission contains exactly 20 assignment folders. The existing public assignment repository was checked anonymously; its current local refresh still needs owner publication.

The separate **Release Helpdesk** project is also more advanced than the old October-7 status files suggested. Its retained records show real GitHub Actions tests/build/scans/publication, SHA-tagged GHCR images, Terraform/EKS/ALB deployment, persistent PostgreSQL, HPA 2→4→2, Prometheus/Grafana, fault repair and authorized teardown. The [public successful run](https://github.com/NoteLegend/devOps-TaskBoard/actions/runs/38955563228) was verified anonymously. Those records are historical; no cloud credential or live AWS inspection was used for this review.

## Mandatory work still pending

| Assignment / PDF pages | Exact gap | Already available | Needed to close it |
| --- | --- | --- | --- |
| **15 · Session 16 · pp.33–34** | Successful hosted CI and CD for the referenced calculator, plus real successful pipeline screenshots/output | Calculator, five passing local tests, build artifact, Dockerfile, local Docker execution and validated workflows | Publish the prepared root workflows, approve the GitHub run and registry stage, configure the delivery environment; collect genuine hosted results |
| **16 · Session 17 · pp.35–37** | Hosted ordered build/test/SAST/SCA/secrets/image-scan/gate/push/deploy flow for this DevSecOps application | Actual local scanner reports, strict gate, identical scanned-image artifact checks, local Kubernetes deployment and workflows | Approved GitHub execution, registry credentials and an explicitly approved Kubernetes deployment target; retain pipeline/push/deployment evidence |
| **17 · Session 18 · pp.38–43** | This S3 demo has not run plan/apply/show/output/destroy | Exact Terraform files, local init/fmt/validate, all five required AWS research folders | Approved AWS profile/account/region, unique bucket name and permission to create/delete this bucket; actual lifecycle output/screenshots |
| **18 · Session 19 · pp.44–46** | This EC2/S3 project has not provisioned or demonstrated real resources/outputs/state/teardown | Validated VPC/subnet/SG/EC2/S3 configuration, diagram and documentation | Approved AWS access, valid regional AMI/bucket values and a resource/cost/lifetime approval; actual plan/apply/verify/destroy evidence |
| **20 · Session 21 · pp.49–54** | Complete one consistent project across all required stages | The exact-layout Flask project has local four-category scans/GitOps/Kubernetes/Helm/monitoring; the separate Helpdesk has real hosted/AWS evidence | Either finish the Flask project’s own approved hosted/registry/cloud stages, or add SAST and continuous GitOps, reconcile its existing dependency/secret-scan evidence with the PDF security gates, and supply the required final folder layout in Helpdesk and verify the changed project |

**A separate EKS deployment does not prove that the S3-only or EC2/S3 exercises ran.** Its successful Trivy stage also does not establish separate SAST, SCA and secret-scan pipeline stages. CI calling Helm is delivery; the missing GitOps requirement concerns ongoing reconciliation from versioned desired state ([OpenGitOps principles](https://opengitops.dev/)).

## Local repairs completed in this review

- Restored all 20 canonical folders and the correct assignment/session mapping. Removed the accidental extra directory level in the Hello World and CI assignment paths.
- Recreated every assignment README with a concise requirement matrix, source links, verification/results, dated evidence gallery and precise pending work.
- Restored working index/status/coverage links; corrected stale identity instructions using the supplied Rushi Jadhav / 10144 fields.
- Prepared four discoverable repository-root **manual** workflow entry points for Assignments 15, 16 and 20; adjusted working directories/artifact paths and isolated delivery namespaces. Local workflow validation passed; no run was triggered.
- Recognized the later Helpdesk cloud proof without relabelling it as proof for a different project.
- Rewrote the maintained project handover around practical requirements and final repository submission.
- Preserved original source requirements, actual evidence, recorded failures and the unrelated running local kind cluster.

## Access or approval actually needed

| Need | Applies to | Safe information to provide |
| --- | --- | --- |
| GitHub workflow and registry action approval | 15, 16, and the selected final-project route | Repository/project choice and explicit permission for the particular hosted run/publish action; configure secrets using the service’s secret store |
| Approved Kubernetes target | 16 and possibly 20 | Explicit local/remote target choice and namespace; do not provide kubeconfig secrets in chat |
| AWS resource lifecycle approval | 17 and 18; 20 only if choosing a new cloud execution route | Approved CLI **profile name**, account/region, allowed resources and resource lifetime/budget |
| Final source choice | 20 | Decide whether the exact-layout Flask project or Release Helpdesk is the one submitted as the complete capstone |

Do **not** paste AWS access keys, secret keys, passwords or tokens into chat or source. Prefer an approved temporary CLI session/profile; AWS documents [Identity Center CLI access](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso.html) and [temporary-credential practices](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html). Existing credentials are not permission for new operations. Nothing needs to be re-created in AWS merely to reuse the genuine, already-captured Helpdesk cloud evidence.

## Final owner handover

After the five remaining requirements are actually completed:

- [ ] Add genuine evidence and update each affected README/status; mark COMPLETE only after verification.
- [ ] Review the resulting files for credentials and confirm the static audit passes.
- [ ] Publish the reviewed local changes to the existing assignment repository yourself.
- [ ] Submit the public assignment URL and the selected final-project URL/evidence requested by the instructor.

Live AWS recreation and new hosted publishing were not authorized or performed during the review. The recorded cloud cleanup is dated October 16; current billing/cleanup state has not been re-queried.
