# Executed commands and captured output

```bash
#!/usr/bin/env bash
set -euxo pipefail
cd final-devops-project
git add application docker kubernetes helm terraform .github security monitoring requirements.txt pytest.ini .dockerignore .gitleaks.toml .gitignore gitops/reconcile.py README.md
git commit -m 'Document verified local implementation and pending external stages'
git log --graph --oneline --all
git remote -v
git bundle create ../application-source.bundle --all
git bundle verify ../application-source.bundle

```

```text
Executed 2026-10-07T14:49:50.026865+05:30
Working directory: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-20-Session-21
Script: record-verified-source-history.sh
Exit status: 0

+ cd final-devops-project
+ git add application docker kubernetes helm terraform .github security monitoring requirements.txt pytest.ini .dockerignore .gitleaks.toml .gitignore gitops/reconcile.py README.md
+ git commit -m 'Document verified local implementation and pending external stages'
[main 25c495d] Document verified local implementation and pending external stages
 20 files changed, 205 insertions(+), 37 deletions(-)
 create mode 100644 application/README.md
 create mode 100644 docker/README.md
 create mode 100644 helm/README.md
 create mode 100644 kubernetes/README.md
 create mode 100644 monitoring/README.md
 create mode 100644 terraform/.terraform.lock.hcl
 create mode 100644 terraform/README.md
 create mode 100644 terraform/bootstrap.sh.tftpl
+ git log --graph --oneline --all
* 25c495d Document verified local implementation and pending external stages
* 88848c9 Add final DevOps application and local deployment configuration
+ git remote -v
+ git bundle create ../application-source.bundle --all
+ git bundle verify ../application-source.bundle
../application-source.bundle is okay
The bundle contains these 2 refs:
25c495d5f2bfef32c2817756c3b8b5160020819a refs/heads/main
25c495d5f2bfef32c2817756c3b8b5160020819a HEAD
The bundle records a complete history.
The bundle uses this hash algorithm: sha1

```
