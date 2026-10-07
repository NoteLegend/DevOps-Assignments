# Executed commands and captured output

```bash
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

```

```text
Executed 2026-10-07T13:11:18.734745+05:30
Working directory: /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-03-Session-04
Script: practice-git.sh
Exit status: 0

+ mkdir -p exercise-repo
+ cd exercise-repo
+ test '!' -d .git
+ git init -b main
Initialized empty Git repository in /home/rushixd/Wurk/Scaler/DevOps/DevOps-Assignments/Assignment-03-Session-04/exercise-repo/.git/
+ git config user.name 'DevOps Practical'
+ git config user.email devops-practical@example.invalid
+ printf 'version 1\n'
+ git add tracked.txt
+ git commit -m 'main 1: add tracked file'
[main (root-commit) 51567ac] main 1: add tracked file
 1 file changed, 1 insertion(+)
 create mode 100644 tracked.txt
+ printf 'version 2\n'
+ printf 'untracked demonstration\n'
+ git commit -m 'must fail without staged changes'
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   tracked.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	untracked.txt

no changes added to commit (use "git add" and/or "git commit -a")
+ echo 'commit -m requires staged changes (expected).'
commit -m requires staged changes (expected).
+ git commit -a -m 'main 2: tracked modification auto-staged'
[main f652f08] main 2: tracked modification auto-staged
 1 file changed, 1 insertion(+), 1 deletion(-)
+ git status --short
?? untracked.txt
+ git ls-files --error-unmatch untracked.txt
error: pathspec 'untracked.txt' did not match any file(s) known to git
Did you forget to 'git add'?
+ echo 'commit -a did not add the untracked file (expected).'
commit -a did not add the untracked file (expected).
+ git add untracked.txt
+ git commit -m 'main 3: explicitly stage new file'
[main 709814f] main 3: explicitly stage new file
 1 file changed, 1 insertion(+)
 create mode 100644 untracked.txt
+ git log --oneline
709814f main 3: explicitly stage new file
f652f08 main 2: tracked modification auto-staged
51567ac main 1: add tracked file
+ git switch -c feature
Switched to a new branch 'feature'
+ printf 'feature one\n'
+ git add feature-one.txt
+ git commit -m 'feature 1: independent change'
[feature 8573c5e] feature 1: independent change
 1 file changed, 1 insertion(+)
 create mode 100644 feature-one.txt
+ printf 'selected change\n'
+ git add selected.txt
+ git commit -m 'feature 2: selected change'
[feature b4c5394] feature 2: selected change
 1 file changed, 1 insertion(+)
 create mode 100644 selected.txt
++ git rev-parse HEAD
+ selected_commit=b4c53942adf80306774d12e94130d75201d2fd3c
+ printf 'feature three\n'
+ git add feature-three.txt
+ git commit -m 'feature 3: leave on branch'
[feature 1fe8a61] feature 3: leave on branch
 1 file changed, 1 insertion(+)
 create mode 100644 feature-three.txt
+ git log --oneline
1fe8a61 feature 3: leave on branch
b4c5394 feature 2: selected change
8573c5e feature 1: independent change
709814f main 3: explicitly stage new file
f652f08 main 2: tracked modification auto-staged
51567ac main 1: add tracked file
+ git switch main
Switched to branch 'main'
+ git cherry-pick b4c53942adf80306774d12e94130d75201d2fd3c
[main 2eaa8f2] feature 2: selected change
 Date: Wed Oct 7 13:11:18 2026 +0530
 1 file changed, 1 insertion(+)
 create mode 100644 selected.txt
+ cat selected.txt
selected change
+ test '!' -e feature-one.txt
+ test '!' -e feature-three.txt
+ git log --all --graph --oneline --decorate
* 1fe8a61 (feature) feature 3: leave on branch
* b4c5394 feature 2: selected change
* 8573c5e feature 1: independent change
| * 2eaa8f2 (HEAD -> main) feature 2: selected change
|/  
* 709814f main 3: explicitly stage new file
* f652f08 main 2: tracked modification auto-staged
* 51567ac main 1: add tracked file
+ git status --short
+ git bundle create ../exercise-history.bundle --all
+ git bundle verify ../exercise-history.bundle
../exercise-history.bundle is okay
The bundle contains these 3 refs:
1fe8a61922b102e386b860bd57551304deea8501 refs/heads/feature
2eaa8f2069a4b52b9f6e6dada9da7abda8c05e7d refs/heads/main
2eaa8f2069a4b52b9f6e6dada9da7abda8c05e7d HEAD
The bundle records a complete history.
The bundle uses this hash algorithm: sha1

```
