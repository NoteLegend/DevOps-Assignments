# Executed commands and captured output

```bash
#!/usr/bin/env bash
set -euxo pipefail
cd final-devops-project
git init -b main
git config user.name 'DevOps Practical'
git config user.email 'practical@example.invalid'
git add application docker kubernetes helm terraform .github security monitoring requirements.txt pytest.ini .dockerignore .gitleaks.toml .gitignore gitops/reconcile.py README.md
git commit -m 'Add final DevOps application and local deployment configuration'
git log --oneline -1
git remote -v

```

```text
Executed 2026-10-07T14:24:39.934478+05:30
Working directory: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-20-Session-21
Script: initialize-local-source-git.sh
Exit status: 0

+ cd final-devops-project
+ git init -b main
Initialized empty Git repository in /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-20-Session-21/final-devops-project/.git/
+ git config user.name 'DevOps Practical'
+ git config user.email practical@example.invalid
+ git add application docker kubernetes helm terraform .github security monitoring requirements.txt pytest.ini .dockerignore .gitleaks.toml .gitignore gitops/reconcile.py README.md
+ git commit -m 'Add final DevOps application and local deployment configuration'
[main (root-commit) 88848c9] Add final DevOps application and local deployment configuration
 38 files changed, 584 insertions(+)
 create mode 100644 .dockerignore
 create mode 100644 .github/workflows/pipeline.yml
 create mode 100644 .gitignore
 create mode 100644 .gitleaks.toml
 create mode 100644 README.md
 create mode 100644 application/__init__.py
 create mode 100644 application/app.py
 create mode 100644 application/tests/test_app.py
 create mode 100644 docker/Dockerfile
 create mode 100644 gitops/reconcile.py
 create mode 100644 helm/final-app/Chart.yaml
 create mode 100644 helm/final-app/templates/configmap.yaml
 create mode 100644 helm/final-app/templates/deployment.yaml
 create mode 100644 helm/final-app/templates/hpa.yaml
 create mode 100644 helm/final-app/templates/ingress.yaml
 create mode 100644 helm/final-app/templates/pvc.yaml
 create mode 100644 helm/final-app/templates/service.yaml
 create mode 100644 helm/final-app/values.yaml
 create mode 100644 kubernetes/configmap.yaml
 create mode 100644 kubernetes/deployment.yaml
 create mode 100644 kubernetes/hpa.yaml
 create mode 100644 kubernetes/ingress.yaml
 create mode 100644 kubernetes/pvc.yaml
 create mode 100644 kubernetes/secret.yaml.example
 create mode 100644 kubernetes/service.yaml
 create mode 100644 monitoring/alerts.yml
 create mode 100644 monitoring/prometheus.yml
 create mode 100644 pytest.ini
 create mode 100644 requirements.txt
 create mode 100644 security/README.md
 create mode 100644 security/bandit.yaml
 create mode 100644 security/gate.sh
 create mode 100644 terraform/main.tf
 create mode 100644 terraform/outputs.tf
 create mode 100644 terraform/provider.tf
 create mode 100644 terraform/terraform.tfvars
 create mode 100644 terraform/terraform.tfvars.example
 create mode 100644 terraform/variables.tf
+ git log --oneline -1
88848c9 Add final DevOps application and local deployment configuration
+ git remote -v

```
