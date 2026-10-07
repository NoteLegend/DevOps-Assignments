# Owner-controlled external steps

No action in this file has been executed. Existing credentials are not approval. Remote publication is owner-deferred for the whole submission; real external execution specifically blocks Assignments 15, 16, 17, 18 and 20.

| Assignment | Prepared locally | Remaining owner action |
| --- | --- | --- |
| 15 | Calculator/tests/build/Docker/CI-CD workflows | Publish to GitHub, configure registry secrets/protected delivery environment, manually run CI and CD, capture real Actions run/artifact evidence |
| 16 | Tested/scanned app, image gate, local Kubernetes deployment and workflow | Approve/configure registry and deployment credentials, run hosted pipeline, push verified image, capture actual successful run/registry evidence |
| 17 | Validated S3 Terraform plus all five AWS research folders | Approve account/region/IAM access/bucket name; plan/review/apply, capture actual show/output/screenshots, then destroy approved resources |
| 18 | Validated VPC/subnet/Security Group/private EC2/S3 Terraform | Approve resources/costs and replace AMI/bucket values; plan/review/apply/verify/destroy with actual cloud evidence |
| 20 | Integrated tested/scanned local project, Kubernetes/Helm/monitoring/GitOps and validated IaC | Run approved hosted CI/CD and registry publication; separately approve cloud provisioning and collect genuine infrastructure output/screenshots |

Workflows inside assignments are prepared for those projects as standalone repositories. For this combined repository, put the selected workflow at repository-root `.github/workflows/` and adapt paths/working directories first. They intentionally use manual dispatch and protected deployment environments; publication alone does not activate a push-triggered pipeline.

Cloud Terraform input files contain nonsecret placeholders. Assignment 20 additionally needs an owner-published public image and an Ubuntu 24.04 amd64 AMI; its public HTTP route/Docker bootstrap is prepared but not executed. Replace those values before any approved plan. Supply credentials through an approved external configuration, never source or screenshots. Assignment 18 remains an isolated private-EC2 example; Assignment 20 separately prepares an approval-dependent public HTTP application target. Neither claims an actual cloud deployment.

## Publish the submission yourself

After replacing identity placeholders and reviewing status, create your own empty GitHub repository, then run these commands yourself. They are documentation only:

```bash
cd /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments
git init -b main
git add .
git commit -m "Add DevOps course practical assignments"
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git
git push -u origin main
```

Do not treat that publication as evidence that Actions or AWS stages have executed. Add their genuine results only after your approved runs.


## Exact remaining execution steps — owner only

1. Replace the two identity fields in IDENTITY.md. Replace the nonsecret registry/AMI/bucket placeholders for any approved remote stage.
2. For Assignments 15, 16 and 20, use each prepared standalone project or adapt its workflow to the combined repository root as described above. Configure the protected owner-approved delivery environment and required secret names, then manually dispatch the workflow through GitHub Actions. Record the real build/test/scan/artifact and delivery results. No remote run exists yet.
3. Registry publication must use the owner-authorized registry account. Assignments 16 and 20 transfer the scanned image artifact to delivery rather than rebuilding it. Remote Kubernetes delivery needs a separately approved target, its kubeconfig and applicable ingress/storage/metrics support; do not point those jobs at an unapproved cluster.
4. For Assignments 17, 18 and 20, review all proposed infrastructure and costs, provide approved AWS credentials outside source, and replace region-specific input values. The commands below are **unexecuted owner steps**, for the selected Terraform directory after that approval:

```bash
terraform init
terraform fmt -check
terraform validate
terraform plan -out=approved.tfplan
# Review the complete plan before provisioning.
terraform apply approved.tfplan
terraform show
terraform output
# Capture genuine required cloud evidence, then remove the approved resources.
terraform destroy
```

Assignment 17 requires S3 evidence; 18 requires the VPC/subnet/Security Group/EC2/S3 architecture; 20 additionally requires the actual final application reachable on its approved EC2 HTTP endpoint using the published public image. Keep Terraform state, plans, credential files and sensitive output out of the submission. Replace placeholders in tfvars only with appropriate nonsecret inputs; do not place AWS credentials there.
