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
