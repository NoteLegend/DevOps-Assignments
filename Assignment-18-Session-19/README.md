# 18 · Cloud & Terraform in Action

**Session 19** · **Local work verified · required stages pending**

[Portfolio](../README.md) · [Exact requirements](REQUIREMENTS.md) · [Submission readiness](../SUBMISSION_READINESS.md)

> Prepare a VPC/subnet/Security Group/private EC2/S3 Terraform example with dependencies, outputs, a diagram and state documentation.

| Assignment record | Details |
| --- | --- |
| PDF source | DevOps Homework.pdf · pages 44, 45, 46 |
| Student | Rushi Jadhav · 10144 |
| Evidence | Successful transcripts: 1 · actual screenshots: 1 |
| Execution environment | Original local host / Ubuntu VM as identified in the transcripts |
| Review | 21 October 2026; historical output is retained unchanged |

## Requirement coverage

| PDF requirement | Implementation / document | Demonstrated behavior |
| --- | --- | --- |
| Cloud architecture definition | [terraform-project/](terraform-project/) | VPC, private subnet, Security Group, EC2 and protected S3 resources. |
| Inputs and outputs | [terraform-project/variables.tf](terraform-project/variables.tf) | Region/AMI/bucket/instance inputs and computed outputs. |
| Local validation | [evidence/01-local-cloud-configuration-validation.md](evidence/01-local-cloud-configuration-validation.md) | init, formatting checks and provider-schema validation completed. |
| Architecture and state explanation | [terraform-project/README.md](terraform-project/README.md) | Diagram and the difference between declared configuration and real cloud state. |

## Commands and verification

Key commands are shown below. The evidence records contain the complete executed scripts, exact resource names, output and exit status.

```bash
cd terraform-project
terraform init -backend=false -input=false
terraform fmt -check
terraform validate
```

[Reproduction and tooling](../REPRODUCING.md) explains the original VM adapters, native-tool use and portable Git bundles. Full executed scripts and stdout/stderr are linked below.

## Observed result

Local validation passed. The AMI and bucket inputs are still placeholders. This specific infrastructure project has no completed cloud provisioning or teardown evidence.

## Troubleshooting and observations

The separate capstone’s EKS deployment does not prove this EC2/S3 configuration was applied. The private EC2 example declares no public app endpoint.

## Submission status

**BLOCKED.** Provide approved regional AMI/bucket inputs and AWS access; approve plan/resource lifetime, then execute and capture this project’s plan → apply → inspect outputs/resources → destroy.

## Execution evidence

- [01 local cloud configuration validation](evidence/01-local-cloud-configuration-validation.md) — successful execution

## Screenshots

Actual application pages and explicitly labelled views of captured command output. Full text records preserve output omitted from an image.

<details>
<summary>Open the screenshot gallery (1 images)</summary>

![01 local cloud configuration validation](screenshots/01-local-cloud-configuration-validation.png)

</details>
