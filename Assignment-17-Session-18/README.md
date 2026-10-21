# 17 · Terraform & Infrastructure as Code

**Session 18** · **Local work verified · required stages pending**

[Portfolio](../README.md) · [Exact requirements](REQUIREMENTS.md) · [Submission readiness](../SUBMISSION_READINESS.md)

> Prepare the exact S3 Terraform project and document the five required AWS service families. Real S3 lifecycle execution remains outstanding.

| Assignment record | Details |
| --- | --- |
| PDF source | DevOps Homework.pdf · pages 38, 39, 40, 41, 42, 43 |
| Student | Rushi Jadhav · 10144 |
| Evidence | Successful transcripts: 1 · actual screenshots: 1 |
| Execution environment | Original local host / Ubuntu VM as identified in the transcripts |
| Review | 21 October 2026; historical output is retained unchanged |

## Requirement coverage

| PDF requirement | Implementation / document | Demonstrated behavior |
| --- | --- | --- |
| Exact Terraform project files | [terraform-s3-demo/](terraform-s3-demo/) | main, variables, outputs, provider, placeholder tfvars and README. |
| Local Terraform verification | [evidence/01-local-terraform-validation.md](evidence/01-local-terraform-validation.md) | init -backend=false, fmt, fmt -check and validate succeeded. |
| Five AWS research folders | [aws-services/](aws-services/) | IAM, EC2, S3, VPC, and DynamoDB/RDS with the PDF’s listed concepts. |

## Commands and verification

Key commands are shown below. The evidence records contain the complete executed scripts, exact resource names, output and exit status.

```bash
cd terraform-s3-demo
terraform init -backend=false -input=false
terraform fmt -check
terraform validate
```

[Reproduction and tooling](../REPRODUCING.md) explains the original VM adapters, native-tool use and portable Git bundles. Full executed scripts and stdout/stderr are linked below.

## Observed result

Provider-schema and configuration validation passed. The input bucket remains a public placeholder. There is no evidence this S3 demo completed plan, apply, show, output or destroy.

## Troubleshooting and observations

Validation establishes configuration correctness, not resource creation. Research does not require provisioning IAM users, databases or unrelated AWS services.

## Submission status

**BLOCKED.** Supply an approved AWS profile/account/region and unique bucket name; approve this demo’s plan, then execute and capture plan → apply → show/output → destroy for this exact S3 project.

## Execution evidence

- [01 local terraform validation](evidence/01-local-terraform-validation.md) — successful execution

## Screenshots

Actual application pages and explicitly labelled views of captured command output. Full text records preserve output omitted from an image.

<details>
<summary>Open the screenshot gallery (1 images)</summary>

![01 local terraform validation](screenshots/01-local-terraform-validation.png)

</details>
