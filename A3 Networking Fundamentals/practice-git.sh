#!/usr/bin/env bash
set -euxo pipefail
mkdir -p exercise-repo
cd exercise-repo
test ! -d .git
git init -b main
git config user.name 'DevOps Practical'
git config user.email 'devops-practical@example.invalid'
printf 'version 1\n' > tracked.txt
git add tracked.txt
git commit -m 'main 1: add tracked file'
printf 'version 2\n' > tracked.txt
printf 'untracked demonstration\n' > untracked.txt
if git commit -m 'must fail without staged changes'; then exit 1; else echo 'commit -m requires staged changes (expected).'; fi
git commit -a -m 'main 2: tracked modification auto-staged'
git status --short
if git ls-files --error-unmatch untracked.txt; then exit 1; else echo 'commit -a did not add the untracked file (expected).'; fi
git add untracked.txt
git commit -m 'main 3: explicitly stage new file'
git log --oneline
git switch -c feature
printf 'feature one\n' > feature-one.txt
git add feature-one.txt
git commit -m 'feature 1: independent change'
printf 'selected change\n' > selected.txt
git add selected.txt
git commit -m 'feature 2: selected change'
selected_commit=$(git rev-parse HEAD)
printf 'feature three\n' > feature-three.txt
git add feature-three.txt
git commit -m 'feature 3: leave on branch'
git log --oneline
git switch main
git cherry-pick "$selected_commit"
cat selected.txt
test ! -e feature-one.txt
test ! -e feature-three.txt
git log --all --graph --oneline --decorate
git status --short
git bundle create ../exercise-history.bundle --all
git bundle verify ../exercise-history.bundle
