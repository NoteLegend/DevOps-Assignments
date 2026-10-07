# IAM — governance

IAM controls authentication and authorization for AWS resources. Users are identities; groups aggregate user permissions. Roles provide assumable identities with temporary credentials. JSON policies grant or deny actions on resources, optionally with conditions. Effective permissions combine applicable policies; an explicit deny overrides an allow.

Least privilege means granting only required actions on specific resources. Prefer federation and temporary role credentials, protect privileged access with MFA, avoid daily root usage and review unused access. Use roles for EC2 applications accessing S3, groups for a team's permissions and policies to restrict environment-specific access.

This is research only; no users, roles, policies or credentials were created or used.

Source: [AWS IAM guide](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html).
