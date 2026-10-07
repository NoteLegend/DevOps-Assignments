#!/usr/bin/env bash
set -euxo pipefail
cd final-devops-project
git add application docker kubernetes helm terraform .github security monitoring requirements.txt pytest.ini .dockerignore .gitleaks.toml .gitignore gitops/reconcile.py README.md
git commit -m 'Document verified local implementation and pending external stages'
git log --graph --oneline --all
git remote -v
git bundle create ../application-source.bundle --all
git bundle verify ../application-source.bundle
